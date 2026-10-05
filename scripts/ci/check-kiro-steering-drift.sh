#!/usr/bin/env bash
# Verify that .kiro/steering/ is in sync with the .claude/ rule source.
# The .claude/ tree is the single source of truth; .kiro/steering/ is generated
# from it by scripts/gen/sync-kiro-steering.py. This gate fails on any drift so
# a convention change made in .claude/ cannot silently skip the Kiro surface.
#
# Usage:
#   scripts/ci/check-kiro-steering-drift.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

PY="${PYTHON:-python3}"
if ! command -v "$PY" > /dev/null 2>&1; then
  PY=python
fi

exec "$PY" "$REPO_ROOT/scripts/gen/sync-kiro-steering.py" --check --root "$REPO_ROOT"
