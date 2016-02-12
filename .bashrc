[[ -s "$HOME/.xshrc" ]] && source "$HOME/.xshrc"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

ANSI_RESET='\[\e[0m\]'
ANSI_RED='\[\e[1;31m\]'
ANSI_GREEN='\[\e[0;32m\]'
ANSI_YELLOW='\[\e[0;33m\]'
ANSI_BLUE='\[\e[0;34m\]'
ANSI_MAGENTA='\[\e[0;35m\]'
ANSI_CYAN='\[\e[0;36m\]'

PS1="${ANSI_CYAN}\u${ANSI_RESET}@${ANSI_MAGENTA}\h${ANSI_RESET}:${ANSI_YELLOW}\w${ANSI_RESET}\$${ANSI_RESET} "

