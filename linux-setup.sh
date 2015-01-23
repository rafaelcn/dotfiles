#!/bin/bash
#: Title	: Linux Setup
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes737 at hotmail dot com>
#: License	: MIT
#: Version	: 0.1
#: Options	: -help, -gen-ssh.

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

#
download_file()
{
    NAME=$1
    FILE=$2
	
    echo "Downloading $NAME in $FILE."	
    
    curl -# -o $1 $2
}

# Intalls the GNU C++ 4.9 compiler
install_gnu_cplusplus()
{
    # This was only tested on Xubuntu 14.04
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get update -qq
    sudo apt-get install g++-4.9 -y -qq
}

install_valgrind()
{
    clear
    echo "Downloading Valgrind 3.10.1"
    download_file Valgrind.tar.bz2 valgrind.org/downloads/valgrind-3.10.1.tar.bz2
    
    tar -fjx Valgrind.tar.bz2
    
    cd Valgrind
    ./configure
    sudo make && make install -j 3
}


install_compton() 
{
    echo "Adding comptom PPA..."
    apt-add-repository ppa:richardgv/compton -y
    echo "Updating repository list."
    apt-get update -qq
    clear
    echo "--- INSTALLING Compton ---"
    apt-get install compton -y -qq
    echo "Downloading compton.conf file."
    download_file compton.conf https://raw.githubusercontent.com/rafaelcn/Linux-setup/master/compton.conf
    echo "Creating compton configuration."
    if [ -d "$HOME/.config/" ] 
	then
	mkdir $HOME/.config/
    fi
	
    mv compton.conf $HOME/.config/
    
    # Adding as a startup application.
    echo "[Desktop Entry]
Encoding=UTF-8 
Version=0.9.4
Type=Application
Name=Compton
Comment=Compositor for X11
Exec=compton 
OnlyShowIn=XFCE;
StartupNotify=false 
Terminal=false
Hidden=false" > $HOME/.config/autostart/Compton.desktop

    echo "Compton installation complete!"
    
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
	mkdir $HOME/Programming/Scala
    fi

    if [ -d "$HOME/Web-Programming" ] 
    then
	echo "\"Web-Programming\" folder already exists, skipping..."
	sleep 1
    else
	mkdir $HOME/Web-Programming
    fi

}

install_default() 
{
    echo ""
    echo "System architecture: $LINUX_ARCH."
    echo ""
    echo "This installation may take a while, seat back and enjoy."
    sleep 2

    # My linux $HOME path has some additional folders
    create_folders
    
    install_gnu_cplusplus
    install valgrind
    
    sudo apt-get install xubuntu-restricted-extras -y -qq
    sudo apt-get install git -y -qq
    sudo apt-get install mercurial -y -qq
    sudo apt-get install subversion -y -qq
    sudo apt-get install synaptic -y -qq
    sudo apt-get install emacs -y -qq
    sudo apt-get install -y -qq libgtk-3-dev
    sudo apt-get install ruby -y -qq

    pip install virtualenv
    
    install_compton
    # Starting Compton (Note that you have to disable the default compositor to compton work)
    compton
}
      
generate_ssh()
{
    clear
    echo "Generating ssh keys for github..."
    sleep 1
    if [ -d "~/.ssh" ] # FIXME: This doesn't look for hidden folders.
    then
	echo "You probably already have ssh keys. Look into the ~/.ssh directory."
    else
	echo "Your email please: "
	read email
	ssh-keygen -t rsa -C "$email"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
	echo "This is your SSH key. Select all and copy to your clipboard. Then, go to your github"
	echo "and add the ssh key."
	mousepad ~/.ssh/id_rsa.pub
	echo "When you're ready, press enter and we gonna begin testing the SSH."
	read enter
	ssh -T git@github.com
    fi
}

case $1 in
    "-help")
	echo "This script will  make  your  life  easier  by  installing  almost" 
	echo "everything that you  need  in  your  linux machine.  If  you  have" 
	echo "doubts about what will be installed checkout:"
	echo "--- https://github.com/rafaelcn/Linux-setup ---" 
	echo "to more information."
	exit;;
    "-gen-ssh")
	generate_ssh
	exit;;
    "") install_default 
	exit;; 
esac

echo "System configuration complete."
