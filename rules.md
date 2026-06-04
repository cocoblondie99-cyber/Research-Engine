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
- **Open with a hook** — a striking fact, a concrete scene, an unexpected question; earn the reader's attention before explaining anything
- **Explain complexity with analogy** — find a familiar comparison for every abstract concept; use it consistently and build on it; digital security becomes locks, doors, and rooms; a neural network becomes a pattern-matching librarian who has read everything but understood nothing; market forces become water finding its own level
- **Build understanding progressively** — introduce ideas in the order the reader needs them; never assume prior knowledge of the topic
- **Stay specific** — a precise example or a real number is always more interesting than a vague generalisation
- **Linger on what's surprising** — if something is counterintuitive or strange, slow down and stay with it; that's where the piece earns its keep
- **End with resonance** — not a summary; a closing thought that gives the piece weight; what this means, why it matters, what it changes about how you see something

## Session phases (run in order each session)

### 1. Selection
- Generate a random number within the Main Topics pool count in `topics.md`; look up the name in the Draw Index; read only that entry's full description — anything in the list is available
- Check recency against completed pieces in `topics.md` — avoid a topic written last session; regenerate if needed
- Write the selected topic name and its full description to `selected_topic.txt` — one line for the name, then the full entry text; Phase 2 and 3 read this instead of re-deriving from `topics.md`

### 2. Research
- Read `selected_topic.txt` for the topic and its description — do not re-read `topics.md`
- Web search the selected topic specifically and thoroughly — look for key facts, surprising angles, good analogies already in use, recent developments, and the thing most people get wrong
- Write a brief angle and hook plan (2–4 sentences) to `selected_topic.txt` appended after the topic entry — Phase 3 reads this to begin writing without repeating the research pass

### 3. Writing
- Read `selected_topic.txt` for the topic, description, and angle/hook plan — do not re-read `topics.md`
- Read `rules.md` Content and Style sections and the Format section — do not re-read the phase instructions
- Write the piece and save to `pieces/working-title_DD-MM-YY.txt`; upload to GDrive
- Remove the written topic from the Main Topics list and Draw Index in `topics.md`; update the pool count

## Topic rules
- Each piece takes one main topic as its primary focus
- Aim for variety across sessions — do not return to the same topic two sessions in a row
- Suggested topics appear in the piece footer only — do not write them anywhere else; the owner adds them to the main pool manually if wanted
