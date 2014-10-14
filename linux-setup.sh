#!/bin/bash
#: Title	: Linux Setup
#: Date		: 10/13/2014 (MM/DD/YYYY).
#: Author	: Rafael C. Nunes <rafaelnunes737@hotmail.com>
#: License	: MIT
#: Version	: 0.1
#: Options	: -help

JVM=("/usr/lib/jvm")

case $1 in
	"-help") 
	clear
	echo "This script will make your life easier by installing almost everything that you need. if you have doubts about what will be installed checkout https://github.com/rafaelcn/Linux-setup to more information."
	echo ""
	exit;;
esac


if [ $(id -u) -eq 0 ] 
then
	echo "This script must not be ran with root privileges!"		
	exit
fi

# Installing dev and other user tools.
echo "--- installing git ---"
sudo apt-get install git -y -qq
echo "--- installing mercurial ---"
sudo apt-get install mercurial -y -qq
echo "--- installing synaptic package manager ---"
sudo apt-get install synaptic -y -qq

# TODO: Finish the java function.
# Configuring Java environment. Java has to be one of the last things to be 
# configured because it will install the java plugin for the browser as well.
install_java()
{
	clear
	echo "--- configuring java environment ---"

	#testing /usr/lib/jvm for Java installation
	if [ -d "/usr/lib/jvm" ] 
	then
		
	else
		
		cd `$JVM` && ls
		#mdkir 
	fi
}


#install_java

echo "System configuration complete."
