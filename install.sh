#!/bin/bash

# load variables
. ./var.sh

# Install stuff on  on OS X
if [[ $(uname) == 'Darwin' ]]; then
    read -p "Would you like to set up Homebrew? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ./brew.sh
    fi

    read -p "Would you like to set up macOS preferences? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ./macos.sh
    fi

    read -p "Would you like to install python 3.5.4? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ./python.sh
    fi

    read -p "Would you like to set up Fish Shell ? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        . ./fish.sh    # with the leading dot, fish.sh is executed in the same shell, so they can share variables
    fi

    cd $DOTFILES_FOLDER

    read -p "Would you like to set up Vim? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        . ./vim.sh    # with the leading dot, fish.sh is executed in the same shell, so they can share variables
    fi

    read -p "Would you like to copy gitconfig file? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp .gitconfig ~/.gitconfig
    fi

    read -p "Would you like install npm dependencies? (y/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        . ./npm.sh 
    fi
fi

# copy bashrc
cp .bashrc ~/.bashrc
cp .bash_profile ~/.bash_profile

