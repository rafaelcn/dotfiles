# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ranu/.oh-my-zsh

ZSH_THEME="mortalscumbag"

plugins=(git)

source $ZSH/oh-my-zsh.sh

############################ user configuration

if [ "$SSH_AUTH_SOCK" = "" -a -x /usr/bin/ssh-agent ]; then
                eval `/usr/bin/ssh-agent`
fi

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

source $HOME/.zsh_env
source $HOME/.zsh_aliases
