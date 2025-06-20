#!/bin/bash

cp -r /etc/nixos/* ~/home/nix/
rm -f ~/home/nix/hardware-configuration.nix
rm -f ~/home/nix/configurations/hardware-configuration.nix
