#!/bin/bash
#: Title	: linux-setup.sh
#: Date		: 01/20/2017 (MM/DD/YYYY).
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
    echo "That's because only your home directory will be used."
    exit
fi

# Get the linux architecture
case $(uname -p) in
    "x86_64") LINUX_ARCH=x86_64 ;;
    "x86") LINUX_ARCH=x86 ;;
esac


help()
{
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

generate_ssh()
{
	clear
	SSH_KEYGEN=`which ssh-keygen`
	EDITOR=`which mousepad | which kate | which kwrite | which leafpad`

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
	    if [ -z $EDITOR ]
	    then
		cat ~/.ssh/id_rsa.pub
	    else
		$EDITOR ~/.ssh/id_rsa.pub
	    fi
	    echo "When you're ready, press enter and we gonna begin testing the SSH."
	    read enter
	    echo -ne "Testing SSH connection with github servers"
	    sleep 0.3
	    echo -ne .
	    sleep 0.3
	    echo -ne .
	    sleep 0.3 
	    echo .
	    ssh -T git@github.com
	fi
}

case $1 in
    "--help") help exit;;
    "--gen-ssh") generate_ssh exit;;
    "--gen-gpg") generate_gpg exit;;
    "") help exit;;
esac
