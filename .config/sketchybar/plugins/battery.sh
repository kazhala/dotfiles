#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

sketchybar --set "${NAME}" label="${BATT_PERCENT}%"
