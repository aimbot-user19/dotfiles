#!/bin/bash
# Must be updated to use JSON output!

CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

if [ -z "$CAPACITY" ]; then
    echo '{"text": "N/A"}'
    exit 1
fi

# 1. Determine the CSS Class and Icon
CLASS_NAME="good"
ICON=""

if [ "$STATUS" = "Charging" ]; then
    ICON=""
    CLASS_NAME="charging"
elif [ "$CAPACITY" -lt 20 ]; then
    ICON=""
    CLASS_NAME="critical"
elif [ "$CAPACITY" -lt 30 ]; then
    ICON=""
    CLASS_NAME="warning"
fi

TEXT="${ICON}&#x0a;${CAPACITY}"

echo '{"text": "'"${TEXT}"'", "class": "'"${CLASS_NAME}"'"}' 
