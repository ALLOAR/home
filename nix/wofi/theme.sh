#!/usr/bin/env bash

chosen=$(echo -e "neko\npixel_cyberpunk\ncastle_nature" | wofi --dmenu -p "Запустить:")

case "$chosen" in
    neko) mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/3_anime_wallpaper_neko_school.mp4 ;;
    pixel_cyberpunk) mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/2_emily-in-the-cyberpunk-city.1920x1080.mp4;;
    castle_nature)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/;;
    #discord)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/;;
    #telegram-desktop)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/;;
    *) ;;
esac
