#!/bin/bash
# Research engine automated session.
# Split into separate invocations to keep each response bounded and avoid socket timeouts:
#   Phase 1  — selection; writes selected topic + description to selected_topic.txt
#   Phase 2  — research; appends angle/hook plan to selected_topic.txt
#   Phase 3  — writing; reads selected_topic.txt only; saves piece, updates topics.md

cd "/home/coco/Documents/Claude/research engine"

LOG="/home/coco/Documents/Claude/research engine/session.log"
CLAUDE="/home/coco/.local/bin/claude"
SYSTEM="In this session you are a curious, well-read generalist writer with a gift for making complex ideas accessible. Write with clarity and warmth, use analogy freely, and find the angle that makes each subject genuinely interesting to a non-expert reader. Prioritise illumination and voice over comprehensiveness."

log() { echo "[$(date '+%H:%M:%S')] $1" >> "$LOG"; }

# Run a claude invocation, log token stats, then log result text.
run_claude() {
    local label="$1"; shift
    local out
    out=$("$@" --output-format json 2>&1)
    local stats
    stats=$(echo "$out" | python3 -c "
import sys, json
try:
    d = json.loads(sys.stdin.read())
    u = d.get('usage', {})
    print('in={} cached={} out={} cost=\${:.5f} dur={}ms'.format(
        u.get('input_tokens','?'),
        u.get('cache_read_input_tokens', 0),
        u.get('output_tokens','?'),
        d.get('total_cost_usd', 0),
        d.get('duration_ms','?')
    ))
except Exception as e:
    print('stats unavailable: {}'.format(e))
" 2>/dev/null)
    log "$label: $stats"
    echo "$out" | python3 -c "
import sys, json
try:
    print(json.loads(sys.stdin.read()).get('result', ''))
except:
    sys.stdout.write(sys.stdin.read())
" >> "$LOG" 2>/dev/null
}

log "=== Session start ==="

# Clean up session artifact from any previous run
rm -f selected_topic.txt

# Sync read folder: pull GDrive read state to local before the session begins.
log "Syncing read folder from GDrive"
mkdir -p "pieces/read"
rclone copy gdrive:"Research Engine/read/" "pieces/read/" >> "$LOG" 2>&1
for f in pieces/read/*.txt; do
    [ -f "$f" ] || continue
    base="$(basename "$f")"
    [ -f "pieces/$base" ] && rm "pieces/$base"
done

# Phase 1: Selection — reads topics.md only; writes selected_topic.txt
log "Phase 1: Selection"
run_claude "Phase 1" $CLAUDE --model claude-haiku-4-5-20251001 \
  --max-tokens 1500 \
  --append-system-prompt "$SYSTEM" \
  --permission-mode bypassPermissions \
  -p "Research engine session — Phase 1 (Selection) only. Read CLAUDE.md and the '### 1. Selection' section of rules.md only. Read topics.md. Check the last entry of completed.md for recency — avoid a topic written last session. Select a topic and write the selected topic name and its full description to selected_topic.txt. Your output goes to a log — the next phase reads selected_topic.txt, not your text. Confirm in one line what was selected. Nothing else."

# Phase 2: Research — reads selected_topic.txt only; appends angle plan
log "Phase 2: Research"
run_claude "Phase 2" $CLAUDE --model claude-sonnet-4-6 \
  --max-tokens 4000 \
  --append-system-prompt "$SYSTEM" \
  --permission-mode bypassPermissions \
  -p "Research engine session — Phase 2 (Research) only. Read CLAUDE.md and the '### 2. Research' section of rules.md only. Read selected_topic.txt for the topic — do not re-read topics.md. Web search the topic: 4–5 targeted searches maximum, stop when you have enough. Append a structured angle plan to selected_topic.txt (Hook / Angle / Key facts / Analogy) as specified in rules.md. Your output goes to a log — Phase 3 reads selected_topic.txt, not your text. Confirm in one line when done. Nothing else."

# Phase 3: Writing — reads selected_topic.txt only; saves piece and updates topics.md
log "Phase 3: Writing"
run_claude "Phase 3" $CLAUDE --model claude-sonnet-4-6 \
  --max-tokens 8500 \
  --append-system-prompt "$SYSTEM" \
  --permission-mode bypassPermissions \
  -p "Research engine session — Phase 3 (Writing) only. Read CLAUDE.md and the Content, Style, and Format sections of rules.md (stop before the Session phases section). Read selected_topic.txt for the topic, description, and angle/hook plan — do not re-read topics.md. Write the full piece (2000–3600 words); save to pieces/; upload to GDrive: rclone copy the saved file to gdrive:\"Research Engine\". Then: (1) update topics.md — remove the written topic from the Main Topics list and Draw Index, update the pool count; (2) append one line to completed.md in the existing format: '- **YYYY-MM-DD** — *Title* — brief description'. Your output goes to a log only. Confirm in one line when done. Nothing else."

log "=== Session complete ==="
