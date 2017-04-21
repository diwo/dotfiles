[[ -s "$HOME/.xshrc" ]] && source "$HOME/.xshrc"

# Update title bar with $PWD, used by Terminal.app to cd into when opening new tabs
precmd() { print -Pn "\e]2; %~ \a" }

# Contribs
autoload colors && colors
autoload -U select-word-style && select-word-style bash
autoload -U edit-command-line && zle -N edit-command-line

# Prompts
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]'
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
  # wrap colours between %{ %} to avoid weird gaps in autocomplete
  eval T_$COLOR="%{\$$COLOR%}"
  eval T_BOLD_$COLOR="%{\$$BOLD_COLOR%}"
  # export
  export $COLOR BOLD_$COLOR
done
eval RESET=$reset_color
export RESET
eval T_RESET="%{$RESET%}"
ps1single() {
  PS1="${T_CYAN}%n${T_RESET}@${T_MAGENTA}%m${T_RESET}:${T_YELLOW}%~${T_RESET}$ "
}
ps1multi() {
  ps1single
  PS1=$(echo $PS1 | sed 's/\$/\n$/')
}
ps1single


# Keybinds
bindkey -e
bindkey "^U" backward-kill-line
bindkey "^V" edit-command-line
bindkey "^[" vi-cmd-mode

#bindkey -v
#bindkey -rpM viins "^["
## viins
#bindkey -M viins "^P" up-line-or-history
#bindkey -M viins "^N" down-line-or-history
#bindkey -M viins "^R" history-incremental-search-backward
#bindkey -M viins "^S" history-incremental-search-forward
#bindkey -M viins "^B" backward-char
#bindkey -M viins "^F" forward-char
#bindkey -M viins "^A" beginning-of-line
#bindkey -M viins "^E" end-of-line
#bindkey -M viins "^[b" backward-word
#bindkey -M viins "^[f" forward-word
#bindkey -M viins "^?" backward-delete-char
#bindkey -M viins "^W" backward-kill-word
#bindkey -M viins "^K" kill-line
#bindkey -M viins "^U" backward-kill-line
#bindkey -M viins "^[." insert-last-word
#bindkey -M viins "^[v" edit-command-line
## vicmd
#bindkey -M vicmd "^[v" edit-command-line

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
# eval "$(grunt --completion=zsh)"

# Misc
setopt extendedglob
setopt correct
setopt no_multios
setopt interactive_comments
setopt pushd_silent
setopt pushd_minus
