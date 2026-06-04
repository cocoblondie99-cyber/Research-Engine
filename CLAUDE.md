# Research Engine

## What This Project Is
An autonomous research writing engine that produces accessible, engaging long-form pieces on topics of interest. At scheduled intervals (5:03am and 5:03pm), Claude runs a three-phase session: topic selection → research → writing.

## Project Structure
- `CLAUDE.md` — this file; session protocol and project overview
- `rules.md` — style guide and full session phase instructions
- `topics.md` — main topics (owner-curated)
- `pieces/` — completed pieces, one file each, named `topic-slug_DD-MM-YY.txt` (e.g. `docker-and-containers_28-05-26.txt`)
- `run_session.sh` — cron launcher
- `session.log` — output log from automated runs
- `selected_topic.txt` — session artifact: topic + description written by Phase 1, angle plan appended by Phase 2, read by Phase 3; deleted at session start

## Session Protocol
Each phase runs as a separate invocation. Read only what each phase requires.

- **Phase 1 — Selection**: reads `topics.md` + Phase 1 rules; writes `selected_topic.txt`
- **Phase 2 — Research**: reads `selected_topic.txt` only; web searches; appends angle plan to `selected_topic.txt`
- **Phase 3 — Writing**: reads `selected_topic.txt` + Content/Style/Format rules only; writes piece; updates `topics.md`

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

### 2026-06-01 (evening) — Session notes
- Wrote *The Waiting Room* — CEN and the parent relationship
- 3 new related topics added: Ambiguous loss, Family estrangement research, Schema therapy imagery rescripting
- GDrive upload failed — rclone OAuth token expired again; manual re-auth required (`rclone config reconnect gdrive:`)

### 2026-06-01 — Session notes
- Wrote *The Pilot That Never Lands* — AI automation in large organisations: the 86–89% pilot failure rate vs genuine service desk wins (1B requests handled, 80% auto-resolution); why pilots fail (integration gap, data quality debt, organisational change, ROI miscalculation); the $735 governance ratio; agent blast-radius thinking vs uniform governance failure; what actually ships at scale (service desk, customer onboarding, compliance monitoring); what remains experimental
- 3 new related topics added: ITSM platforms and AI integration, AI agent identity and access management, The AI pilot failure problem
- GDrive upload failed — rclone OAuth token expired; manual re-auth required before upload

### 2026-06-02 — Session notes
- Wrote *The Borrowed Address* — DHCP lease and scope management: the DORA handshake (Discover, Offer, Request, Acknowledge); leases as time-limited rentals and the hotel front desk metaphor; the T1/T2 renewal mechanism (50% and 87.5% of lease time); scope as the pool; phantom lease / address exhaustion (169.254.x.x / APIPA as the hook); short vs long lease tradeoffs by environment type; exclusions vs reservations; scope options bundled with the IP; superscopes as a pressure valve; DHCP failover vs split scope
- 3 new related topics added: IPv6 addressing and SLAAC, Dynamic DNS and DHCP coordination, VLANs and network segmentation
