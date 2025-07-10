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
  systemd.user.services."pulseaudio".serviceConfig.Nice = -10;
  systemd.services."bluetooth".serviceConfig.Nice = -10;
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
  virtualisation.docker.enable = true;
#------Ssh--------------------------------------------------------------------------------------------------------------------------------------
  networking.firewall = {
    enable = true;                 # Включить фаервол
    allowedTCPPorts = [ 22 ];   # Открыть порт 2222 для TCP
    allowedUDPPorts = [];         # Если нужны UDP — можно добавить
    # Можно дополнительно разрешить доступ с конкретных IP:
    # extraCommands = ''
    #   iptables -A INPUT -p tcp -s 1.2.3.4 --dport 2222 -j ACCEPT
    # '';
  };
  services.openssh = {
  enable = true;
  settings = {
    PermitRootLogin = "yes";
    PasswordAuthentication = true;
    Port = 22;
  };
  };
#------User-----------------------------------------------------------------------------------------------------------------------------------
  users.users.alloar = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "alloar";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "docker" ];
    packages = with pkgs; [];
    password = "$6$KwHp1/HNKeLSz3PJ$HeXPJct8cjrVYhccYSDKBWYQwzxOBdPpvpRk8lmQ0QgXRMIwsgEeiSRQWQ4oQZRlpBc7gOnCTZExqpH/.3Zn3.";
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
}
