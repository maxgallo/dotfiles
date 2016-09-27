#!/bin/bash
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    echo "omf uninstall nvm" | fish
    echo "Uninstalling Oh My Fish"
    curl -L http://get.oh-my.fish > install
    fish install --uninstall -yes
    brew uninstall fish      # removing fish
    echo "Uninstalling powerline"
    rm -rf ~/powerline-shell # removing powerline
    exit
fi
DOTFILES_FOLDER="/Users/$(whoami)/src/github/maxgallo/dotfiles"


# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Installine powerline shell
echo "Installing Powerline Shell"
cd ~
rm -rf powerline-shell
git clone git@github.com:maxgallo/powerline-shell.git
cd powerline-shell/ 
cp $DOTFILES_FOLDER/powerline-shell-config.py config.py #cp config.py.dist config.py
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
    curl -L http://get.oh-my.fish > install
    fish install --noninteractive --yes
    echo "omf install nvm" | fish
fi

# Copying fish configuration
echo "Copy Fish configuration file"
cp $DOTFILES_FOLDER/config.fish ~/.config/fish/config.fish


