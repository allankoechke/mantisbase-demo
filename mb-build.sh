#!/usr/bin/env bash
# Build the admin UI in mb/ without editing the submodule.
# Next.js flags are set via environment variables here.

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/mb"

export NEXT_PUBLIC_BASE_PATH="${NEXT_PUBLIC_BASE_PATH:-}"
export NEXT_PUBLIC_MB_IS_DEMO_MODE="${NEXT_PUBLIC_MB_IS_DEMO_MODE:-true}"
export NODE_ENV="${NODE_ENV:-production}"

npm ci
npm run build
