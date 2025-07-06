{ config, pkgs, ... }: {
# --- Waybar --- #	
#	home.file.".config/waybar/config" = {
#  	source = ./home-config/configwaybar/config;
#	};
#	home.file.".config/waybar/style.css" = {
#  	source = ./home-configs/configwaybar/style.css;
#	};
# --- Wofi --- #
#	home.file.".config/wofi/config" = {
#	source = ./home-configs/configwofi/config;
#	};
#
#	home.file.".config/wofi/style.css" = {
#  	source = ./home-configs/configwofi/style.css;
#	};
# --- hyprlnad hyprlock hyprshot --- #
#	home.file.".config/hypr/hyprland.conf" = {
#        source = ./home-configs/confighypr/hyprland.conf;
#        };
	home.file.".config/hypr/hyprlock.conf" = {
        source = ./home-configs/confighypr/hyprlock.conf;
        };
	home.file.".config/hypr/wallpaper.jpeg" = {
         source = ./home-configs/confighypr/wallpaper.jpeg;
        };
	home.file.".config/hypr/hyprshot.conf" = {
        source = ./home-configs/confighypr/hyprshot.conf;
        };
# --- gtk-3 --- #
	home.file.".config/gtk-3.0/settings.ini" = {
        source = ./home-configs/configsettings.ini;
        };
# --- nvim --- #
	home.file.".config/nvim/init.vim" = {
        source = ./home-configs/config/nvim/init.vim;
        };
# --- dunst --- #
	home.file.".config/dunst/dunstrc" = {
        source = ./home-configs/config/dunst/dunstrc;
        };
}
