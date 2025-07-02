#!/usr/bin/env bash

MAC="9C:49:52:96:C8:87"

info=$(bluetoothctl info "$MAC")
battery_line=$(echo "$info" | grep -i "Battery Percentage")

if [[ -n "$battery_line" ]]; then
  # Извлекаем десятичное значение из строки вида: Battery Percentage: 0x50 (80)
  percentage=$(echo "$battery_line" | grep -oP '\(\K[0-9]+(?=\))')
  echo "🎧 ${percentage}%"
else
  echo "🎧 N/A"
fi
