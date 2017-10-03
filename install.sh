#!/bin/bash
if type git >/dev/null 2>&1 && [ ! -e $HOME/.tmux.conf ]; then
  git clone https://github.com/TNaky/tmux.git $HOME/.tmux
  ln -s $HOME/.tmux/tmux.conf $HOME/.tmux.conf
fi
