#!/usr/bin/env bash

percent=$(cat /sys/class/power_supply/BAT1/capacity)

if [[ "$percent" == "99" ]]; then
        notify-send "Turn of charging"
elif [["$percent" == "40" ]]; then
	notify-send "Turn on charging"
fi
