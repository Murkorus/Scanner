#!/bin/bash
echo "$(date): fullscreenfix.sh started" >> /home/pi/Desktop/debug.log
# How long to wait before giving up
TIMEOUT=60
START_TIME=$(date +%s)

# Loop until the window exits fullscreen
while true; do
    # Get the most recent Chromium window
    WIN_ID=$(xdotool search --onlyvisible --class "chromium" | tail -n 1)

    # Check if window is fullscreen
    STATE=$(xprop -id "$WIN_ID" | grep "_NET_WM_STATE_FULLSCREEN")

    if [[ -z "$STATE" ]]; then
        echo "$(date): Application not in fullscreen. Applying forced fullscreen with F11" >> /home/pi/Desktop/debug.log
        xdotool windowactivate "$WIN_ID"
        sleep 0.5
        xdotool key --window "$WIN_ID" F11
        echo "$(date): Fullscreen applied, checking status..." >> /home/pi/Desktop/debug.log
        break
    fi

    # Timeout safety
    NOW=$(date +%s)
    ELAPSED=$((NOW - START_TIME))
    if [[ $ELAPSED -gt $TIMEOUT ]]; then
        echo "Timeout reached. Giving up."
        break
    fi

    sleep 1
done