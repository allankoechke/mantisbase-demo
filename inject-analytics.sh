#!/bin/sh

set -eu

OUTPUT_DIR="${1:-./out}"
ANALYTICS_SCRIPT="${ANALYTICS_SCRIPT:-<script defer data-domain="demo.mantisbase.com" src="https://analytics.codeart.co.ke/js/script.file-downloads.hash.outbound-links.pageview-props.revenue.tagged-events.js"></script>
<script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>
}"

if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Error: output directory does not exist: $OUTPUT_DIR" >&2
    exit 1
fi

find "$OUTPUT_DIR" -type f -name '*.html' -print0 |
while IFS= read -r -d '' file; do
    if grep -qF "$ANALYTICS_SCRIPT" "$file"; then
        echo "Skipping: $file"
        continue
    fi

    if ! grep -qi '</head>' "$file"; then
        echo "Warning: no </head> found: $file" >&2
        continue
    fi

    tmp="${file}.tmp"

    awk -v script="$ANALYTICS_SCRIPT" '
        BEGIN {
            IGNORECASE = 1
            injected = 0
        }

        !injected && /<\/head>/ {
            sub(/<\/head>/, script "</head>")
            injected = 1
        }

        { print }
    ' "$file" > "$tmp"

    mv "$tmp" "$file"

    echo "Injected: $file"
done