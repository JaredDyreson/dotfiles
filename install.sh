#!/usr/bin/env bash

# Install all the tools you need

ARCH_USER=jared
DEST="/home/$ARCH_USER"

# NeoVim configurations
cp -ar ~/.config/nvim $DEST
nvim +silent +PackerSync +PackerInstall +qall

# ZSH install

sudo pacman -Sy --noconfirm zsh curl powerline powerline-fonts
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
cp .zshrc $DEST/.zshrc
sudo pacman -S --noconfirm zsh-autosuggestions
yay -S --noconfirm zsh-syntax-highlighting

echo "[+] Installing Rust components...."
source dev-tools/rust.sh

echo "[+] Installing desktop applications"
sudo pacman -Sy firefox zathura zathura-pdf-poppler
yay -Sy discord

echo "[+] Installing launchers and other desktop environment things"
sudo pacman -Sy --noconfirm polybar dunst dmenu
