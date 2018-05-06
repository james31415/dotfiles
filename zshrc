if [ -z "$STY" ] && [ -n "$SSH_TTY" ]; then
    screen -xRR remote && exit 0
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git pip screen vi-mode)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
bindkey -v

alias li="ls -i"
alias mt="mount-tablet"
alias ncmpc="ncmpc -c"

alias less="w3m"

export LC_ALL=en_US.UTF-8
