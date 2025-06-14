{ config, pkgs, ... }:
{
  imports =
    [
        ./configurations/hardware-configuration.nix
        ./configurations/programs.nix
        #./configurations/amd.nix
        ./configurations/nvidia.nix
        #./configurations/nvidia_prime.nix
    ];
#------Services---------------------------------------------------------------------------------------------------------------------------------
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.blueman.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
  services.libinput.enable = true;
  services.tlp.enable = true;
#------Programs-------------------------------------------------------------------------------------------------------------------------------
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.virt-manager.enable = true;
#------Other------------------------------------------------------------------------------------------------------------------------------------
  hardware.bluetooth.enable = true;
  networking.networkmanager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "allaor" ];
#------Ssh--------------------------------------------------------------------------------------------------------------------------------------
  services.openssh = {
  enable = true;
  settings = {
    PermitRootLogin = "yes";
    PasswordAuthentication = true;
    Port = 2222;
  };
  };
#------User-----------------------------------------------------------------------------------------------------------------------------------
  users.users.alloar = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "alloar";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    packages = with pkgs; [];
  };
#------Laptop----------------------------------------------------------------------------------------------------------------------------------
  #services.logind.extraConfig = ''
  #HandleLidSwitch=ignore
  #HandleLidSwitchDocked=ignore
  #'';
#------System_shit-----------------------------------------------------------------------------------------------------------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  networking.hostName = "nixos";
  time.timeZone = "Europe/Warsaw";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.overlays = [
    (self: super: {
      unstable = import <nixpkgs-unstable> {
        config.allowUnfree = true;
      };
    })
  ];
}
