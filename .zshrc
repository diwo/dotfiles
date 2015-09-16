[[ -s "$HOME/.xshrc" ]] && source "$HOME/.xshrc"

# Update title bar with $PWD, used by Terminal.app to cd into when opening new tabs
precmd() { print -Pn "\e]2; %~ \a" }

# Contribs
autoload colors && colors
autoload -U select-word-style && select-word-style bash

# Prompts
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'  #wrap colours between %{ %} to avoid weird gaps in autocomplete
    eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'
PS1="${CYAN}%n${RESET}@${MAGENTA}%m${RESET}:${YELLOW}%~${RESET}\$${RESET} "

# Keybinds
bindkey -v
bindkey -rpM viins '^['
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^S" history-incremental-search-forward
bindkey -M viins "^B" backward-char
bindkey -M viins "^F" forward-char
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^[b" backward-word
bindkey -M viins "^[f" forward-word
bindkey -M viins "^?" backward-delete-char
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^K" kill-line
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^Y" yank
bindkey -M viins "^O" accept-and-infer-next-history
bindkey -M vicmd "^O" accept-and-infer-next-history
bindkey -M viins "^[." insert-last-word
export KEYTIMEOUT=1 # reduces <ESC> vi-mode delay

# History
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
#setopt share_history
setopt extended_history
alias history='history -Di'

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' list-colors 'di=01;34'
zstyle ':completion:*' menu select=2
source <(npm completion)
eval "$(grunt --completion=zsh)"

# Misc
setopt extendedglob
setopt correct
setopt no_multios
setopt interactive_comments
setopt pushd_silent
setopt pushd_minus
