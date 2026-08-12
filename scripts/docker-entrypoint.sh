#!/bin/sh
# Copy default DB into /mb/data, run mantisbase on port 80, then exit after 30 minutes
# so the container restarts and data resets. DB source: host mount /db-default if
# present and non-empty, else image /mb/data-default.

set -e

restore_data() {
  src=$1
  rm -rf /mb/data
  mkdir -p /mb/data
  cp -a "$src/." /mb/data/
}

if [ -d /db-default ] && [ -n "$(ls -A /db-default 2>/dev/null)" ]; then
  restore_data /db-default
elif [ -d /mb/data-default ]; then
  restore_data /mb/data-default
else
  mkdir -p /mb/data
fi

/mb/mantisbase serve -port 80 &
pid=$!
sleep 1800
kill $pid 2>/dev/null || true
exit 0
