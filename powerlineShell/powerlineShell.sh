#!/bin/bash

# load variables
. ./var.sh

echo "Installing Powerline Shell"

cd ~
rm -rf powerline-shell
git clone git@github.com:maxgallo/powerline-shell.git
cd powerline-shell/
cp $DOTFILES_FOLDER/powerlineShell/config.py .
./install.py
cd $DOTFILES_FOLDER
