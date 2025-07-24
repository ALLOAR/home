{ config, pkgs, ... }:

{
settings = {
workspace = [
	"1,monitor:DVI-D-1"
	"2,monitor:DVI-D-1"
	"3,monitor:DVI-D-1"
	"4,monitor:DVI-D-1"
	"5,monitor:DVI-D-1"
	"6,monitor:DVI-D-1"
	"7,monitor:HDMI-A-1"
	"8,monitor:HDMI-A-1"
	"9,monitor:HDMI-A-1"
];
monitor = [
	"eDP-1,1920x1080@59,0x0,1"
	"HDMI-A-1 (ID 1),1920x1080@60,0x0,2.5"
#	"DVI-D-1,1920x1080@59,1366x0,1"
];
};
}
