#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

pkg up -y || exit
pkg in -y openssh zsh git perl ncurses-utils neovim python termux-api build-essential || exit
pip install -U setuptools pip wheel virtualenv || exit
PY3_OUTDATED=$(pip list -o --format freeze)
[[ -n "$PY3_OUTDATED" ]] && echo "$PY3_OUTDATED" | sed 's/=.*//' | xargs pip install -U

mkdir -p "$HOME/.termux" 2> /dev/null

curl -fL https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf -o "$HOME/.termux/font.ttf"

curl -fL https://github.com/gwangyi/neo-dotfiles/raw/main/termux/colors.properties -o "$HOME/.termux/colors.properties"

curl -fL https://github.com/gwangyi/neo-dotfiles/raw/main/install.sh | bash

chsh -s zsh

ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -N ''

# vim: set ts=4 sw=4 et:
