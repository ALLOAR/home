#!/bin/bash
wallpaper=$((1 + RANDOM % 15))
echo $wallpaper
swww img /home/alloar/.config/systemd/user/swww/$wallpaper.jpeg --transition-type any
