#!/bin/sh
# Copy default DB into /mb/data, run mantisbase on port 80, then exit after 30 minutes
# so the container restarts and data resets. DB source: host mount /db-default if
# present and non-empty, else image /mb/data-default.

set -e
mkdir -p /mb/data
if [ -d /db-default ] && [ -n "$(ls -A /db-default 2>/dev/null)" ]; then
  cp -r /db-default/. /mb/data/
elif [ -d /mb/data-default ]; then
  cp -r /mb/data-default/. /mb/data/
fi

/mb/mantisbase --dev serve -p 80 &
pid=$!
sleep 1800
kill $pid 2>/dev/null || true
exit 0
