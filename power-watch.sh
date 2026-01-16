#!/bin/bash

BOT_TOKEN="<BOT_TOKEN>"
CHAT_ID="<CHAT_ID>"

STATE_FILE="/tmp/power_state"

POWER=$(upower -i $(upower -e | grep BAT) | grep "state:" | awk '{print $2}')


# First run
if [ ! -f "$STATE_FILE" ]; then
    echo "$POWER" > "$STATE_FILE"
    exit 0
fi

LAST=$(cat "$STATE_FILE")

# If power state changed
if [ "$POWER" != "$LAST" ]; then
    echo "$POWER" > "$STATE_FILE"

    if [ "$POWER" = "discharging" ]; then
        MSG="⚠️ Homelab running on BATTERY!
Switching off heavy services recommended."
    else
        MSG="🔌 Power restored — running on AC"
    fi

    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$MSG" > /dev/null
fi
