#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Installine powershell
echo "Installing Powerline Shell"
cd ~
rm -rf powerline-shell
git clone git@github.com:maxgallo/powerline-shell.git
cd powerline-shell/ 
#cp config.py.dist config.py
cp $DOTFILES_FOLDER/powerline-shell-config.py config.py
./install.py
cd $DOTFILES_FOLDER

# Install fish
if [[ ! "$(type -P fish)" ]]; then
	echo "Installing Fish"
	brew install fish
fi

# Install oh my fish
if [[ ! "$(type -P omf)" ]]; then
	echo "Installing Oh My Fish"
	curl -L http://get.oh-my.fish | fish
	omf install nvm
fi

# Copying fish configuration
echo "Copy Fish configuration file"
rm -rf ~/.config/fish/config.fish
cp ./config.fish ~/.config/fish/config.fish








