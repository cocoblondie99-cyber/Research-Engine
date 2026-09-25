# Research Engine — Runbook

*How to run this engine. The scheduler decides **when**; this file is the authority on **how**.*

**If you are the scheduler loop (or a subagent it spawned): read this file and follow it exactly.**

> **PAUSED as of 2026-08-23** — the owner is behind on reading existing pieces. When the `RESEARCH` slot is due, do **not** run the phases below. Instead log the skip and record the slot so it does not re-trigger the same day:
> ```bash
> echo "[$(date '+%H:%M:%S')] RESEARCH skipped — paused by owner request (behind on reading)" >> "/home/coco/Documents/Claude/research engine/session.log"
> ```
> then append `RESEARCH YYYY-MM-DD HH:MM` to `scheduler/state.txt`.
> To resume: delete this block, and the matching pause notes in the root `CLAUDE.md` and `scheduler/loop-prompt.md`.

**Research persona — prepend to every agent prompt in this file:**
> Your role for this task: you are a skilled explanatory writer producing long-form, accessible pieces for an intelligent general reader. Prioritise clarity, concrete grounding, and genuine insight over comprehensiveness.

---

## Running RESEARCH

**Research persona — prepend to every research agent prompt:**
> Your writing role for this task: you are a curious, well-read generalist writer with a gift for making complex ideas accessible. Write with clarity and warmth, use analogy freely, and find the angle that makes each subject genuinely interesting to a non-expert reader. Prioritise illumination and voice over comprehensiveness.

### Pre-flight (single Bash call)
```bash
cd "/home/coco/Documents/Claude/research engine"
rm -f selected_topic.txt
mkdir -p pieces/read
rclone copy gdrive:"Research Engine/read/" pieces/read/
for f in pieces/read/*.txt; do
    [ -f "$f" ] || continue
    base="$(basename "$f")"
    [ -f "pieces/$base" ] && rm "pieces/$base"
done
TOPIC_COUNT=$(grep -oP 'Main Topics — \K\d+' topics.md 2>/dev/null || echo 0)
TOPIC_PICK=$(( TOPIC_COUNT > 0 ? RANDOM % TOPIC_COUNT + 1 : 0 ))
echo "TOPIC_COUNT=$TOPIC_COUNT TOPIC_PICK=$TOPIC_PICK"
```

If TOPIC_COUNT is 0, abort immediately — do not spawn any phases. Log the skip, append `RESEARCH YYYY-MM-DD HH:MM` to state.txt so the slot does not re-trigger today, and flag the empty pool to the owner (once per day — the flag line is idempotent by date):
```bash
echo "[$(date '+%H:%M:%S')] RESEARCH skipped — topic pool is empty" >> "/home/coco/Documents/Claude/research engine/session.log"
grep -q "$(date '+%Y-%m-%d') — topic pool empty" "/home/coco/Documents/Claude/research engine/admin_review.md" 2>/dev/null || \
  echo "- $(date '+%Y-%m-%d') — topic pool empty: daily research slot is skipping; add topics to topics.md (\"Add to topics\")" >> "/home/coco/Documents/Claude/research engine/admin_review.md"
```

After each research phase agent returns, log to the research engine log (Bash):
```bash
echo "[$(date '+%H:%M:%S')] Research Phase {N} ({model}): tokens={subagent_tokens} dur={duration_ms}ms" >> "/home/coco/Documents/Claude/research engine/session.log"
```
Log `=== Session complete ===` after Phase 3.

### Phase 1 — spawn Agent(model="haiku")
Prompt (prepend research persona, then):
```
Research engine session — Phase 1 (Selection) only. Working directory: /home/coco/Documents/Claude/research engine — cd there first. Read the '### 1. Selection' section of rules.md, then topics.md. If the Main Topics pool count is 0, write the single word EMPTY to selected_topic.txt and stop — do not attempt to select. Otherwise: the pre-rolled selection is Draw Index entry number {TOPIC_PICK} — use it; do not choose a different entry unless it matches the last entry of completed.md (written last session), in which case use entry {TOPIC_PICK}+1 (wrapping to 1 past the end). Write the selected topic name and its full description to selected_topic.txt. Keep your response brief — confirm in one line what was selected (or that the pool is empty).
```

After Phase 1 agent returns: check selected_topic.txt — if it is missing or its entire content is `EMPTY`, log and abort this slot. Do not spawn Phase 2 or Phase 3:
```bash
echo "[$(date '+%H:%M:%S')] RESEARCH aborted — Phase 1 found no topics" >> "/home/coco/Documents/Claude/research engine/session.log"
```

### Phase 2 — spawn Agent(model="sonnet")
Prompt (prepend research persona, then):
```
Research engine session — Phase 2 (Research) only. Working directory: /home/coco/Documents/Claude/research engine — cd there first. Read CLAUDE.md and the '### 2. Research' section of rules.md. Read selected_topic.txt for the topic — do not re-read topics.md. Web search the topic: 4–5 targeted searches maximum, stop when you have enough. Append a structured angle plan to selected_topic.txt (Hook / Angle / Key facts / Analogy) as specified in rules.md. Confirm in one line when done.
```

### Phase 3 — spawn Agent(model="sonnet")
Prompt (prepend research persona, then):
```
Research engine session — Phase 3 (Writing) only. Working directory: /home/coco/Documents/Claude/research engine — cd there first. Read CLAUDE.md and the Content, Style, and Format sections of rules.md (stop before the Session phases section). Read selected_topic.txt for the topic, description, and angle/hook plan — do not re-read topics.md. Write the full piece (2000–3600 words); save to pieces/; upload to GDrive: rclone copy the saved file to gdrive:"Research Engine". Then: (1) update topics.md — remove the written topic from the Main Topics list and Draw Index, update the pool count; (2) append one line to completed.md in the existing format: '- **YYYY-MM-DD** — *Title* — brief description'. Confirm in one line when done.
```

---
