#!/bin/bash
# Server setup: bash, git, vim (NERDTree, fzf) and Claude Code. Run from the repo root:
#   ./hosts/linuxmacmini/install.sh
source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh
source ./utils/file_system.sh

host_folder="$dotfiles_folder/hosts/linuxmacmini"
apt_packages="git curl vim bat"

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove the server configuration?" || exit

    echo "Removing ~/.bash_aliases, ~/.gitconfig, ~/.gitignore_global and ~/.vimrc symlinks"
    rm -f ~/.bash_aliases ~/.gitconfig ~/.gitignore_global ~/.vimrc

    echo "Removing vim-plug and the vim plugins"
    rm -rf ~/.vim/autoload/plug.vim ~/.vim/plugged

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

logStep "Symlinking .vimrc"
linkWithBackup "$host_folder/vimrc" ~/.vimrc

logStep "Installing vim plugins and the fzf binary"
# fzf#install() also covers a plugin installed before its download hook existed
vim -Es -u ~/.vimrc -c 'PlugInstall --sync' -c 'call fzf#install()' -c 'qa!'
~/.vim/plugged/fzf/bin/fzf --version

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
