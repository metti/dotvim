#!/bin/bash

set -e

ln -sf ~/.vim/vimrc ~/.vimrc
touch ~/.vimrc.local
mkdir -p ~/.vim_undodir

vim +PlugUpdate +qall

