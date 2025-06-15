#!/bin/bash

cp -r /etc/nixos/* ~/home/nix/
# -r означает рекурсивно, то есть скопировать все директории и каталоги 
rm -rf ~/home/nix/hardware-configurations.nix
rm -rf ~/home/nix/configurations/hardware-configurations.nix
