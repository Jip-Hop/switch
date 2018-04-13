#!/usr/bin/env bash

#  mac_ml.sh
#
#  Script to almost automatically install
#  and configure a Magic Lantern development
#  environment on a Macintosh.
#
#  Reference:
#  http://magiclantern.fm/forum/index.php?topic=16012.0
#
#  Daniel Fort (dfort) - 2015-10-15
#  Modified 2016-03-17 - took out ugly gcc hack
#  Modified 2017-06-27 - added mingw-w64 for cross compiling Windows binaries
#  Modified 2017-06-28 - check if magic-lantern already exists
#  Modified 2017-07-12 - write a Makefile.user file
#  Modified 2017-09-23 - made mingw-w64 (Windows cross compiler) optional
#  Modified 2017-09-24 - added interactive options for mingw-w64 and QEMU
#  Modified 2017-09-26 - QEMU install.sh now installs dependencies so no need to do it here.
#  Modified 2017-09-29 - Improved handling of QEMU install.
#  Modified 2017-11-16 - Homebrew changed gcc-5 install to gcc@5, added gcc-arm-none-eabi-5_4-2016q3
#  Modified 2017-11-17 - added more checks in cases where a development system was already in place
#  Modified 2018-04-04 - Danne - added pip2 and pip3 docutils downloads to make sure the python grep issues won't appear
#  Modified 2018-04-05 - Danne - put in a safety check if brew is already installed so it skips the ruby command all together
#
#  2018-04-07          - Danne - script now lives in the Magic Lantern development compiler tool (Mac OS) bitbucket repository
#                              - download the latest version from:
#                              - https://bitbucket.org/Dannephoto/compiler
#
#  Thanks to Danne and kichetof and of course a1ex for their input

if ! test -d /usr/local; then
  clear
  echo $(tput bold)"/usr/local directory not found."
  echo "Follow the steps at the beginning of"
  echo "tutorial to create /usr/local and"
  echo "then re-run this script."
  sleep 5
  echo ""
  echo "All info:" https://www.magiclantern.fm/forum/index.php?topic=16012.0
  sleep 2
  open https://www.magiclantern.fm/forum/index.php?topic=16012.0
  sleep 5
  exit 1
fi
clear
echo "/usr/local found -- "
echo "continuing with installation."

cd ~
[ ! -d "/Library/Developer/CommandLineTools" ] && xcode-select --install
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
[ ! -f "`which wget`" ] && brew install wget
brew install gcc@5 python wget mercurial
pip install docutils
pip2 install docutils
pip3 install docutils

if ! test -d ~/gcc-arm-none-eabi-4_8-2013q4; then
    cd ~ && \
    wget -c https://launchpad.net/gcc-arm-embedded/4.8/4.8-2013-q4-major/+download/gcc-arm-none-eabi-4_8-2013q4-20131218-mac.tar.bz2 && \
    tar -jxf gcc-arm-none-eabi-4_8-2013q4-20131218-mac.tar.bz2 && \
    rm gcc-arm-none-eabi-4_8-2013q4-20131218-mac.tar.bz2
fi

if ! test -d ~/gcc-arm-none-eabi-5_4-2016q3; then
    cd ~ && \
    wget -c https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2 && \
    tar -jxf gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2 && \
    rm gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2
fi

if ! test -d ~/magic-lantern; then
    cd ~
    hg clone https://bitbucket.org/hudson/magic-lantern
    cd magic-lantern
    hg update unified
    cat <<'EOT' > Makefile.user
#
# Host compiler settings
#
HOST_CC=gcc-5
HOST_LD=gcc-5
HOST_AR=$(shell which ar)
EOT
    cd ~
fi

# OPTION 1 - Windows cross compiler
#
if ! [ -d /usr/local/Cellar/mingw-w64 ]
then
clear
echo
read -p $(tput bold)"Would you like to install the Windows cross compiler mingw-w64?
$(tput setaf 1)[y/n]
"$(tput sgr0)
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "installing mingw-w64"
    brew install mingw-w64
fi
fi

#
# OPTION 2 - QEMU
#
clear
echo
read -p $(tput bold)"Would you like to install QEMU?
$(tput setaf 1)[y/n]
"$(tput sgr0)
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "installing QEMU"
    cd ~
    echo 'export PATH=~/gcc-arm-none-eabi-5_4-2016q3/bin:$PATH' >> .profile
    source .profile
    cd magic-lantern
    hg update qemu -C
    cd contrib/qemu/
    ./install.sh
fi
