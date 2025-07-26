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

	modules-left= [ "custon/launcher" "cpu" "pulseaudio" ];
	modules-center= [ "hyprland/workspaces" ];
	modules-right = [ "clock" ];

#Нерабочий мусор
"tray" = {
        icon-size = 16;
        spacing = 0;
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
    format-icons= {
        "1"= "  ";
        "2"= "   ";
        "3"= "  ";
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
    format-icons= ["" "" " " " " " "];
}; 

    pulseaudio= {
        format= "{icon} {volume}%";
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
	format= "{:%H:%M}";
	tooltip-format= "{:%Y-%m-%d}";
	on-click= "hyprctl dispatch exec \"[float; move 860 37] gsimplecal\"";
    };

    "cpu"= {
        interval= 5;
        format= "󰻠 {usage}%";
        max-length= 10;
	on-click= "hyprctl dispatch exec \"[float; size 400 300; move 700 37] alacritty -e htop\"";
    };

    "memory"= {
        interval= 5;
        format= "󰍛 {percentage}%";
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
    background-color: rgba(0, 0, 0, 0.0);
    color: #ffffff;
}
#custom-window-title {
    background-color: #2A3239;;
    margin: 0px 0;
    border-radius: 5px;
    margin-top: 2px;
    margin-left: 2px;
    padding: 0 4px;    
}
#language {
	background-color: #2A3239;
        margin-top: 2px;
        font-size: 17px;
}
#tray, #custom-firefox, #custom-steam, #custom-discord, #custom-telegram-desktop, #custom-alacritty, #custom-youtube-music, #custom-keyboard {
	background-color: #2A3239;
	margin-top: 2px;
	margin-right: 4px;
	margin-left: 4px;
	border-radius: 5px;
	font-size: 17px;
}

#custom-launcher {
    background-color: transparent;
    color: #89b4fa;
    font-size: 20px;
    padding: 0 10px;
    margin: 2px 0;
}


#workspaces {
background-color: #2A3239;;
color: #FFFFFF;
border: 2px solid black;
margin-top: 2px;
border: #2A3239;;
border-radius: 5px; 
}

#workspaces button {
    background-color: #2A3239;;
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
    background-color: #2A3239;;
    padding: 4px 12px;
    margin: 0px 0;
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
    margin-top: 2px;
}

#clock{
	background-color: #2A3239;;
	padding: 2px 0;  /* 2 - сверху снизу, 6 - српава, слева*/
	padding-right: 10px;
	margin: 0px 0;
	border-radius: 0px;
	margin-top: 2px;
}
#disk{ 
    background-color: #2A3239;
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    margin: 0px 0;
    border-bottom-right-radius: 5px;
    border-top-right-radius: 5px;
    margin-top: 2px;

}

#custom-bluetooth { 
    background-color: #2A3239;
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    margin: 0px 0;
    margin-top: 2px;
}
#battery{
    background-color: #2A3239;
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    margin: 0px 0;
    margin-top: 2px;
}
#network{
    background-color: #2A3239;
    padding: 4px 12px; /* 10px сверху, 20px справа, 30px снизу, 40px слева */
    border-radius: 0px;
    border-bottom-left-radius: 5px;
    border-top-left-radius: 5px;
    margin-top: 2px;
}
#pulseaudio {
        background-color: #2A3239;;
        padding: 4px 12px 4px 12px;
	border-bottom-right-radius: 5px;
	border-top-right-radius: 5px;
	margin-top: 2px;
}
#memory {
        background-color: #2A3239;;
        padding: 2px 6px;
        border-radius: 0px;
	margin-top: 2px;
}
#cpu{
        background-color: #2A3239;
        padding: 4px 10px;
        border-radius: 0px;
	margin-top: 2px;
}
#custom-power {
    background-color: transparent;
    color: #f38ba8;
    font-size: 20px;
    padding: 0 12px;
    margin: 4px 0;
    margin-top: 2px;
}
	'';

};

}
