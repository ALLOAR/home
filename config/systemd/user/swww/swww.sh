#!/bin/bash
wallpaper=$((1 + RANDOM % 8))
echo $wallpaper
swww img /home/alloar/.config/systemd/user/swww/$wallpaper.jpeg --transition-type any
