#!/usr/bin/env bash

SETTINGS=$(osascript -e "get volume settings")
VOLUME=$(echo "$SETTINGS" | cut -d ":" -f2 | cut -d "," -f1 | tr -d ' ')
MUTED=$(echo "$SETTINGS" | grep "muted:true")

if [[ $MUTED != "" ]]; then
	ICON="󰝟"
elif [[ $VOLUME -lt 25 ]]; then
	ICON="󰕿"
elif [[ $VOLUME -lt 75 ]]; then
	ICON="󰖀"
else
	ICON="󰕾"
fi

sketchybar -m --set "$NAME" icon="$ICON"
