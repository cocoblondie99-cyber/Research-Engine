# Research Engine Rules & Style

## Content
Accessible, engaging long-form writing on topics of genuine interest. The target register is the tone of a well-read friend explaining something they find fascinating — not a textbook, not a news article, not a Wikipedia summary. Every piece should leave the reader understanding something they didn't before, and wanting to know more.

## Format
- Pieces: 2000–3600 words; shorter only if the topic genuinely cannot support more depth
- Each piece is self-contained
- Save to `pieces/topic-slug_DD-MM-YY.txt` — the slug must be a plain descriptive name of the actual topic (e.g. `docker-and-containers_28-05-26.txt`, `dhcp-lease-and-scope-management_02-06-26.txt`); never use a literary or metaphorical title as the filename
- Plain text: title on the first line (no # prefix), blank line, then body
- The **final lines of every piece** must be (no markdown, plain text, preceded by a blank line):
  Topics: [topics used in this piece]
  Suggested topics: [2–4 related topics surfaced during research — brief name only, one line; owner flags any they want added to the main pool]

## Style
- **Open with a hook** — a striking fact, a concrete scene, an unexpected question; earn the reader's attention before explaining anything; **rotate the hook form across pieces** — check the angle plan against the last few entries in `completed.md` descriptions: if recent pieces opened on a fact, open on a scene or a question this time
- **Titles: reach before defaulting** — "The [Noun] That [Verb]" constructions (*The Solution That Stayed*, *The Building That Was Never Finished*) are heavily represented in the existing catalogue; before settling on one, try other forms: a concrete image from the piece, a question, a number or measurement, a fragment of the central analogy, a plain descriptive title; check the last few titles in `completed.md` and do not repeat their construction
- **Explain complexity with analogy** — find a familiar comparison for every abstract concept; use it consistently and build on it; the examples here (digital security as locks, doors, and rooms; a neural network as a pattern-matching librarian; market forces as water finding its level) are **illustrations of the technique, not stock to reuse** — every piece invents its own central analogy from its own material; an analogy that has appeared in a previous piece or in this rules file is spent
- **Build understanding progressively** — introduce ideas in the order the reader needs them; never assume prior knowledge of the topic
- **Stay specific** — a precise example or a real number is always more interesting than a vague generalisation
- **Linger on what's surprising** — if something is counterintuitive or strange, slow down and stay with it; that's where the piece earns its keep
- **End with resonance** — not a summary; a closing thought that gives the piece weight; what this means, why it matters, what it changes about how you see something

## Session phases (run in order each session)

### 1. Selection
- **Automated sessions**: the scheduler loop pre-rolls a random Draw Index number and passes it in the Phase 1 prompt — use that entry; look up the name in the Draw Index and read only that entry's full description
- **Manual sessions** (no pre-roll provided): generate a random number within the Main Topics pool count in `topics.md`; look up the name in the Draw Index; read only that entry's full description — anything in the list is available
- Check the last entry in `completed.md` for recency — avoid a topic written last session; use the next entry (wrapping) if the pre-rolled one was written last session
- Write the selected topic name and its full description to `selected_topic.txt` — one line for the name, then the full entry text; Phase 2 and 3 read this instead of re-deriving from `topics.md`
- **Handover:** your text output goes to a log only; Phase 2 reads `selected_topic.txt`, not you. One line confirming the selection is enough.

### 2. Research
- Read `selected_topic.txt` for the topic and its description — do not re-read `topics.md`
- Web search the topic: 4–5 targeted searches maximum; stop when you have enough for the angle plan
- Append a structured angle plan to `selected_topic.txt` after the topic entry, in this exact format:
  ```
  Hook: [the opening fact, scene, or question that earns the reader's attention]
  Angle: [what makes this treatment of the topic distinctive — the through-line]
  Key facts: [2–3 bullet points — the most surprising or useful research findings]
  Analogy: [the central comparison to sustain through the piece, or "none"]
  ```
- **Handover:** your text output goes to a log only; Phase 3 reads `selected_topic.txt`, not you. One line confirming the plan is appended is enough.

### 3. Writing
- Read `selected_topic.txt` for the topic, description, and angle/hook plan — do not re-read `topics.md`
- Read `rules.md` Content and Style sections and the Format section — do not re-read the phase instructions
- Write the piece and save to `pieces/working-title_DD-MM-YY.txt`; upload to GDrive
- Remove the written topic from the Main Topics list and Draw Index in `topics.md`; update the pool count
- **Handover:** your text output goes to a log only. One line confirming the piece title, filename, and that housekeeping is done is enough.

## Topic rules
- Each piece takes one main topic as its primary focus
- Aim for variety across sessions — do not return to the same topic two sessions in a row
- Suggested topics appear in the piece footer only — do not write them anywhere else; the owner adds them to the main pool manually if wanted
