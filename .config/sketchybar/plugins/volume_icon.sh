#!/usr/bin/env bash

MUTED=$(osascript -e "get volume settings" | grep "muted:true")

if [[ $MUTED != "" ]]; then
	ICON="ﱝ"
else
	ICON=""
fi

sketchybar -m --set "$NAME" icon="$ICON"
