#!/bin/bash

CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ ${CHARGING} != "" ]]; then
	sketchybar --set "${NAME}" icon=""
	exit 0
fi

sketchybar --set "${NAME}" icon=""
