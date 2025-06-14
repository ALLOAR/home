{ config, pkgs, ... }: {
	home = {
		username = "alloar";
		homeDirectory= "/home/alloar";
		stateVersion = "24.11";
	};
	
	imports = [
	./home-configs/zsh.nix
	./home-configs/alacritty.nix
];
}

