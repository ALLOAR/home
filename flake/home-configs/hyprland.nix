{ config, pkgs, ... }:
let
  terminal = "alacritty";
  fileManager = "dolphin";
  menu = "wofi";
  mainMod = "SUPER";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Ice"
      ];

      exec-once = [
        "hyprpaper"
        "${terminal}"
        "waybar"
        "dunst"
        "firefox"
        "steam"
        "discord"
        "telegram-desktop"
        "swww init"
        "systemctl --user start swww"
      ];

      monitor = [
        "DVI-D-1,1920x1080@59,1366x0,1"
      ];

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

  input = {
    kb_layout = "us,ru";
    kb_options = "grp:alt_shift_toggle";
    follow_mouse = 1;
    sensitivity = 0;
    touchpad = {
      natural_scroll = false;
    };
  };


      cursor = {
        no_hardware_cursors = false;
        inactive_timeout = 0;
      };

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

      windowrulev2 = [
        "workspace 5, class:^(steam)$"
        "workspace 4, class:^(org.telegram.desktop)$"
        "workspace 4, class:^(discord)$"
        "workspace 3, class:^(firefox)$"
        "workspace 2, class:^(obsidian)$"
       
	 "float, class:^org\\.telegram\\.desktop$"
        "move 106 90, class:^org\\.telegram\\.desktop$"
        "size 800 900, class:^(.*org.telegram.desktop.*)$"
        "opacity 0.94 0.94, class:^(.*org.telegram.desktop.*)$"
        "float, class:^discord$"
        "move 1012 90, class:^discord$"
        "size 800 900, class:^(.*discord.*)$"
        "opacity 0.94 0.94, class:^(.*discord.*)$"
        "opacity 0.96 0.96, class:^firefox$"
        "opacity 1.0 1.0, title:^(.*YouTube — Mozilla Firefox)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      gestures.workspace_swipe = true;

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
    };

    extraConfig = ''
      # binds
      bind = ${mainMod}, RETURN, exec, ${terminal}
      bind = ${mainMod}, C, killactive,
      bind = ${mainMod}, M, exit,
      bind = ${mainMod}, E, exec, ${fileManager}
      bind = ${mainMod}, Z, togglefloating,
      bind = ${mainMod}, R, exec, ${menu}
      bind = ${mainMod}, P, pseudo,
      bind = ${mainMod}, J, togglesplit,
      bind = SUPER, T, exec, telegram-desktop
      bind = SUPER, U, fullscreen
      bind = SUPER, D, exec, discord
      bind = SUPER, S, exec, steam
      bind = SUPER, O, exec, obsidian
      bind = SUPER, P, exec, pavucontrol
      bind = SUPER, I, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 1740 950 && hyprctl dispatch moveactive exact 1456 70
      bind = ALT, TAB, workspace, previous

      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      # Workspaces movement
      bind = ${mainMod} SHIFT, left, swapwindow, l
      bind = ${mainMod} SHIFT, right, swapwindow, r
      bind = ${mainMod} SHIFT, up, swapwindow, u
      bind = ${mainMod} SHIFT, down, swapwindow, d

      bind = ${mainMod} CTRL, left, resizeactive, -60 0
      bind = ${mainMod} CTRL, right, resizeactive, 60 0
      bind = ${mainMod} CTRL, up, resizeactive, 0 -60
      bind = ${mainMod} CTRL, down, resizeactive, 0 60

      bind = ${mainMod}, left, movefocus, l
      bind = ${mainMod}, right, movefocus, r
      bind = ${mainMod}, up, movefocus, u
      bind = ${mainMod}, down, movefocus, d

      # workspaces
      ${builtins.concatStringsSep "\n" (builtins.genList (i: ''
        bind = ${mainMod}, ${toString i}, workspace, ${toString i}
        bind = ${mainMod} SHIFT, ${toString i}, movetoworkspace, ${toString i}
      '') 10)}

      bind = ${mainMod}, mouse_down, workspace, e+1
      bind = ${mainMod}, mouse_up, workspace, e-1

      bindm = ${mainMod}, mouse:272, movewindow
      bindm = ${mainMod}, mouse:273, resizewindow

      # Apps
      bind = SUPER, F, exec, firefox && notify-send "Firefox started"
      bind = SUPER, SPACE, exec, ${menu}
      bind = SUPER+ALT, R, exec, hyprctl reload && notify-send "Hyprland Reloaded"
      bind = ${mainMod}, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

      # Screenshots
      bind = SUPER, F1, exec, hyprshot -m region -o /home/alloar/Pictures/Screenshots
      bind = SUPER, F2, exec, hyprshot -m window -o /home/alloar/Pictures/Screenshots
      bind = SUPER, F3, exec, hyprshot -m output -o /home/alloar/Pictures/Screenshots
    '';
  };
}
