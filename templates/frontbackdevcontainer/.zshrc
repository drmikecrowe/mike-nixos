# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/user/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
source <(starship init zsh --print-full-init)

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cnc='grep '\''^[^#;]'\'''
alias cpuu='ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '\''/^ 0.0 /d'\'''
alias dud='du -h --max-depth=1 --one-file-system'
alias dudg='du -h --max-depth=1 --one-file-system 2>&1 | egrep '\''^[0-9.]*G'\'''
alias l='ls -l --color'
alias l.='ls -d .[a-zA-Z]* --color=tty'
alias la='ls -lAF'
alias ll='ls -l --color -a'
alias lsd='ls -lF | grep --color=never '\''^d'\'''
alias md='mkdir -p'
alias psa='ps aux | cut -b -180'
alias psag='ps aux | cut -b -180 | grep'
alias psi='ps h -eo pmem,comm | sort -nr | head'
alias rd='rmdir'

