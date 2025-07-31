let 
clock = "clock";
#bgm = "background-color: transparent;";	
bgm = "background-color: rgba(4, 8, 20, 1);"; # background modules
bgw = "background-color: rgba(0, 0, 0, 0.4);"; #background all waybar
bgb = "background-color: rgba(0, 0, 0, 0.0);"; # background battery 
font = "font-size: 16px;";
fontp = "font-size: 16px;"; #font pulseaudio
fontc = "font-size: 16px;"; #font cpu
fontw = "font-size: 30px;"; #font workspaces
fontl = "font-size: 25px;"; #font laucher
fontm = "font-size: 16px;"; #font memoryw
fontb = "font-size: 15px;"; #font battery
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

    #modules-left= ["custom/launcher" "hyprland/workspaces" "custom/bluetooth" "custom/window-title" ];
    #modules-center= ["temperature" "cpu" "clock" "memory" "pulseaudio"];
    #modules-right= ["custom/youtube-music" "custom/firefox" "custom/steam" "custom/discord" "custom/telegram-desktop" "custom/alacritty" "network" "battery" "hyprland/language" "disk" "custom/power"];

	modules-left= [ "custom/launcher" "tray" ];
	modules-center= [ "cpu" "pulseaudio" "memory" "hyprland/workspaces" "hyprland/language" "clock" ];
	modules-right = [ "battery" ];


"tray" = {
        icon-size = 20;
        spacing = 5;
    };

"hyprland/language" = {
        format-en = "US";
        format-ru = "RU";
	      min-length = 5;
	      tooltip = false;
  };

"hyprland/workspaces"= {
    format= "{icon}";
    on-click= "activate";
    all-outputs= true;
    format-icons= {
        "1"= "  ";
        "2"= "   ";
        "3"= " ";
        "4"= "  ";
        "5"= " 󰓓 ";
        "6"= "●";
        "7"= "●";
        "8"= "●";
        "9"= "●";
        "10"= "●";
    };
    };

"custom/bluetooth" = {
  exec = "/home/alloar/nix/home-configs/scripts/bluetooth.sh";
  interval= 30;
  tooltip= false;
};

"custom/alacritty"= {
    format= "  ";  
    tooltip= false;
    on-click= "alacritty";
    interval= 3600;
};

"custom/firefox"= {
    format= "  ";  
    tooltip= false;
    on-click= "firefox";
    interval= 3600;
};
"custom/steam"= {
    format= " 󰓓 ";
    tooltip= false;
    on-click= "steam";
    interval= 3600;
};
"custom/discord"= {
    format= "  ";
    tooltip= false;
    on-click= "discord";
    interval= 3600;
};
"custom/telegram-desktop"= {
    format= "  ";
    tooltip= false;
    on-click= "telegram-desktop";
    interval= 3600;
};
"custom/youtube-music"= {
    format= "  ";
    tooltip= false;
    on-click= "youtube-music";
    interval= 3600;
};

   "custom/window-title"= {
    format= "{}";
    exec= "hyprctl activewindow -j | jq -r '.title'";
    interval= 1;
    max-length= 50;
 };


    "network"= {
        format-wifi = "  {bandwidthDownBits}";
        format-ethernet= "󰈁 {bandwidthDownBits}";
        format-disconnected = "󰣵";
        interval= 5;
        tooltip= false;
	on-click= "hyprctl dispatch exec \"[float; size 500 100; move 1400 37] alacritty -e ping google.com\"";
    };

