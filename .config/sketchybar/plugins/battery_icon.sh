#!/usr/bin/env bash

BATT_PRESENT=$(pmset -g batt | grep -Eo "\d+%")

if [[ -z "${BATT_PRESENT}" ]]; then
  sketchybar --set "${NAME}" icon="󰚥"
  exit 0
fi

CHARGING=$(pmset -g batt | grep 'AC Power')

if [[ ${CHARGING} != "" ]]; then
  sketchybar --set "${NAME}" icon="󰻹"
  exit 0
fi

sketchybar --set "${NAME}" icon="󰗶"
