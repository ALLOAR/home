{ config, pkgs, ... }:

{
settings = {
exec-once = [
	"hyprpaper"
	"waybar"
	"dunst"
	"firefox"
	"steam"
#        "discord"
	"telegram-desktop"
	"swww init"
	"systemctl --user start swww"
];
};
}
