#!/usr/bin/env bash

ping_timeout=1
ping_address=8.8.8.8

if ! ping -c 1 -t $ping_timeout -q $ping_address >/dev/null 2>&1; then
	sketchybar -m --set "$NAME" label=""
else
	sketchybar -m --set "$NAME" label=""
fi
