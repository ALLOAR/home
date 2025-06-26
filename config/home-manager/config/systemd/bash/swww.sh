#!/bin/bash
wallpaper=$((1 + RANDOM % 6))
echo $wallpaper
swww img ~/.config/home-manager/config/systemd/wallpaper/$wallpaper.jpeg --transition-type any
