#!/bin/bash
DOTFILES_FOLDER=~/src/github/maxgallo/dotfiles

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

    read -p "Would you like to set up Fish Shell ? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        . ./fish.sh    # with the leading dot, fish.sh is executed in the same shell, so they can share variables
    fi

    cd $DOTFILES_FOLDER

    read -p "Would you like to set up Vim? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        ./vim.sh
    fi

    read -p "Would you like to copy gitconfig file? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp .gitconfig ~/.gitconfig
    fi
fi