"temperature"= {
	sensor= "k10temp-pci-00c3";
	format= "{temperatureC}°C";
	};

 "disk"= {
    format= "{used}/{total}";
    on-click= "hyprctl dispatch exec \"[float; size 700 500; move 1210 35] thunar\"";
    path= "/";
    interval= 30;
    };
   
    battery= {
    format= "{capacity}% {icon}";
    format-charging= "⚡ {capacity}%";
    format-plugged= "🔌 {capacity}%";
    format-alt= "{time} ({capacity}%)";
    interval= 30;
    states= {
        good= 80;
        warning= 30;
        critical= 15;
    };
    format-icons= ["" " " " " " " " "];
}; 

    pulseaudio= {
        format= "{icon} {volume}%   ";
        format-muted= "󰖁 Muted";
        scroll-step= 5;
        on-click= "pamixer -t";
	on-click-right= "hyprctl dispatch exec \"[float; size 600 300; move 800 37] XDG_CURRENT_DESKTOP=GNOME GTK_THEME=Adwaita-dark GTK_APPLICATION_PREFER_DARK_THEME=1 pavucontrol \""; 
        format-icons= {
		"alsa_output.pci-0000_00_1f.3.analog-stereo"= "";
		"alsa_output.pci-0000_00_1f.3.analog-stereo-muted"= "";
		"headphones"= "";
		"handsfree"= "";
		"headset"= "";
		"phone"= "";
		"phone-muted"= "";
		"portable"= "";
		"car"= "";
		"default"= ["" " "];
        };
    };

    "clock"= {
	interval= 60;
	tooltip= true;
        format = "{:%d.%m.%Y | %H:%M  }";
	tooltip-format= "{:%Y-%m-%d}";
	on-click= "hyprctl dispatch exec \"[float; move 860 37] gsimplecal\"";
  
    };

    "cpu"= {
        interval= 5;
        format= "󰻠 {usage}%   ";
        max-length= 10;
	on-click= "hyprctl dispatch exec \"[float; size 400 300; move 700 37] alacritty -e htop\"";
    };

    "memory"= {
        interval= 5;
	format= "{used:0.1f}GiB";
        max-length= 10;
    };

    "custom/launcher"= {
        format= " ";
        on-click= "wofi --show drun";
        on-click-right= "killall wofi";
        tooltip= false;
    };

    "custom/power"= {
        format= " ";
        on-click= "hyprlock";
        tooltip= false;
    };
};
};
style = ''
* {
    border: none;
    font-family: "JetBrains Mono Nerd Font";
    font-size: 13px;
    min-height: 0;
}
window#waybar {
    ${bgw} /* Чёрный с прозрачностью */
    color: #ffffff;
}

#custom-window-title {
    ${bgm};
    ${font}
    margin: 0px 0;
    border-radius: 5px;
    margin-top: 2px;
    margin-left: 2px;
    padding: 0 4px;    
}
#language {
	${font}
	${bgm}
}
#tray, #custom-firefox, #custom-steam, #custom-discord, #custom-telegram-desktop, #custom-alacritty, #custom-youtube-music, #custom-keyboard {
	${font}
	${bgm}
	margin-top: 2px;
	margin-right: 4px;
	margin-left: 4px;
	border-radius: 5px;
	font-size: 17px;
}

#custom-launcher {
    background-color: transparent;
    color: #89b4fa;
    ${fontl}
    padding: 0 10px;
    margin: 2px 0;
}


#workspaces {
${bgm}
color: #FFFFFF;
border: #2A3239;;
padding: 0px 0px 0px 6px;
}

#workspaces button {
    font-size: 30px;
    ${bgm};
    color: #FFFFFF;
    margin: 2px;
    padding: 5px;
    background: transparent;
    border: none; /* убираем стандартную рамку */
}

#workspaces button.active {
    color: #FFFF00;
}
#workspaces button:hover {
  color: #2A3239;;
  border: none;
  box-shadow: none;
  transition: none;
}
#temperature {
    ${font}
    ${bgm};

    padding: 4px 12px;
    margin: 0px 0;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
    margin-top: 2px;
}

#clock{
	${bgm};
	padding: 0px 0;  /* 2 - сверху снизу, 6 - српава, слева*/
	border-bottom-right-radius: 30px;
	${font}
}
#disk{ 
    ${bgm}
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    margin: 0px 0;
    border-bottom-right-radius: 5px;
    border-top-right-radius: 5px;
    margin-top: 2px;
    ${font}

}

#custom-bluetooth { 
    ${bgm}
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    margin: 0px 0;
    margin-top: 2px;
}
#battery{
    ${bgb}
    ${fontb}
    margin: 0px 0;
    
}
#network{
    ${bgm}
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    border-radius: 0px;
    border-bottom-left-radius: 5px;
    border-top-left-radius: 5px;
    margin-top: 2px;
}
#pulseaudio {
        ${bgm};
	${fontp}
}
#memory {
        ${bgm};
	${fontm}
        border-radius: 0px;
	margin-top: 0px;
}
#cpu{
	${fontc}
        ${bgm}
        border-bottom-left-radius: 30px;
	padding-left: 8px;
}
#custom-power {
    background-color: transparent;
    color: #f38ba8;
    ${font}
    padding: 0 12px;
    margin: 4px 0;
    margin-top: 2px;
}
	'';

};

}
