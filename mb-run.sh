#!/usr/bin/env bash
# Run the admin UI (production server). Run mb-build.sh first.
# Next.js flags are set via environment variables here.

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/mb"

export NEXT_PUBLIC_BASE_PATH="${NEXT_PUBLIC_BASE_PATH:-}"
export NEXT_PUBLIC_MB_IS_DEMO_MODE="${NEXT_PUBLIC_MB_IS_DEMO_MODE:-true}"

npm install
npm run dev
