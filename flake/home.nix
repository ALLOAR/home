{ config, pkgs, ... }: {
	home = {
		username = "alloar";
		homeDirectory= "/home/alloar";
		stateVersion = "25.05";
	};
	
	imports = [
	./home-configs/zsh.nix
	./home-configs/alacritty.nix
	./home-configs/git.nix
	./home-configs/hyprland.nix
	./bundle.nix
];
}

