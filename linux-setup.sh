#!/bin/bash
#: Title	: Linux Setup
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes737@hotmail.com>
#: License	: MIT
#: Version	: 0.1
#: Options	: -help, -install_jdk7, -install_jdk8.

###################### Global variables #####################
JVM=("/usr/lib/jvm")

#############################################################


if [ $(id -u) -ne 0 ] 
then
	echo "This script must be ran with root privileges! If you have any doubts about the proccess you can check the script for security reasons."		
	exit
fi

# Installing dev and other user tools.
echo "--- INSTALLING Git ---"
sudo apt-get install git -y -qq
echo "--- INSTALLING Mercurial (HG) ---"
sudo apt-get install mercurial -y -qq
echo "--- INSTALLING Synaptic package manager ---"
sudo apt-get install synaptic -y -qq



# TODO: Finish the java function.
# Configuring Java environment. Java has to be one of the last things to be 
# configured because it will install the java plugin for the browser as well.
install_java()
{
	clear
	echo "--- Configuring java environment | Installing ($1) ---"

	#testing /usr/lib/jvm for Java installation
	if [ -d "/usr/lib/jvm" ] 
	then
		
	else
		
		cd `$JVM` && ls
		#mdkir 
	fi
}

echo "System configuration complete."

case $1 in
	"-help") 
	clear
	echo "This script will make your life easier by installing almost everything that you need. if you have doubts about what will be installed checkout https://github.com/rafaelcn/Linux-setup to more information."
	echo ""
	exit;;
	"-jdk7") install_java jdk7;;
	"-jdk8") install_java jdk8;;
esac
