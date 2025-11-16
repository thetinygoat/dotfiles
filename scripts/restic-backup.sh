#!/usr/bin/env bash

set -euo pipefail

ENV_FILE="${RESTIC_ENV_FILE:-$HOME/.restic.env}"


if [[ -f "${ENV_FILE}" ]]; then
    set -a
    source "${ENV_FILE}"
    set +a
fi

BACKUP_SOURCES=(
    "/home"
    "/etc"
)

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

if [[ -z "${RESTIC_REPOSITORY:-}" || -z "${RESTIC_PASSWORD:-}" ]]; then
    panic "RESTIC_REPOSITORY or RESTIC_PASSWORD not set"
fi


# only require AWS credentials if using an S3-like backend
if [[ "${RESTIC_REPOSITORY}" == s3:* ]]; then
    if [[ -z "${AWS_ACCESS_KEY_ID:-}" || -z "${AWS_SECRET_ACCESS_KEY:-}" ]]; then
        panic "AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY not set for S3 backend"
    fi
fi

[[ ${#BACKUP_SOURCES[@]} -gt 0 ]] || panic "no backup sources configured"

for source in "${BACKUP_SOURCES[@]}"; do
    [[ -d "${source}" ]] || panic "backup source not found: ${source}"
done

info "starting backup"
restic backup -v "${BACKUP_SOURCES[@]}"


info "finished backup; enforcing retention policy (keep last ${KEEP_DAYS} daily snapshots)"

restic forget --keep-daily "${KEEP_DAYS}" --prune

info "backup and pruning finished"
