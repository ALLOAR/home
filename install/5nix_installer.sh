echo -e "\e[32mCloning main git\e[0m"
git clone git@github.com:ALLOAR/home.git > /dev/null 2>&1
mkdir -p ~/nix
cp -r * ~/home/flake/* ~/nix
cp /etc/nixos/hardware-configuration.nix ~/nix
cp /etc/nixos/hardware-configuration.nix ~/nix/configurations

if [ -d ~/.ssh ]; then
    echo "ssh key already exist"
else
    echo "generating ssh key"
    printf "\n\n\n" | ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
    printf "\n\n\n" | sudo ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
fi
cd nix
echo " === start isntalation main system with sudo nixos-rebuild switch --flake ./ ==== "
