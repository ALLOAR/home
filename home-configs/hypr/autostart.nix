{ config, pkgs, ... }:

{
settings = {
exec-once = [
	"hyprpaper"
	"waybar"
	"dunst"
#        "discord"
	"swww init"
	"systemctl --user start swww"
	"sh -c 'hyprctl dispatch workspace 3 && firefox'"
	"sh -c 'hyprctl dispatch workspace 5 && steam'"
	"sh -c 'hyprctl dispatch workspace 4 && telegram-desktop'"	
];
};
}
