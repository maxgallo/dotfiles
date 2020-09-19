#!/bin/bash
source ./utils/confirm.sh
source ./utils/brew-utils.sh

brew_packages=(
    vim
    htop
    yarn
    tree
    exa # ls replacement https://github.com/ogham/exa
    watch
    jq # parse json response https://stedolan.github.io/jq/
    bat # cat replacement https://github.com/sharkdp/bat
    prettyping # ping replacement https://github.com/denilsonsa/prettyping
    fd # user-friendly find alternative https://github.com/sharkdp/fd/
    ncdu # better du
    tldr # better man https://github.com/tldr-pages/tldr/
    noti # notification from terminal https://github.com/variadico/noti
    nmap
    hub # command-line tool that makes git easier to use with GitHub
    tfenv # multiple terraform versions
    fzf # command-line finder
    github-markdown-toc # create table of content in markdown files
)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to remove all Brew packages?" || exit

    for i in "${brew_packages[@]}"
    do
        :
        brew uninstall "$i"
    done

    confirm "Do you want to disinstall Brew itself ?" || exit

    uninstallBrew

    exit
fi

# Make sure homebrew is installed first
mandatoryBrew

brew doctor
brew update

echo "Installing Brew packages"

for i in "${brew_packages[@]}"
do
   :
   brew install "$i"
done

# Post installation
tfenv install # this will install latest package
