if [ -z "$STY" ] && [ -n "$SSH_TTY" ]; then
    screen -xRR remote && exit 0
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="jreese"
plugins=(catimg screen vi-mode)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
bindkey -v

alias ddg="duckduckgo"
alias wiki="wikipedia"

alias li="ls -i"
alias mt="mount-tablet"
alias ncmpc="ncmpc -c"

# Docker clean  aliases from https://www.calazan.com/docker-cleanup-commands/

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

export LC_ALL=en_US.UTF-8

fortune -a
