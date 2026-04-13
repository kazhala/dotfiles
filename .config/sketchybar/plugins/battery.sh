#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)

if [[ -z "${BATT_PERCENT}" ]]; then
  sketchybar --set "${NAME}" label="⚡"
else
  sketchybar --set "${NAME}" label="${BATT_PERCENT}%"
fi
