#!/bin/bash
#: Title	: Linux Setup
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes737@hotmail.com>
#: License	: MIT
#: Version	: 0.1
#: Options	: -help, -jdk8 (not available yet).

#############################################################
# 
# 
#
#############################################################

###################### Global variables ############################

# The architecture of the linux being executed (none by default).
LINUX_ARCH=("none")

# Java directory
JVD=("/usr/lib/jvm")	

####################################################################

if [ $(id -u) -ne 0 ] 
then
	echo "This  script must be ran with root privileges! If you have any doubts"
	echo "about   the   proccess  you  can  check  source  code  of the  script" 
	echo "for security reasons."		
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

install_default() 
{
	echo ""
	echo "System architecture: $LINUX_ARCH."
	echo ""
	sleep 3

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

	install_gcc	
	
	echo "--- INSTALLING Ruby"
	apt-get install ruby -y -qq
	which ruby

	# By default, the jdk that will be installed is JDK7, if you wanna 
	# specify other JDK installation use -jdk8 argument.
	#install_java JDK7
}


# Installs the latest stable gcc available (GCC 4.9)
install_gcc()
{
	echo "--- INSTALLING GCC 4.9 ---"
	download_file g++-4.9 http://gcc.parentingamerica.com/releases/gcc-4.9.2/gcc-4.9.2.tar.gz
}

# Configuring Java environment. Java has to be one of the last things to be 
# configured because it will install the java plugin for the browser as well.
install_java()
{
	clear
	echo "--- Configuring java environment | Installing ($1) ---"

	var=$1
	
	#testing /usr/lib/jvm for Java installation
	if [ -d "/usr/lib/jvm" ] 
	then # if JVM directory exists
	    cd $JVD &&
		case $LINUX_ARCH in
			"x86_64")
				case $var in 
					"JDK7") 
						echo "Downloading $var"
						download_file JDK7.tar.gz http://download.oracle.com/otn-pub/java/jdk/7u71-b14/jdk-7u71-linux-x64.tar.gz ;;
					"JDK8") 
						echo "Downloading $var"
						download_file JDK8.tar.gz http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz 
				esac ;;
			"x86")
				case $var in 
					"JDK7") 
						echo "Downloading $var" ;;
						#download_file JDK7.tar.gz ;;
					"JDK8") 
						echo "Downloading $var"
						#download_file JDK8.tar.gz ;;
				esac
		esac
	else # otherwise...
	    mkdir $JVD && cd $JVD
		install_java $var
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
	"") install_default ;; 
	# "-jdk8") install_java JDK8;;
esac

#TODO: test everything that's installed!

echo "System configuration complete."
