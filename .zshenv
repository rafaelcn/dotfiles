# Environment variables
# Rafael Campos Nunes <rafaelnunes@engineer.com>

export PATH=$PATH:~/Github/brain/bin
export PATH=$PATH:~/Programming/Go/bin
export PATH=$PATH:~/.local/bin

export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/Programming/Go

# Using vim to edit system/commit files
export VISUAL=vim
export EDITOR="$VISUAL"

# Resolve issues with my gpg-agent
GPG_TTY=$(tty)
export GPG_TTY
