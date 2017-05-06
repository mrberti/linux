#!/bin/bash
# This is just a collection of software I usually install after a clean system startup
# Usage should be like: 
# sudo `install.sh | grep wget`

#versioning
apt-get install mercurial git subversion

#utils
apt-get install bc vim-gtk imagemagick screen wget p7zip-full

#encryption
apt-get install gnupg2 gpa

#math
apt-get install bc octave

#webserver
apt-get install apache2 php5 libapache2-mod-php5 ftp

#windows integration
apt-get install samba samba-common-bin

#remote
apt-get install xrdp

git clone https://github.com/tpope/vim-pathogen.git ~/.vim/vim-pathogen ; mv ~/.vim/vim-pathogen/autoload ~/.vim/autoload ;  rm -rf ~/.vim/vim-pathogen
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
