#!/usr/bin/env zsh

# Python
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew';
export PYENV_ROOT="$HOME/.pyenv";
export PATH="$PYENV_ROOT/bin:$PATH";
eval "$(pyenv init -)";

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# JEnv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Golang
export GOPATH="$HOME/go";
export PATH="$PATH:$GOPATH/bin";
export GOBIN="$GOPATH/bin";

# GCC
# Symlink gcc correctly
alias gcc="/opt/homebrew/bin/gcc-12";

