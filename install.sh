#!/bin/bash

git clone https://github.com/gwangyi/neo-dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles
git remote set-url origin git@github.com:gwangyi/neo-dotfiles
sh setup.sh
