#!/usr/bin/env bash
set -euo pipefail

if [ -z "${SHORTCUT_API_TOKEN:-}" ]; then
  echo "WARNING: SHORTCUT_API_TOKEN is not set. Shortcut tools will not work until this environment variable is configured." >&2
fi
