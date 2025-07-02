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
# --- gtk-3 --- #
	home.file.".config/gtk-3.0/settings.ini" = {
        source = ./home-configs/config/settings.ini;
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
