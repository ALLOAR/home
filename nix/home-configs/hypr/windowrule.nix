{ config, pkgs, ... }:

{
settings = {
	# окно "Картинка в картинке"

		windowrulev2 = [
		# "pin, title:^(Picture-in-Picture)$"
		"pin, title:.*Picture-in-Picture.*"
		"noborder, title:.*Picture-in-Picture.*"

		# STEAM
		# "float, class:^steam$"
		# "move 90 90, class:^steam$"
		# "size 1740 900, class:^(.*steam.*)$"
		"opacity 0.9 0.9, class:^(.*steam.*)$"

		# TELEGRAM
		"float, class:^org\\.telegram\\.desktop$"
		"move 106 90, class:^org\\.telegram\\.desktop$"
		"size 800 900, class:^(.*org.telegram.desktop.*)$"
		"opacity 0.94 0.94, class:^(.*org.telegram.desktop.*)$"

		# DISCORD
		"float, class:^discord$"
		"move 1012 90, class:^discord$"
		"size 800 900, class:^(.*discord.*)$"
		"opacity 0.94 0.94, class:^(.*discord.*)$"

		# FIREFOX
		"opacity 0.96 0.96, class:^firefox$"
		"opacity 1.0 1.0, title:^(.*YouTube — Mozilla Firefox)$"
	];
};
}
