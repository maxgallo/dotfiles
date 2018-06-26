#!/bin/bash
if [ "$1" == "--remove" ] || [ "$1" == "-r" ]; then
    echo "Unistalling Pathogen"
    rm -rf ~/.vim/autoload/pathogen.vim
    rm -rf ~/.vim/bundle
    brew uninstall the_silver_searcher
    brew uninstall cmake
    exit
fi

# Variables
PATHOGEN_PATH=~/.vim/bundle


# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Copy config file
cp ./.vimrc ~/.vimrc

# Change folder to pathogen bundle folder
cd ~/.vim/bundle/

# Silver Searcher - search in the whole project
brew install the_silver_searcher
git clone https://github.com/rking/ag.vim $PATHOGEN_PATH/ag

# You Complete Me - autocomplete
brew install cmake
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer --tern-completer
cp $DOTFILES_FOLDER/.tern-config ~/.tern-config # add tern config
cd ..

# Color scheme
git clone https://github.com/flazz/vim-colorschemes.git colorschemes

# Other plugins
git clone https://github.com/kien/ctrlp.vim.git ctrlp.vim
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/scrooloose/nerdtree.git nerdtree
git clone https://github.com/ternjs/tern_for_vim.git
cd tern_for_vim/
npm install
cd ..
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/heavenshell/vim-jsdoc.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/terryma/vim-multiple-cursors.git

git clone https://github.com/craigemery/vim-autotag.git
git clone git://github.com/tpope/vim-surround.git

# Asynchronous linting engine
git clone https://github.com/w0rp/ale

# CSSNext support
git clone https://github.com/hail2u/vim-css3-syntax.git

git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q

# Install powerline
pip install powerline-status

# This fix the error while commit with git using vim
git config --global core.editor /usr/bin/vim

# ctags
brew install ctags
cp $DOTFILES_FOLDER/.ctags ~/.ctags
