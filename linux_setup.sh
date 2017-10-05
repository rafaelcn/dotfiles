#!/bin/bash
#: Title	: linux-setup.sh
#: Date		: 01/20/2017 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes at engineer dot com>
#: License	: MIT
#: Version	: 0.1
#: Options	: --help, --gen-ssh.

if [ $(id -u) -eq 0 ]
then
    echo "This  script must not be ran with root privileges."
    echo "That's because only your home directory will be used."
    exit
fi


download()
{
    URL=$1
    FILE=$2

    echo "Downloading $URL in $FILE."
    curl -# -o $1 $2
}

setup_tools()
{
	GIT=`which git`
	VIM=`which vim`
	GCC=`which gcc`

	if [ -r $GIT ] then
		sudo apt install git -y
	fi

	if [ -r $VIM ] then
		sudo apt install vim -y
	fi

	if [ -r $GCC ] then
		sudo apt install gcc -y
	fi
}

config()
{
	git config --global user.mail "rafaelnunes@engineer.com"
	git config --global user.name "Rafael Campos Nunes"
		
	echo "Would you like to generate ssh keys right now? (y/n)"
	read $ANSWER

	# FIXME: Thi isn't a correct comparisson.
	if [[ $ANSWER -eq 'y' ]] then
		generate_ssh
	fi

	mkdir -p ~/Github

	# Verifies that ~/Github exist.
	echo "Cloning projects for further configuration."
	# Clone some projects of mine to be used later.
	$GIT clone https://githu.com/rafaelcn/dotfiles.git ~/Github
}

generate_ssh()
{
	clear
	SSH_KEYGEN=`which ssh-keygen`
	EDITOR=`which mousepad | which kate | which kwrite | which leafpad | which scratch-text-editor`

	if [ -z $SSH_KEYGEN ]
	then
			echo "Installing ssh-keygen"
			sudo apt install ssh-keygen -y
	fi

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
}

case $1 in
	"") setup_tools; config; generate_ssh exit;;
    "--help") help exit;;
    "--gen-ssh") generate_ssh exit;;
    "--gen-gpg") generate_gpg exit;;
    "") help exit;;
esac
