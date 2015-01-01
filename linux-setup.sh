#!/bin/bash
#: Title	: Linux Setup
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes737@hotmail.com>
#: License	: MIT
#: Version	: 0.1
#: Options	: -help.

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

# Installs the latest stable gcc available (GCC 4.9)
install_gcc()
{
    # This was only tested on Xubuntu 14.04
    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y -qq
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
    apt-add-repository ppa:richardgv/compton -y -qq
    echo "Updating repository list."
    apt-get update -qq
    clear
    echo "--- INSTALLING Compton ---"
    apt-get install compton -y -qq
    echo "Downloading compton.conf file."
    download_file compton.conf https://raw.githubusercontent.com/rafaelcn/Linux-setup/master/compton.conf
    echo "Creating compton configuration."
    if [ -d "$HOME/.config/" ] then
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
    # My $HOME folder structure:
    # 
    # $HOME
    #   |
    #   --- Github
    #   |
    #   --- HG  
    #   |
    #   --- SVN
    #   |
    #   --- Databases
    #   |  
    #   --- py-env
    #   |
    #   --- Math
    #   |
    #   --- IDEs 
    #   |
    #   --- Programming
    # 		 |
    #		 --- C/C++
    #		 |
    #		 --- Lua
    #	_________|
    #   |
    #   --- Web-Programming

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
    sleep 2

    # My linux $HOME path has some additional folders
    echo "Creating necessary folders..."
    create_folders

    # Installing compton X11 composition
    install_compton

    # Installing dev and other user tools.
    echo "--- INSTALLING Git ---"
    sudo apt-get install git -y -qq
    echo "Git located on: " $(which git)
    echo "--- INSTALLING Mercurial (HG) ---"
    sudo apt-get install mercurial -y -qq
    echo "HG located on: " $(which hg)
    echo "--- INSTALLING Synaptic package manager ---"
    sudo apt-get install synaptic -y -qq
    echo "Synaptic located on: " $(which synaptic)
    echo "--- INSTALLING Ruby"
    apt-get install ruby -y -qq
    echo "Ruby located on: " $(which ruby)

    echo "--- INSTALLING virtualenv ---"
    pip install virtualenv

    echo "--- INSTALLING GTK+ Development library"
    sudo apt-get install -y -qq libgtk-3-dev

    echo "--- INSTALLING GCC 4.9 ---"
    install_gcc

    echo "--- INSTALLING Valgrind ---"
    install valgrind

    
    # Starting Compton (Note that you have to disable the default compositor to compton work)
    compton
}

      

case $1 in
    "-help")
	echo "This script will  make  your  life  easier  by  installing  almost" 
	echo "everything that you  need  in  your  linux machine.  If  you  have" 
	echo "doubts about what will be installed checkout:"
	echo "--- https://github.com/rafaelcn/Linux-setup ---" 
	echo "to more information."
	exit;;
    "") install_default ;; 
esac

echo "System configuration complete."
