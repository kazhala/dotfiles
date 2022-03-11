#!/usr/bin/env bash

ping_timeout=1
ping_address=8.8.8.8

sketchybar -m \
	--set "$NAME" icon="" \
	--set "$NAME" label=""

if ! ping -c 1 -t $ping_timeout -q $ping_address >/dev/null 2>&1; then
	sketchybar -m \
		--set "$NAME" label.color=0xff000000
else
	sketchybar -m \
		--set "$NAME" label.color=0xff000000
fi
