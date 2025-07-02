{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "python-2.7.18.8"
      "electron-25.9.0"
    ];
  };

  environment.systemPackages = with pkgs; [

    # --- Base Applications ---
    docker_28
    lsof
    wineWowPackages.waylandFull
    arp-scan
    xwayland
    OVMF
    gamescope
    iptables
    dunst
    qbittorrent
    qemu
    foot
    chrome-export
    firefox
    discord
    spotify
    steam
    whatsapp-for-linux
    telegram-desktop
    obsidian
    zoom-us
    youtube-music
    home-manager
    # --- Core Tools ---
    btop
    htop
    nvtopPackages.nvidia
    pciutils
    file
    tree
    wget
    unzip
    zip
    neofetch
    fastfetch
    scrot
    ffmpeg
    mediainfo
    acpi
    glxinfo
    clinfo
    openssl
    unzip
    ntfs3g
    brightnessctl
    swww
    zram-generator
    lazygit
    nix-index
    imagemagick
    qemu
    virt-manager
    virt-viewer

    # --- Terminals & Shells ---
    kitty
    alacritty
    wezterm
    oh-my-zsh
    zsh
    zsh-powerlevel10k
    fish
    vim

    # --- Programming & Dev Tools ---
    neovim
    gcc
    gnumake
    git
    nodejs
    nginx
    vscode
    php
    python2
    python314
    # python3.withPackages (ps: with ps; [ requests ])
    # python39Full

    # --- File Managers ---
    xfce.thunar
    #dolphin
    ranger
    pcmanfm-qt

    # --- Hyprland & Wayland ---
    lxappearance
    swaykbdd
    jq
    hyprland
    hyprpaper
    hyprlock
    wofi
    xwayland
    wl-clipboard
    cliphist
    wayland
    mako
    xdg-desktop-portal-hyprland
    seatd
    swww
    hyprshot
    gsimplecal

    # --- Xorg / DE Support ---
    picom
    xorg.libX11
    dmenu
    sxhkd

    # --- Screenshotting & Screen Tools ---
    grim
    grimblast
    slurp
    flameshot
    swappy
    screenkey
    gromit-mpx

    # --- Media ---
    mpv
    #kdenlive
    audacity
    shotcut
    glaxnimate

    # --- System Management ---
    udisks
    udiskie
    gvfs
    usbutils
    virtualbox
    spice-vdagent
    accountsservice
    gdm-settings

    # --- Notifications ---
    libnotify
    dunst

    # --- Sound ---
    pipewire
    pulseaudio
    pamixer
    pavucontrol
    blueman
    bluez
    bluez-tools

    # --- Window Managers & UI ---
    herbstluftwm
    polybar
    waybar
    rofi
    gum

    # --- Theming & Fonts ---
    catppuccin
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    papirus-nord
    omni-gtk-theme
    # --- Drivers ---
    pkgs.vulkan-tools
    pkgs.vulkan-loader
    pkgs.vulkan-validation-layers
    pkgs.nvidia-vaapi-driver
    # --- Fonts (handled separately) ---
    # See fonts.packages below
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono    
  ];
}
