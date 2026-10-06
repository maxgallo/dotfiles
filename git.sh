#!/bin/bash
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/brew-utils.sh
source ./utils/file_system.sh
source ./utils/log.sh

mandatoryBrew

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

    echo "Kept: ~/.gitconfig.local (your git identity)"

    exit
fi

logStep "Installing Git"
for i in "${brew_packages[@]}"
do
    :
    brew install "$i"
done

logStep "Symlinking .gitconfig file"
removeIfExists ~/.gitconfig
ln -s "$dotfiles_folder/git/.gitconfig" ~/.gitconfig

logStep "Symlinking .gitignore_global file"
removeIfExists ~/.gitignore_global
ln -s "$dotfiles_folder/git/.gitignore_global" ~/.gitignore_global

if [ ! -f ~/.gitconfig.local ]; then
    logStep "Setting your git identity in ~/.gitconfig.local (not tracked)"
    read -p "Name: " git_name
    read -p "Email: " git_email
    git config --file ~/.gitconfig.local user.name "$git_name"
    git config --file ~/.gitconfig.local user.email "$git_email"
fi
