#!/bin/bash

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Copy config file
cp ./.vimrc ~/.vimrc


cd ~/.vim/bundle/

# Silver Searcher - search in the whole project
brew install the_silver_searcher
git clone https://github.com/rking/ag.vim ag

# You Complete Me - autocomplete
brew install cmake
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py --tern-completer
cd ..

# Color scheme
git clone https://github.com/flazz/vim-colorschemes.git colorschemes
git clone git@github.com:yosiat/oceanic-next-vim.git # not sure if I need this one

# Other plugins
git clone https://github.com/kien/ctrlp.vim.git ctrlp.vim
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/scrooloose/nerdtree.git nerdtree
git clone https://github.com/ternjs/tern_for_vim.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/heavenshell/vim-jsdoc.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/terryma/vim-multiple-cursors.git

git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q






