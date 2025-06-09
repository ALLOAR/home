#!/bin/bash

# Показываем dmenu/wofi для выбора программы
chosen=$(echo -e "alacritty\nfirefox\nsteam\ndiscord\ntelegram-desktop" | wofi --dmenu -p "Запустить:")

case "$chosen" in
    alacritty)          alacritty & ;;
    firefox)            firefox & ;;
    steam)              steam & ;;
    discord)            discord & ;;
    telegram-desktop)   telegram-desktop & ;;
    *) ;;
esac
