{ config, pkgs, ... }:

{
settings = {
	input = {
		kb_layout = "us,ru";
		kb_variant = "";
		kb_model = "";
		kb_options = "grp:alt_shift_toggle";
		kb_rules = "";
		follow_mouse = 1;
		sensitivity = 0.0;
		touchpad = {
			natural_scroll = false;
		};
	};
	device = {
		name = "epic-mouse-v1";
		sensitivity = -0.5;
	};
	cursor = {
		no_hardware_cursors = false;
		inactive_timeout = 0;
	};
};
}
