_.dotfiles_
===========

A set of files describing the behaviour of the apps that I use and also a tool to configure my linux environment automatically (specifically my Xubuntu 16.04).

__This work is inspired by the [webcoyote](https://github.com/webcoyote/linux-setup) one.__

Installation
===

If you don't have curl yet:

`~$ sudo apt-get install curl -qq -y`

If you already have curl:

`~$ curl -# -o linux-setup.sh https://raw.githubusercontent.com/rafaelcn/Linux-setup/master/linux-setup.sh`

__That's it, *simple* as that. Now go and setup your linux environment ;)__

Applications
===

__The list of the applications that will be installed when the script is run__

 - [x] HG (Mercurial)
 - [x] Git
 - [x] Subversion
 - [x] Synaptic Package Manager
 - [x] Emacs
 - [X] Deluge

__Note: it also generate github ssh keys. Awesome, isn't? Just use:__

`./linux-setup.sh -gen-ssh`