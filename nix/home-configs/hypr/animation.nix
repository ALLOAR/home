{ config, pkgs, ... }:
 # animation = <что>, <включено 0/1>, <скорость>, <кривая>, <эффекты>
{
settings = {
	animations = {
	enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, slidevert 100%"
          "windowsOut, 1, 1.2, easeOutQuint, slidevert 50%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, slide"
          "workspacesIn, 1, 1.21, almostLinear, slide"
          "workspacesOut, 1, 1.94, almostLinear, slide"
		];
	};
general = {  
gaps_in = 3;
gaps_out = 10;
	border_size = 2;
	"col.active_border" = "rgba(ff00ffee) rgba(ff8800ee) rgba(ffff00ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";
	resize_on_border = false;
	allow_tearing = false;
	layout = "dwindle";
};

decoration = {
	rounding = 10;
	shadow = {
		enabled = true;
		range = 4;
		render_power = 3;
		color = "rgba(1a1a1aee)";
        };
        blur = {
		enabled = true;
		size = 3;
		passes = 1;
		vibrancy = 0.1696;
        };
};
#    };
};
}
