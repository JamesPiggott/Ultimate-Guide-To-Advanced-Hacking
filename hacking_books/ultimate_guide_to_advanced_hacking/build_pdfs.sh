#!/bin/bash
for dir in */; do
    if [[ -f "$dir/README.md" ]]; then
        pandoc "$dir/README.md" --metadata-file=metadata.yaml -o "$dir/${dir%/}.pdf"
        echo "Generated: $dir${dir%/}.pdf"
    fi
done
