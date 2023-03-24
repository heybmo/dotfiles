#!/usr/bin/env zsh

# Make homebrew work
eval "$(/opt/homebrew/bin/brew shellenv)";
# Avoid potential python conflicts
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew';

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --pretty --smart-case --hidden --follow --vimgrep --glob "!.git/*"';
    export FZF_DEFAULT_OPTS='-m --height 50% --border';
fi

