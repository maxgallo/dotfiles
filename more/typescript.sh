#!/bin/bash
echo "Need Review before run!"
exit

VIM_BUNDLE_FOLDER=~/.vim/bundle


# TypeScript
git clone https://github.com/leafgarland/typescript-vim.git

## Typescript Required for tsuquyomi:
## Install and compile procvim.vim
git clone https://github.com/Shougo/vimproc.vim.git $VIM_BUNDLE_FOLDER/vimproc.vim
pushd $VIM_BUNDLE_FOLDER/vimproc.vim
make
popd
## Install tsuquyomi
git clone https://github.com/Quramy/tsuquyomi.git $VIM_BUNDLE_FOLDER/tsuquyomi
## Vim TSX for jsx TypeScript component
git clone https://github.com/ianks/vim-tsx.git $VIM_BUNDLE_FOLDER/vim-tsx
