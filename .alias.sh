#!/usr/bin/bash
#
# Rafael Campos Nunes <rafaelnunes@engineer.com>

if [ -e /usr/bin/pacman ]; then
    alias pacman-install='sudo pacman -S'
    alias pacman-update='sudo pacman -Sy'
    alias pacman-upgrade='sudo pacman -Syuu'
    alias pacman-remove='sudo pacman -Rsu'
    alias pacman-search='sudo pacman -Ss'
fi

alias et='emacsclient -nw'
alias ew='emacsclient -c'

alias xcopy="xclip -sel clipboard"
alias xpaste="xclip -o -sel clipboard"
