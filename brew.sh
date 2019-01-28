#!/bin/bash
source ./utils/confirm.sh

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
)

brew_cask_packages=(
    # Browsers
    google-chrome
    google-chrome-canary
    firefox
    firefox-developer-edition
    firefox-nightly

    # More
    iterm2 # better terminal
    drawio # Macosx desktop client
    macdown # Markdown client
    visual-studio-code
    slack
    charles # Proxy
    virtualbox
    notion
    docker
    dropbox
    1password

    # Quick look plugins (https://github.com/sindresorhus/quick-look-plugins)
    qlcolorcode
    qlstephen
    qlmarkdown
    quicklook-json
    qlimagesize
)

if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to disinstall Brew and all the packages?" || exit

    for i in "${brew_packages[@]}"
    do
        :
        brew uninstall "$i"
    done

    echo "Uninstalling Brew Cask packages"

    for i in "${brew_cask_packages[@]}"
    do
        :
        brew cask uninstall "$i"
    done

    # If Brew exists, uninstalling it
    if [[ "$(type -P brew)" ]]; then
        echo "Uninstalling Brew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
    fi

    exit
fi

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap caskroom/cask
brew doctor
brew update

echo "Installing Brew packages"

for i in "${brew_packages[@]}"
do
   :
   brew install "$i"
done

echo "Installing Cask packages"

for i in "${brew_cask_packages[@]}"
do
   :
   brew cask install "$i"
done
