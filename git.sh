#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh

brew_packages=(
    git
    diff-so-fancy # better diff for git
)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall Git and reset the configuration?" || exit

    echo "Uninstalling Git"
    for i in "${brew_packages[@]}"
    do
        :
        brew uninstall "$i"
    done

    echo "Removing ~/.gitconfig file"
    rm ~/.gitconfig

    exit
fi

echo "Installing Git"
for i in "${brew_packages[@]}"
do
    :
    brew install "$i"
done

echo "Symlinking .gitconfig file"
rm ~/.gitconfig
ln -s "$dotfiles_folder/git/.gitconfig" ~/.gitconfig
