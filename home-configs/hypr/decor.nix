{ config, pkgs, ... }:

{
	settings = {
		#------Border------------------------------------------------------------------------------------------------------------------------------->
		general = {
			gaps_in = 3;
			gaps_out = 10;
			#border_size = 2;

			# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info
			# rgba(ff00ffee)
			# Красный = ff = 255
			# Зелёный = 00 = 0
			# Синий = ff = 255
			# Прозрачность = ee = 93%

			#col.active_border = "rgba(ff00ffee) rgba(ff8800ee) rgba(ffff00ee) 45deg";
			#col.inactive_border = "rgba(595959aa)";

			# Set to true to enable resizing windows by clicking and dragging on borders
			# Этот параметр управляет поведением изменения размера окна, когда ты тащишь его за границу
			# Рекомендуется оставить false, если ты не хочешь, чтобы соседние окна "скакали"
			resize_on_border = false;

			# https://wiki.hyprland.org/Configuring/Tearing/
			# Разрывы случаются, когда обновление экрана и рендер окон происходят не синхронно
			# false - vsync
			# true - no vsync
			allow_tearing = false;

			layout = "dwindle";
		};

		#------Opacity------------------------------------------------------------------------------------------------------------------------------->
		decoration = {
			rounding = 10;

			# Change transparency of focused and unfocused windows
			# active_opacity = 0.95;
			# inactive_opacity = 0.95;
			# тут вроде всё понятно, но эффекта я не вижу, та и поебать
			# разве что render_power - Управляет силой размытия

			shadow = {
				enabled = true;
				range = 4;
				render_power = 3;
				color = "rgba(1a1a1aee)";
			};

			# https://wiki.hyprland.org/Configuring/Variables/#blur
			blur = {
				enabled = true;
				size = 3;
				passes = 1;
				vibrancy = 0.1696;
			};
		};
	};
}
