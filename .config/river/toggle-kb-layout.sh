#!/bin/sh

# File to store the current layout
STATE_FILE="$HOME/.config/river/river-kb-layout"

# Default layout if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "us" > "$STATE_FILE"
fi

CURRENT_LAYOUT=$(cat "$STATE_FILE")

# Toggle between layouts
if [ "$CURRENT_LAYOUT" = "us" ]; then
    NEXT_LAYOUT="ir"
else
    NEXT_LAYOUT="us"
fi

# Apply new layout
riverctl keyboard-layout "$NEXT_LAYOUT"

# Save new layout
echo "$NEXT_LAYOUT" > "$STATE_FILE"
