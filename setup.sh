#!/bin/bash

set -e

ln -sf ~/.vim/vimrc ~/.vimrc
touch ~/.vimrc.local
mkdir -p ~/.vim/undodir

pushd ~/.vim > /dev/null
  git submodule init
  git submodule update
popd > /dev/null

vim +PluginUpdate +qall

