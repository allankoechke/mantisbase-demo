#!/usr/bin/env bash
# Build the admin UI in mb/ without editing the submodule.
# Uses a temp copy + wrapper next.config so @/ path alias works.

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
BUILD_DIR="$REPO_ROOT/.mb-build"
trap "rm -rf '$BUILD_DIR'" EXIT

export NEXT_PUBLIC_BASE_PATH="${NEXT_PUBLIC_BASE_PATH:-}"
export NEXT_PUBLIC_MB_IS_DEMO_MODE="${NEXT_PUBLIC_MB_IS_DEMO_MODE:-true}"
# export NEXT_PUBLIC_MANTIS_BASE_URL="${NEXT_PUBLIC_MANTIS_BASE_URL:-http://localhost:7090}"

rm -rf "$BUILD_DIR"
cp -r "$REPO_ROOT/mb" "$BUILD_DIR"
cp "$REPO_ROOT/next.config.demo.mjs" "$BUILD_DIR/next.config.mjs"

cd "$BUILD_DIR"
npm ci

# Set ENV Vars
echo "NEXT_PUBLIC_BASE_PATH=$NEXT_PUBLIC_BASE_PATH" >> .env  
echo "NEXT_PUBLIC_MB_IS_DEMO_MODE=$NEXT_PUBLIC_MB_IS_DEMO_MODE" >> .env
# echo "NEXT_PUBLIC_MANTIS_BASE_URL=$NEXT_PUBLIC_MANTIS_BASE_URL" >> .env
echo "NODE_ENV=production" >> .env   

npm run build

mkdir -p "$REPO_ROOT/mb/out"
cp -r out/. "$REPO_ROOT/mb/out/"
