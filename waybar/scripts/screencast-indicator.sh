#!/bin/bash

# Screencast indicator for waybar
# Monitors PipeWire for active video source streams (e.g. screen sharing via xdg-desktop-portal-wlr)

if pw-dump 2>/dev/null | jq -e '[.[] | select(.info.props["media.class"] == "Video/Source") | select(.info.state == "running")] | length > 0' > /dev/null 2>&1; then
    echo '{"text": "󰑊", "class": "recording", "tooltip": "Screen is being shared"}'
else
    echo '{"text": "", "class": "idle", "tooltip": ""}'
fi
