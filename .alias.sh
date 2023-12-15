#!/bin/bash
#
# Rafael Campos Nunes <rcamposnunes@outlook.com>

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

# Export gpg keys
#alias export_keys=gpg --output - --export-secret-keys 0803154E > pubkey.gpg |
#    gpg --armor --output keys.asc --symmetric --chipher-algo AES56

alias decrypt=gpg --decrypt
alias sencrypt=gpg --symmetric --encrypt

# A known bug https://askubuntu.com/questions/779892/16-04-cant-use-bluetooth-a2dp-headphones-pairs-but-does-not-connect-logs-insi
alias headphones='sudo rmmod btusb ; sudo modprobe btusb'
