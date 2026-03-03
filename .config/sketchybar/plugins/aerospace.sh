#!/usr/bin/env bash
# shellcheck source=../colors.sh
. "$HOME/.config/sketchybar/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
	sketchybar --set "$NAME" icon.color="0xff${COL_GREEN}"
else
	sketchybar --set "$NAME" icon.color="0xff${COL_SNOW_WHITE}"
fi
