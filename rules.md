# Research Engine Rules & Style

## Content
Accessible, engaging long-form writing on topics of genuine interest. The target register is the tone of a well-read friend explaining something they find fascinating — not a textbook, not a news article, not a Wikipedia summary. Every piece should leave the reader understanding something they didn't before, and wanting to know more.

## Format
- Pieces: 2000–3600 words; shorter only if the topic genuinely cannot support more depth
- Each piece is self-contained
- Save to `pieces/working-title_DD-MM-YY.txt`
- Plain text: title on the first line (no # prefix), blank line, then body
- The **final lines of every piece** must be (no markdown, plain text, preceded by a blank line):
  Topics: [topics used in this piece]
  Pending approval: [only related topics that are an offshoot of or directly relevant to the subject of this piece — omit unrelated pending topics; None if nothing qualifies]

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
- Note the intended angle before moving to Phase 2

### 2. Research
- Web search the selected topic specifically and thoroughly — look for key facts, surprising angles, good analogies already in use, recent developments, and the thing most people get wrong
- Identify 2–4 related topic candidates from research; add them to the Related Topics section of `topics.md`
- Confirm or revise the angle and hook before writing

### 3. Writing
- Write the piece and save to `pieces/working-title_DD-MM-YY.txt`
- Remove the written topic from the Main Topics list and Draw Index in `topics.md`; update the pool count
- Flag any related topics that performed well for owner review

## Topic rules
- Each piece takes one main topic as its primary focus
- A related topic may appear as a secondary angle or connection — it should serve the main topic, not compete with it
- A related topic graduates to the main list when the owner confirms it
- Aim for variety across sessions — do not return to the same topic two sessions in a row
