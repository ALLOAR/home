#!/bin/bash
wallpaper=$((1 + RANDOM % 19))
echo $wallpaper
swww img ~/.config/home-manager/config/systemd/wallpaper/$wallpaper.jp*g --transition-type any
