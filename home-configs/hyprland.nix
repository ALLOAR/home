{ config, pkgs, ... }:

let
  decor = import ./hypr/decor.nix	{inherit config pkgs; };
  env = import ./hypr/env.nix          { inherit config pkgs; };
  autostart = import ./hypr/autostart.nix    { inherit config pkgs; };
  animation = import ./hypr/animation.nix    { inherit config pkgs; };
  bind = import ./hypr/bind.nix         { inherit config pkgs; };
  misc = import ./hypr/misc.nix         { inherit config pkgs; };
  input = import ./hypr/input.nix        { inherit config pkgs; };
  monitor = import ./hypr/monitor.nix      { inherit config pkgs; };
  windowrule = import ./hypr/windowrule.nix  { inherit config pkgs; };

in

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = env.settings
      // monitor.settings
      // autostart.settings
      // animation.settings
      // bind.settings
      // misc.settings
      // input.settings
      // windowrule.settings;
      #// decor.settings; # если хочешь
  };

  home.sessionVariables = env.settings;
}

