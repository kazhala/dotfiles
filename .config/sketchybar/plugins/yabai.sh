#!/usr/bin/env bash

case "$(yabai -m query --spaces --display | jq -r 'map(select(."has-focus" == true))[-1].type')" in
bsp)
	sketchybar -m --set "$NAME" icon="  "
	;;
stack)
	sketchybar -m --set "$NAME" icon="  "
	;;
float)
	sketchybar -m --set "$NAME" icon="  "
	;;
esac
