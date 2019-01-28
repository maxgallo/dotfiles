#!/bin/bash
source ./utils/config.sh
source ./utils/confirm.sh
source ./utils/log.sh

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall .bash_profile?" || exit

    logStep "Removing .bashrc"
    rm ~/.bashrc

    logStep "Removing .bash_profile"
    rm ~/.bash_profile

    exit
fi

logStep "Symlinking .bashrc"
rm ~/.bashrc
ln -s "$dotfiles_folder/bash/.bashrc" ~/.bashrc

logStep "Symlinkin .bash_profile"
rm ~/.bash_profile
ln -s "$dotfiles_folder/bash/.bash_profile" ~/.bash_profile
