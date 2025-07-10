{ config, pkgs, ... }:

let
  env = import ./env.nix          { inherit config pkgs; };
  autostart = import ./autostart.nix    { inherit config pkgs; };
  animation = import ./animation.nix    { inherit config pkgs; };
  bind = import ./bind.nix         { inherit config pkgs; };
  misc = import ./misc.nix         { inherit config pkgs; };
  input = import ./input.nix        { inherit config pkgs; };
  monitor = import ./monitor.nix      { inherit config pkgs; };
  windowrule = import ./windowrule.nix  { inherit config pkgs; };

in

{
  programs.hyprland = {
    enable = true;
    settings = settings // monitor // workspaces // autostart;
    settings = env
	// monitor
	// workspaces
	// autostart
	// animation
	// bind
	// misc
	// input
	// windowrule;    
  };

  home.sessionVariables = env;
}
