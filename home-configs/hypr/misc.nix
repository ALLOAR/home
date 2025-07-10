{ config, pkgs, ... }:

{
settings = {
	dwindle = {
		pseudotile = true; # Включает псевдо-тайлинг
		preserve_split = true; # Сохраняет сплит (разделение) при перемещении окон
	};
	master = {
		new_status = "master"; # Устанавливает новый открытый или сфокусированный контейнер/окно как мастер
	};
	misc = {
		force_default_wallpaper = -1; # Значение -1 означает, что Hyprland не принуждает использование дефолтных обоев
		disable_hyprland_logo = false; # Если true — выключается логотип Hyprland, false — логотип остаётся включён
	};
	gestures = {
		workspace_swipe = true; # жесты
	};
	windowrulev2 = [
		# Игнорировать запросы maximize от приложений (удобно)
		"suppressevent maximize, class:.*"
		# Исправляет проблемы с перетаскиванием окон XWayland
		"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
	];
};
}
