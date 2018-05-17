# Environment variables

export PATH=$PATH:~/Github/brain/bin
export PATH=$PATH:~/Programming/Go/bin

export GOPATH=~/Programming/Go


# Using vim to edit system/commit files
export VISUAL=vim
export EDITOR="$VISUAL"

# Resolve issues with my gpg-agent
GPG_TTY=$(tty)
export GPG_TTY
