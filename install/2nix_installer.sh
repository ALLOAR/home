#!/bin/bash
set -e
cd
echo "  [1/2] "
echo "-- what you want ---"
choise=$(gum choose arch nix)
echo "You want that $choise?"

cd
echo -e "\e[32mCloning main git\e[0m"
git clone --branch main --single-branch https://github.com/ALLOAR/NixOS > /dev/null 2>&1
cd NixOS
mkdir -p /etc/nixos/configurations
mkdir -p ~/.config
mkdir -p ~/.config/home-manager/
mkdir -p ~/.config/hypr/
case "$choise" in
  nix)    mkdir -p ~/save_nix_configs
	  cp -r /etc/nixos/* ~/save_nix_configs/
	  sudo cp -r * /etc/nixos/
	  rm -rf NixOS
	  git clone --branch home --single-branch https://github.com/ALLOAR/NixOS > /dev/null 2>&1
	  cd NixOS/config
	  cp -r * ~/.config/
	  cd
	  ;;
  arch)
	  echo -e "\e[32m Cloning home git\e[0m"
	  git clone --branch home --single-branch https://github.com/ALLOAR/NixOS > /dev/null 2>&1
	  cd NixOS/config
          cp -r * ~/.config/
	  cd
	  ;;
esac
if [ -d ~/.ssh ]; then
    echo "ssh key already exist"
else
    echo "generating ssh key"
    printf "\n\n\n" | ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
    printf "\n\n\n" | sudo ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
fi
