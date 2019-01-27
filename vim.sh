#!/bin/bash

source ./utils/confirm.sh
source ./utils/config.sh
source ./utils/log.sh

# Remove if --remove variable is present
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    confirm "Are you sure you want to uninstall VIM and reset the configuration?" || exit

    echo "Unistalling Pathogen"
    rm -rf ~/.vim/autoload/pathogen.vim

    echo "Unistalling All Vim plugins"
    rm -rf ~/.vim/bundle

    echo "Unistalling 'brew' related packages"
    brew uninstall the_silver_searcher
    brew uninstall cmake

    echo "Removing ~/.vimrc configuration file"
    rm ~/.vimrc

    echo "Uninstalling Powerline Status"
    pip3 uninstall -y powerline-status

    exit
fi

# Variables
pathogen_path=~/.vim/bundle

# Install pathogen
logStep "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Copy config file
logStep "Symlinking .vimrc file"
ln -s "$dotfiles_folder/vim/.vimrc" ~/.vimrc

# Change folder to pathogen bundle folder
cd ~/.vim/bundle/ || exit

# Silver Searcher - search in the whole project
logStep "Installing Silver Searcher"

brew install the_silver_searcher
git clone https://github.com/rking/ag.vim $pathogen_path/ag

# You Complete Me & TSServer - autocomplete
logStep "Installing You Complete Me & TSServer"

npm install -g typescript

brew install cmake
git clone https://github.com/Valloric/YouCompleteMe.git
(
cd YouCompleteMe || exit
git submodule update --init --recursive
./install.py --clang-completer
)

# Color scheme
logStep "Installing Color Scheme"
git clone https://github.com/flazz/vim-colorschemes.git colorschemes

# Other plugins
logStep "Installing Other Plugins"
git clone https://github.com/kien/ctrlp.vim.git ctrlp.vim
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/scrooloose/nerdtree.git nerdtree
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/heavenshell/vim-jsdoc.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/terryma/vim-multiple-cursors.git
git clone git://github.com/tpope/vim-surround.git
git clone git://github.com/jiangmiao/auto-pairs.git # autoinsert brakets
git clone https://github.com/roryokane/detectindent.git # enables :DetectIndent
git clone https://github.com/prettier/vim-prettier # :Prettier

# Asynchronous linting engine, aka ALE
git clone https://github.com/w0rp/ale

# CSSNext support
git clone https://github.com/hail2u/vim-css3-syntax.git

git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q

# Install powerline
logStep "Installing Powerline Status"
pip3 install powerline-status
