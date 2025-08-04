#!/usr/bin/env bash

chosen=$(echo -e "neko\npixel_cyberpunk\ncastle_nature\nrainy_girls" | wofi --dmenu -p "Запустить:")

case "$chosen" in
    neko) mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/3_anime_wallpaper_neko_school.mp4 ;;
    pixel_cyberpunk) mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/2_emily-in-the-cyberpunk-city.1920x1080.mp4;;
    castle_nature)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/1_anime_wallpaper_castle_nature_girl.mp4;;
    rainy_girls) mpvpaper '*'  /home/alloar/nix/wofi/animated_wallpaper/4_rainy-day-girls.1920x1080.mp4;;
    #discord)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/;;
    #telegram-desktop)  mpvpaper '*' /home/alloar/nix/wofi/animated_wallpaper/;;
    *) ;;
esac
