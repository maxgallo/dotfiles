#!/bin/bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap caskroom/cask
brew doctor
brew update

brew install git
brew install vim
brew install htop
brew install yarn
brew install tree
brew install diff-so-fancy # better diff for git
brew install exa # ls replacement https://github.com/ogham/exa
brew install watch
brew install jq # parse json response https://stedolan.github.io/jq/
brew install bat # cat replacement https://github.com/sharkdp/bat
brew install prettyping # ping replacement https://github.com/denilsonsa/prettyping
brew install fd # user-friendly find alternative https://github.com/sharkdp/fd/
brew install ncdu # better du
brew install tldr # better man https://github.com/tldr-pages/tldr/
brew install noti # notification from terminal https://github.com/variadico/noti

# Quick look plugins
# https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize
