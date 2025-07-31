#!/usr/bin/env bash
wallpaper=$((1 + RANDOM % 19))
echo $wallpaper
swww img /home/alloar/nix/home-configs/scripts/wallpaper/$wallpaper.jp*g --transition-type any
