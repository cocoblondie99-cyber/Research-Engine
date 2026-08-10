# Research Engine

## What This Project Is
An autonomous research writing engine that produces accessible, engaging long-form pieces on topics of interest. At 16:33 daily, Claude runs a three-phase session: topic selection → research → writing.

## Project Structure
- `CLAUDE.md` — this file; session protocol and project overview
- `rules.md` — style guide and full session phase instructions
- `topics.md` — active main topics (owner-curated); draw index only, no completed pieces
- `completed.md` — completed pieces list; Phase 1 reads last entry only for recency; Phase 3 appends after writing
- `devlog.md` — historical session notes; not read by any phase
- `admin_review.md` — owner review inbox; the scheduler loop flags empty-pool skips here; owner clears entries after acting
- `pieces/` — completed pieces, one file each, named `topic-slug_DD-MM-YY.txt` (e.g. `docker-and-containers_28-05-26.txt`)
- `run_session.sh` — legacy cron launcher; no longer called (scheduler /loop handles preflight since 2026-06-13); retained as reference only
- `session.log` — output log from automated runs
- `selected_topic.txt` — session artifact: topic + description written by Phase 1, angle plan appended by Phase 2, read by Phase 3; deleted at session start

## Session Protocol
Each phase runs as a separate invocation. Read only what each phase requires.

- **Phase 1 — Selection**: reads `topics.md` + Phase 1 rules; writes `selected_topic.txt`
- **Phase 2 — Research**: reads `selected_topic.txt` only; web searches; appends angle plan to `selected_topic.txt`
- **Phase 3 — Writing**: reads `selected_topic.txt` + Content/Style/Format rules only; writes piece; updates `topics.md`; appends to `completed.md`

## GDrive Upload — Always Required
After saving each piece, upload only that specific file — do **not** copy the whole `pieces/` directory:

```
rclone copy "/home/coco/Documents/Claude/research engine/pieces/[filename].txt" gdrive:"Research Engine"
```

Uploading the whole folder re-uploads files the owner has moved to the "read" subfolder on GDrive, creating duplicates.

## Read Folder Sync
`run_session.sh` syncs the read folder at the start of each automated session:
- Copies everything from `gdrive:"Research Engine/read/"` to local `pieces/read/`
- Removes from `pieces/` root any file that is now in `pieces/read/`

This mirrors the owner's GDrive organisation locally and prevents re-uploads. Local `pieces/read/` is not uploaded to GDrive — it is a local archive only.

## Important Notes
- Every piece must end with a topic footer: *Topics: [...] — Suggested: [2–4 topic names surfaced during research]*
- Suggested topics appear in the piece footer only — do not write them to topics.md; owner adds them manually if wanted
- Write for a curious non-expert: engaged, specific, and generous with analogy
- This is an explanatory writing session, not an engineering task — prioritise clarity, voice, and genuine illumination over comprehensiveness

## Dev Notes
- Project created 2026-05-25
- 2026-07-03 — fixes ported from fluff engine overhaul: Phase 1 topic selection now uses a bash pre-rolled number passed by the scheduler loop (removes model selection bias); empty-pool skips now flag to `admin_review.md` once per day (pool had been empty and skipping silently since 2026-06-19); rules.md gained title-variety rule ("The [Noun] That [Verb]" saturated), hook-form rotation, and analogies-are-illustrations-not-stock rule
- Scheduler loop triggers at 16:33 daily (previously cron at 05:03 and 17:03 — migrated to /loop 2026-06-13)
- Uploads to Google Drive folder "Research Engine" after each session
- Pieces per session: 1; word count range: 2000–3600 words
- Session history in `devlog.md` (not read by any phase)
