#!/bin/bash

grep "source ~/.dotfiles/zsh/init.zsh" $HOME/.zshrc > /dev/null 2>/dev/null || \
	echo "source ~/.dotfiles/zsh/init.zsh" >> ~/.zshrc

grep "source ~/.dotfiles/zsh/env.zsh" $HOME/.zshenv > /dev/null 2>/dev/null || \
	echo "source ~/.dotfiles/zsh/env.zsh" >> ~/.zshenv

grep 'Include "~/.dotfiles/ssh/' $HOME/.ssh/config > /dev/null 2>/dev/null || \
	echo 'Include "~/.dotfiles/ssh/*"' >> ~/.ssh/config
