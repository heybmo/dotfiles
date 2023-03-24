#!/usr/bin/env zsh
# Aliases, exports.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Remap vim -> nvim
alias e="nvim";
alias v="nvim";
alias vim="nvim";

# Aliases
alias l="exa -lah --icons";
alias lt="exa -T --long --icons";
alias lg="exa --long --git --icons";
alias c="bat";

# Compilation flags
export ARCHFLAGS="-arch arm64"


