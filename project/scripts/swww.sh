#!/bin/bash
wallpaper=$((1 + RANDOM % 6))
echo $wallpaper
swww img ~/home/project/scripts/$wallpaper.jpeg --transition-type any
