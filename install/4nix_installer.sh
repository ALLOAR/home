echo -e "\e[32mCloning main git\e[0m"
read -p "what system you use (nix, arch) === " choiсe
git clone --branch main --single-branch https://github.com/ALLOAR/home > /dev/null 2>&1
cd home
mkdir -p /etc/nixos/configurations
mkdir -p ~/.config
case "$choiсe" in
  nix)
          cd nix && bash cp-in-nix.sh
	  cd ~/home/config
	  cp -r home-manager ~/.config/
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
