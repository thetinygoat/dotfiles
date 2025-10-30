#!/usr/bin/env bash

set -euo pipefail

if [[ -f "${HOME}/.restic.env" ]]; then
    set -a
    source $HOME/.restic.env
    set +a
fi

BACKUP_SOURCE="/mnt/external"
KEEP_DAYS=7

log() {
    printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}

info() {
    log "INFO: $*">&1
}

panic() {
    log "ERROR: $*">&2
    exit 1
}


command -v restic > /dev/null 2>&1 || panic "restic is not installed"

if [[ -z "${AWS_ACCESS_KEY_ID:-}" || -z "${AWS_SECRET_ACCESS_KEY:-}" || -z "${RESTIC_REPOSITORY:-}" || -z "${RESTIC_PASSWORD:-}" ]]; then
    panic "restic not configured properly"
fi

[[ -d "${BACKUP_SOURCE}" ]] || panic "backup source not found"

info "starting backup"
restic backup -v "${BACKUP_SOURCE}"


info "finished backup; enforcing retention policy (keep last ${KEEP_DAYS} daily snapshots)"

restic forget --keep-daily "${KEEP_DAYS}" --prune

info "backup and pruning finished"
