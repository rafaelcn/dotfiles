#!/usr/bin/bash
#
# Rafael Campos Nunes <rafaelnunes@engineer.com>

if [ ! -e /usr/bin/sudo ]; then
    echo "You must have the force to execute this script."
    echo "You should have sudo, or modify this script to work as you please."
    exit 1
fi

S="sudo"
DIST=`cat /etc/issue | cut -d ' ' -f 1`

config_emacs() {

    if [ ! -e /usr/bin/wget ]; then
        $PM $INSTALL wget
    fi

    wget http://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz --show-progress --progress=bar
    tar xf emacs-26.1.tar.xz
    cd emacs-26.1
    configure ./
    make && make install

    cd ~/
    git clone https://github.com/bbatsov/prelude
    cp Github/dotfiles/.emacs.d ./ -r
}

# Package manager and some variables are set to work with the Debian derivatives
# and will change if the system is not a Debian bases system.
PM="apt"
INSTALL="install -y"

if [ -e /usr/bin/pacman ]; then
    PM='pacman'
    INSTALL='-S --noconfirm'
fi

if [ ! -e /usr/bin/git ]; then
    printf "You need git to run this script. Sorry kiddo.\n"
    exit 1
fi


printf "Your distribution is $DIST and it uses $PM as its package manager. (PRESS ENTER TO CONTINUE)\n"
read

# Non portable between distributions I think
$S $PM $INSTALL vim zsh sdl2-dev glm ruby

# TODO: Configure and install Jekyll and other stuff I don't have in my head right now

mkdir -p Github && cd Github
git clone https://github.com/rafaelcn/dotfiles

read -p "Install and configure emacs? (y/n)" EMACS

if [ $EMACS -eq "y"  ]; then
    config_emacs
fi

echo "The system is ready and at your service..."
