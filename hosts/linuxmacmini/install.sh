#!/bin/bash
# Server setup: bash, git, vim and Claude Code. Run from the repo root:
#   ./hosts/linuxmacmini/install.sh
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh
source ./utils/file_system.sh

host_folder="$dotfiles_folder/hosts/linuxmacmini"
apt_packages="git curl vim bat"

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the server configuration?" || exit

    echo "Removing ~/.bash_aliases, ~/.gitconfig and ~/.gitignore_global symlinks"
    rm -f ~/.bash_aliases ~/.gitconfig ~/.gitignore_global

    echo "Kept: ~/.gitconfig.local (your git identity), apt packages and Claude Code"
    exit
fi

logStep "Installing apt packages"
missing=""
for package in $apt_packages; do
    dpkg -s "$package" > /dev/null 2>&1 || missing="$missing $package"
done
if [ -n "$missing" ]; then
    sudo apt-get update && sudo apt-get install -y $missing
else
    echo "already installed:$(printf ' %s' $apt_packages)"
fi

logStep "Installing Claude Code"
if command -v claude > /dev/null || [ -x ~/.local/bin/claude ]; then
    echo "already installed"
else
    curl -fsSL https://claude.ai/install.sh | bash
fi

logStep "Symlinking .bash_aliases (loaded by Debian's default ~/.bashrc)"
linkWithBackup "$host_folder/bash_aliases" ~/.bash_aliases

logStep "Symlinking .gitconfig and .gitignore_global"
linkWithBackup "$host_folder/gitconfig" ~/.gitconfig
linkWithBackup "$dotfiles_folder/git/.gitignore_global" ~/.gitignore_global

if [ ! -f ~/.gitconfig.local ]; then
    logStep "Setting your git identity in ~/.gitconfig.local (not tracked)"
    read -p "Name: " git_name
    read -p "Email: " git_email
    git config --file ~/.gitconfig.local user.name "$git_name"
    git config --file ~/.gitconfig.local user.email "$git_email"
fi
