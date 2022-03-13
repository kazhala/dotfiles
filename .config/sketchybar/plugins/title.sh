#!/usr/bin/env bash

if [[ "$(yabai -m query --spaces --display | jq -r 'map(select(."focused" == 1))[-1].windows[0]')" == "null" ]]; then
	sketchybar --set "$NAME" label=""
else
	sketchybar --set "$NAME" label="$INFO"
fi
