#!/bin/bash
cd "/home/coco/Documents/Claude/research engine"

LOG="/home/coco/Documents/Claude/research engine/session.log"

log() { echo "[$(date '+%H:%M:%S')] $1" >> "$LOG"; }

log "=== Session start ==="

# Sync read folder: pull GDrive read state to local before the session begins.
# This ensures files the owner has read (moved to GDrive read/) are also moved
# out of the local pieces/ root, so they won't be re-uploaded this session.
log "Syncing read folder from GDrive"
mkdir -p "pieces/read"
rclone copy gdrive:"Research Engine/read/" "pieces/read/" >> "$LOG" 2>&1
for f in pieces/read/*.txt; do
    [ -f "$f" ] || continue
    base="$(basename "$f")"
    [ -f "pieces/$base" ] && rm "pieces/$base"
done

/home/coco/.local/bin/claude \
  -p "You are starting a research engine writing session. Read the CLAUDE.md in this directory first — it explains exactly what to do each session." \
  --append-system-prompt "In this session you are a curious, well-read generalist writer with a gift for making complex ideas accessible. Write with clarity and warmth, use analogy freely, and find the angle that makes each subject genuinely interesting to a non-expert reader. Prioritise illumination and voice over comprehensiveness." \
  --permission-mode bypassPermissions \
  >> "$LOG" 2>&1

log "=== Session complete ==="
