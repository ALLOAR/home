{ config, pkgs, ... }:

{
settings = {
	bind = [
	"SUPER, RETURN, exec, alacritty"
	"SUPER, C, killactive,"
	"SUPER, M, exit,"
	"SUPER, E, exec, thunar"
	"SUPER, Z, togglefloating,"
	"SUPER, R, exec, wofi"
	"SUPER, P, pseudo," # dwindle
	"SUPER, J, togglesplit," # dwindle
	"SUPER, T, exec, telegram-desktop"
	"SUPER, U, fullscreen"
	"SUPER, D, exec, discord"
	"SUPER, S, exec, steam"
	"SUPER, O, exec, obsidian"
	"SUPER, P, exec, pavucontrol"
	"SUPER, I, exec, hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 1740 950 && hyprctl dispatch moveactive exact 90 70"
	"ALT, TAB, workspace, previous"
	"SUPER, B, exec, bluetoothctl connect 9C:49:52:96:C8:87"
	"SUPER, T, exec, /home/alloar/.config/hypr/prog.sh"
	"SUPER, K, exec, hyprctl dispatch pin active && hyprctl dispatch togglefloating && hyprctl dispatch resizeactive exact 480 270"
	"SUPER, H, exec, cd ~/nix && home-manager switch --flake .#alloar"

	# ------Workspaces binds------------------------------------------------------------------------------------------------------------------------>
	# Перемещение окон
	"SUPER SHIFT, left, swapwindow, l"
	"SUPER SHIFT, right, swapwindow, r"
	"SUPER SHIFT, up, swapwindow, u"
	"SUPER SHIFT, down, swapwindow, d"

	# Изменение размера окна (X Y)
	"SUPER CTRL, left, resizeactive, -60 0"
	"SUPER CTRL, right, resizeactive, 60 0"
	"SUPER CTRL, up, resizeactive, 0 -60"
	"SUPER CTRL, down, resizeactive, 0 60"

	# Перемещение фокуса клавишами-стрелками
	"SUPER, left, movefocus, l"
	"SUPER, right, movefocus, r"
	"SUPER, up, movefocus, u"
	"SUPER, down, movefocus, d"

	# Рабочие пространства
	"SUPER, 0, workspace, 10"
	"SUPER SHIFT, 1, movetoworkspace, 1"
	"SUPER SHIFT, 2, movetoworkspace, 2"
	"SUPER SHIFT, 3, movetoworkspace, 3"
	"SUPER SHIFT, 4, movetoworkspace, 4"
	"SUPER SHIFT, 5, movetoworkspace, 5"
	"SUPER SHIFT, 6, movetoworkspace, 6"
	"SUPER SHIFT, 7, movetoworkspace, 7"
	"SUPER SHIFT, 8, movetoworkspace, 8"
	"SUPER SHIFT, 9, movetoworkspace, 9"
	"SUPER SHIFT, 0, movetoworkspace, 10"

	# Примеры специальных рабочих пространств
	# "SUPER, S, togglespecialworkspace, magic"
	# "SUPER SHIFT, S, movetoworkspace, special:magic"

	# Скроллинг между рабочими пространствами
	"SUPER, mouse_down, workspace, e+1"
	"SUPER, mouse_up, workspace, e-1"

	# Программы
	"SUPER, F, exec, firefox && notify-send \"Firefox started\""
	"SUPER, SPACE, exec, wofi"
	"SUPER+ALT, R, exec, hyprctl reload && notify-send \"Hyprland Reloaded\""
	"SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

	# ------Скриншоты----------------------------------------------------------------------------------------------------------------------------->
	# Снимок всей области
	"SUPER, F1, exec, hyprshot -m region -o /home/alloar/Pictures/Screenshots"
	# Снимок активного окна
	"SUPER, F2, exec, hyprshot -m window -o /home/alloar/Pictures/Screenshots"
	# Снимок всего монитора
	"SUPER, F3, exec, hyprshot -m output -o /home/alloar/Pictures/Screenshots"
	"SUPER, 1, workspace, 1"
	"SUPER, 2, workspace, 2"
	"SUPER, 3, workspace, 3"
	"SUPER, 4, workspace, 4"
	"SUPER, 5, workspace, 5"
	"SUPER, 6, workspace, 6"
	"SUPER, 7, workspace, 7"
	"SUPER, 8, workspace, 8"
	"SUPER, 9, workspace, 9"

	];

		bindl = [
			", XF86AudioNext, exec, playerctl next"
			", XF86AudioPause, exec, playerctl play-pause"
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioPrev, exec, playerctl previous"
		];

		bindel = [
			", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
			"CTRL, XF86AudioRaiseVolume, exec, brightnessctl s 10%+"
                        "CTRL, XF86AudioLowerVolume, exec, brightnessctl s 10%-"
			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
			", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
			", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
		];

		bindm = [
			"SUPER, mouse:272, movewindow"
			"SUPER, mouse:273, resizewindow"
		];
	};
}
