{ config, pkgs, ... }: {
# --- hyprlnad hyprlock hyprshot --- #
	home.file.".config/hypr/hyprlock.conf" = {
        source = ./home-configs/config/hypr/hyprlock.conf;
        };
	home.file.".config/hypr/wallpaper.jpeg" = {
         source = ./home-configs/config/hypr/wallpaper.jpeg;
        };
	home.file.".config/hypr/hyprshot.conf" = {
        source = ./home-configs/config/hypr/hyprshot.conf;
        };
}
