#!/usr/bin/env bash

VOLUME=$(osascript -e "get volume settings" | cut -d " " -d ":" -f2 | cut -d "," -f1)

sketchybar -m --set "$NAME" label="$VOLUME%"
