#!/bin/bash
#
# Rafael Campos Nunes <rafaelnunes@engineer.com>
#

S="sudo"
DIST=`cat /etc/issue | cut -d ' ' -f 1`

config_emacs() {
    if [ ! -e /usr/bin/wget ]; then
        $PM $INSTALL wget
    fi

    wget http://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz --progress=bar
    tar xf emacs-26.1.tar.xz
    cd emacs-26.1
    configure ./

    if [ $? -eq 0 ]; then
        make && make install

        cd ~/
        git clone https://github.com/bbatsov/prelude
        cp Github/dotfiles/.emacs.d ./ -r
    fi

    # TODO: Fix the missing dependencies
    echo "Download all the dependencies that Emacs need to be compiled."
}


main() {
    # Package manager and some variables are set to work with the Debian
    # derivatives and will change if the system is not a Debian bases system.
    PM="apt"
    INSTALL="install -y"

    if [ -e /usr/bin/pacman ]; then
        PM='pacman'
        INSTALL='-S --noconfirm'
    fi

    if [ ! -e /usr/bin/git ]; then
        echo "You'll need git, let me install it for you.\n"
        $S $PM install git
    fi

    mkdir -p Github && cd Github
    git clone https://github.com/rafaelcn/dotfiles

    cp .gitconfig ~/

    printf "Your distribution is $DIST and it uses $PM as its package manager. \
(PRESS ENTER TO CONTINUE)\n"

    read

    JEKYLL=ruby
    SDL2=libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-mixer-dev
    DEPS=libtiff-dev libpng-dev libjpeg-dev libgtk-3-dev libpng-dev libgif-dev
    GENERAL=software-properties-common python-software-properties
    DEV_TOOLS=curl cmake glm zsh vim g++ gdb valgrind ocaml clang-6.0 llvm-6.0 \
             llvm-6.0-dev llvm-6.0-tools openssh-client openssh-server arp-scan\
             python3-pip python-pip wget cifs-utils python3-dev erlang rust \
    SYS_TOOLS=rmlint dstat atop

    PACKAGES=$JEKYLL $SDL2 $DEV_TOOLS $SYS_TOOLS $DEPS

    PYTHON_PACKAGES=wakatime

    # Non portable between distributions I think because of package naming
    $S $PM $INSTALL $PACKAGES
    # Install wakatime package
    $S pip install $PYTHON_PACKAGES

    read -p "Install and configure emacs? (y/n)" EMACS

    if [ $EMACS -eq "y" ]; then
        config_emacs
    fi

    echo "The system is ready and at your service..."
}

main
