#!/usr/bin/env bash

# Сперва пробуем xkb-switch
if command -v xkb-switch &> /dev/null; then
    layout=$(xkb-switch -p)
else
    layout=$(setxkbmap -query | grep layout | awk '{print $2}')
fi

# Просто выводим
echo "$layout"
