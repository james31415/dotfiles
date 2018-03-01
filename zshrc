if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]; then
    export STARTED_SCREEN=1
    screen -RR && exit 0
    echo "Screen failed! continuing with normal startup"
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="clean"
plugins=(git pip screen vi-mode)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
bindkey -v

alias li="ls -i"

export LC_ALL=en_US.UTF-8

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
