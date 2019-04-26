#!/bin/bash

set -e

ln -sf ~/.vim/vimrc ~/.vimrc
touch ~/.vimrc.local
mkdir -p ~/.vim/undodir

vim +PlugUpdate +qall

