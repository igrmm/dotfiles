PROMPT='%F{8}[%f%F{15}%n%f %F{blue}%B%1~%b%F{8}]%f '
#PROMPT='%F{3}[%f%F{cyan}%n%f %F{blue}%B%1~%b%F{3}]%f '
#RPROMPT='%F{magenta}[ %f%T %F{magenta}]'

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _complete _match
zstyle ':completion:*' glob 0
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+m:{a-z}={A-Z} r:|[._-]=** r:|=**' '' '' '+m:{a-z}={A-Z} r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' substitute 0
zstyle ':completion:*' menu select
zmodload zsh/complist
zstyle :compinstall filename "$HOME/.zshrc"

# Restore emacs bindkeys if EDITOR=vim
bindkey -e

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey "\e[3~" delete-char

HISTSIZE=25000
HISTFILE=~/.zsh_history
SAVEHIST=100000

export REPORTTIME=10

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias vim='nvim'
alias vifm='~/scripts/bin/vifmub'
alias h='cd $HOME'

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
