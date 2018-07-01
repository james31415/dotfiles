if [ -z "$STY" ] && [ -n "$SSH_TTY" ]; then
    screen -xRR remote && exit 0
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"
plugins=(catimg screen vi-mode)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
bindkey -v

alias ddg="duckduckgo"
alias wiki="wikipedia"

alias li="ls -i"
alias mt="mount-tablet"
alias ncmpc="ncmpc -c"

export LC_ALL=en_US.UTF-8

fortune -a
