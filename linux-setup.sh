#!/bin/bash
#: Title	: linux-setup.sh
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes at engineer dot com>
#: License	: MIT
#: Version	: 0.1
#: Options	: --help, --gen-ssh.

###################### Global variables ############################

# The architecture of the linux being executed (none by default).
LINUX_ARCH=("none")

####################################################################

# This file has to be divided, it has to be run as a normal user, $HOME will result into /root/~

if [ $(id -u) -eq 0 ]
then
    echo "This  script must not be ran with root privileges."
    echo "That's because your home directory will be used."
    exit
fi

# Get the linux architecture
case $(uname -p) in
    "x86_64") LINUX_ARCH=x86_64 ;;
    "x86") LINUX_ARCH=x86 ;;
esac


help()
{
    echo.
    echo.
    echo "Install the basic stuff that a developer (I) need."
	echo "doubts about what will be installed checkout:"
	echo "------------ https://github.com/rafaelcn/dotfiles ------------"
    echo ""
    echo "Usage: ./linux-setup [options]"
    echo "Options:"
    echo "-h || --h || -help || --help    Show the program help."
    echo "-gen-ssh                        Generates the Github ssh keys for you."
}


download_file()
{
    NAME=$1
    FILE=$2

    echo "Downloading $NAME in $FILE."
    curl -# -o $1 $2
}


install_valgrind()
{
    clear
    echo "Downloading Valgrind 3.10.1"
    download_file Valgrind.tar.bz2 valgrind.org/downloads/valgrind-3.10.1.tar.bz2

    tar -fjx Valgrind.tar.bz2

    cd Valgrind
    ./configure
    sudo make && make install -j 2
}

create_folders()
{
    if [ -d "$HOME/Github" ]
    then
    	echo "\"Github\" folder already exists, skipping..."
		sleep 1
    else
		mkdir $HOME/Github
    fi

    if [ -d "$HOME/HG" ]
    then
		echo "\"Mercurial (HG)\" folder already exists, skipping..."
		sleep 1
    else
		mkdir $HOME/HG
    fi

    if [ -d "$HOME/SVN" ]
    then
		echo "\"SVN\" folder already exists, skipping..."
		sleep 1
    else
		mkdir $HOME/SVN
    fi

    if [ -d "$HOME/Databases" ]
    then
		echo "\"Databases\" folder already exists, skipping..."
		sleep 1
    else
		mkdir $HOME/Github
    fi

    if [ -d "$HOME/IDEs" ]
    then
		echo "\"IDEs\" folder already exists, skipping..."
		sleep 1
    else
		mkdir $HOME/IDEs
    fi

    if [ -d "$HOME/Programming" ]
    then
		echo "\"Programming\" folder already exists, skipping..."
	sleep 1
    else
		mkdir $HOME/Programming
		mkdir $HOME/Programming/C-C++
		mkdir $HOME/Programming/Lua
    fi
}

install_default()
{
    echo ""
    echo "System architecture: $LINUX_ARCH."
    echo ""
    echo "This installation may take a while, sit back and enjoy."
    sleep 2

    # My linux $HOME path has some additional folders
    create_folders

    install_valgrind

    sudo apt-get install xubuntu-restricted-extras -y -qq
    sudo apt-get install git -y -qq
    sudo apt-get install mercurial -y -qq
    sudo apt-get install subversion -y -qq
    sudo apt-get install synaptic -y -qq
    sudo apt-get install emacs -y -qq
    sudo apt-get install deluge -y -qq

    pip3 install virtualenv

    install_compton
}


generate_ssh()
{
	clear
	SSH_KEYGEN=`which ssh-keygen`
	EDITOR=`which mousepad`
	
	if [ -z $SSH_KEYGEN ]
	then
		echo "The ssh-keygen program could not be found. It won't be possible to "
		echo "generate key."
		return 127
	else
    		echo "Generating ssh keys for github..."
	    	sleep 1
		echo "Your email please: "
		read email
		$SSH_KEYGEN -t rsa -C "$email"
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_rsa
		echo "This is your SSH key. Select all and copy to your clipboard. Then, "
		echo "go to your github and add the ssh key."
		if [ -z $EDITOR ] then
			cat ~/.ssh/id_rsa.pub
		else
			mousepad ~/.ssh/id_rsa.pub
		fi
		echo "When you're ready, press enter and we gonna begin testing the SSH."
		read enter
		ssh -T git@github.com
	fi
}

case $1 in
    "--help") help exit;;
    "--gen-ssh") generate_ssh exit;;
    "") install_default exit;;
esac

echo "System configuration complete."
