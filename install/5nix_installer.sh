echo -e "\e[32mCloning main git\e[0m"
cd
git clone https://github.com/ALLOAR/home.git > /dev/null 2&>1
cd ~/home
git remote set-url origin git@github.com:ALLOAR/home.git
cp -r ~/home/nix ~/
cd ~/nix
home-manager switch --flake .#alloar

if [ -d ~/.ssh ]; then
    echo "ssh key already exist"
else
    echo "generating ssh key"
    printf "\n\n\n" | ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
    printf "\n\n\n" | sudo ssh-keygen -t ed25519 -C "evgenzbiranik@gmail.com" > /dev/null 2>&1
fi
