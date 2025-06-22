{ config, pkgs, ... }: {
# --- Waybar --- #	
#	home.file.".config/waybar/config" = {
#  	source = ./config/waybar/config;
#	};
#	home.file.".config/waybar/style.css" = {
#  	source = ./config/waybar/style.css;
#	};
# --- Wofi --- #
#	home.file.".config/wofi/config" = {
#	source = ./config/wofi/config;
#	};
#
#	home.file.".config/wofi/style.css" = {
#  	source = ./config/wofi/style.css;
#	};
# --- hyprlnad hyprlock hyprshot --- #
#	home.file.".config/hypr/hyprland.conf" = {
#        source = ./config/hypr/hyprland.conf;
#        };
	home.file.".config/hypr/hyprlock.conf" = {
        source = ./config/hypr/hyprlock.conf;
        };
	home.file.".config/hypr/wallpaper.jpeg" = {
        source = ./config/hypr/wallpaper.jpeg;
        };
	home.file.".config/hypr/hyprshot.conf" = {
        source = ./config/hypr/hyprshot.conf;
        };
# --- gtk-3 --- #
	home.file.".config/gtk-3.0/settings.ini" = {
        source = ./config/settings.ini;
        };
# --- systemd --- #
	home.file.".config/systemd/user/swww.service" = {
        source = ./config/systemd/swww.service;
        };
        home.file.".config/systemd/user/swww.timer" = {
        source = ./config/systemd/swww.timer;
        };
        home.file.".config/systemd/user/git-sync-obsidian.service" = {
        source = ./config/systemd/git-sync-obsidian.service;
        };
        home.file.".config/systemd/user/git-sync-obsidian.timer" = {
        source = ./config/systemd/git-sync-obsidian.timer;
        };
# --- nvim --- #
	home.file.".config/nvim/init.vim" = {
        source = ./config/nvim/init.vim;
        };
# --- dunst --- #
	home.file.".config/dunst/dunstrc" = {
        source = ./config/dunst/dunstrc;
        };
}
