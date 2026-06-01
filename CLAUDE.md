# Research Engine

## What This Project Is
An autonomous research writing engine that produces accessible, engaging long-form pieces on topics of interest. At scheduled intervals (5:03am and 5:03pm), Claude runs a three-phase session: research → topic selection → writing.

## Project Structure
- `CLAUDE.md` — this file; session protocol and project overview
- `rules.md` — style guide and full session phase instructions
- `topics.md` — main topics (owner-curated) and related topics (auto-suggested, pending confirmation)
- `pieces/` — completed pieces, one file each, named `YYYY-MM-DD_working-title.txt`
- `run_session.sh` — cron launcher
- `session.log` — output log from automated runs

## Session Protocol
Read this file first, then follow these steps in order:

1. **Read `rules.md`** — understand the style expectations and phase rules
2. **Read `topics.md`** — note available main topics, related topics, and completed pieces; avoid repeating a topic covered recently
3. **Scan `pieces/`** — read existing filenames and topic footers to track what's been written
4. **Run Phase 1 — Research**: web search the selected topic(s); add 2–4 related topic candidates to `topics.md`
5. **Run Phase 2 — Selection**: choose 1 topic to write this session; note the angle and hook found in research
6. **Run Phase 3 — Writing**: write the piece; save to `pieces/`; update `topics.md`

## Folder Routing
Most pieces save to `pieces/`. The exception is the **Modern Witchcraft** category — those pieces save to `pieces/modern witchcraft/` so they sync to their own subfolder on Google Drive.

## GDrive Upload — Always Required
After saving each piece, upload only that specific file — do **not** copy the whole `pieces/` directory:

```
rclone copy "/home/coco/Documents/Claude/research engine/pieces/[filename].txt" gdrive:"Research Engine"
```

For Modern Witchcraft pieces (saved to `pieces/modern witchcraft/`):

```
rclone copy "/home/coco/Documents/Claude/research engine/pieces/modern witchcraft/[filename].txt" gdrive:"Research Engine/modern witchcraft"
```

Uploading the whole folder re-uploads files the owner has moved to the "read" subfolder on GDrive, creating duplicates.

## Read Folder Sync
`run_session.sh` syncs the read folder at the start of each automated session:
- Copies everything from `gdrive:"Research Engine/read/"` to local `pieces/read/`
- Removes from `pieces/` root any file that is now in `pieces/read/`
- Same for `gdrive:"Research Engine/modern witchcraft/read/"` → `pieces/modern witchcraft/read/`

This mirrors the owner's GDrive organisation locally and prevents re-uploads. Local `pieces/read/` is not uploaded to GDrive — it is a local archive only.

## Important Notes
- Every piece must end with a topic footer: *Topics: [...] — Related: [...] or None*
- Related topics need owner confirmation before moving to the main list — flag them clearly after use
- Write for a curious non-expert: engaged, specific, and generous with analogy
- This is an explanatory writing session, not an engineering task — prioritise clarity, voice, and genuine illumination over comprehensiveness

## Dev Notes
- Project created 2026-05-25
- Cron triggers at 05:03 and 17:03 — one hour before the fluff engine
- Uploads to Google Drive folder "Research Engine" after each session

### 2026-05-27 — Output changes
- **Pieces per session**: reduced from 4–5 to 1
- **Word count range**: doubled from 1000–1800 to 2000–3600 words per piece

### 2026-05-29 — Word count reset
- **Word count range**: reverted from 4000–7200 back to 2000–3600 to match the fluff engine

### 2026-05-28 — Session notes
- Wrote *The Model That Never Calls Home* — self-hosted AI for organisations
- 3 new related topics added: vector databases and embeddings, LLM fine-tuning for organisations, AI at the edge
- Wrote *The Box That Ate the Internet* — Docker and containers
- 3 new related topics added: Kubernetes and container orchestration, Container security, CI/CD and DevOps pipelines

### 2026-05-29 — Session notes
- Wrote *The Body That Learned to Brace* — childhood emotional neglect: nervous system effects
- 4 new related topics added: Co-regulation and the developing brain, Vagal tone and heart rate variability, Somatic experiencing and body-based trauma therapy, Dissociation and depersonalisation

### 2026-05-30 — Session notes
- Wrote *The Map That Argues With the Territory* — Terraform with Azure RM: declarative vs imperative IaC; the azurerm provider (1,400 resources, 110+ services); the state file as Terraform's model of reality; configuration drift; plan/apply workflow; Bicep vs Terraform comparison; the OpenTofu fork and what it reveals about open source
- 3 new related topics added: Policy as code (OPA and Sentinel), GitOps for infrastructure, Terragrunt and Terraform modules

### 2026-05-31 — Session notes
- Wrote *What Was Never There* — healing the neglect-affected adult nervous system: repair vs construction distinction; corrective emotional experience; the lock-and-key paradox; window of tolerance; somatic approaches and interoception; IFS and befriending protectors before accessing exiles; earned secure attachment (20–25% of secure adults had insecure childhoods); AEDP and transformational affects; what change actually feels like
- 2 new related topics added: Earned secure attachment, AEDP (Accelerated Experiential Dynamic Psychotherapy)
