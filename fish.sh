#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install fish
brew install fish

# Install oh my fish
if [[ ! "$(type -P omf)" ]]; then
	echo "Installing Oh My Fish"
	curl -L http://get.oh-my.fish | fish
	omf install nvm
fi

# Copying fish configuration
rm -rf ~/.config/fish/config.fish
cp ./config.fish ~/.config/fish/config.fish

# Installine powershell
cd ~
git clone git@github.com:maxgallo/powerline-shell.git
cd powerline-shell/ 
cp config.py.dist config.py
./install.py
 
