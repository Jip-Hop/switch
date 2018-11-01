#GNU public license
#This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
 # as published by the Free Software Foundation; either version 2
 # of the License, or (at your option) any later version.
 # 
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 # 
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the
 # Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.


#!/usr/bin/env bash

#start in user directory
cd ~

if ! [ -d /Library/Developer/CommandLineTools ]
then
xcode-select --install
fi

#check for dependencies
if ! [ -f /usr/local/bin/brew ]
then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#check for qt versions
if ! [ -d $(ls /usr/local/Cellar/qt/5.1* | head -1 | tr -d ':') ]
then
brew install qt5
brew upgrade qt5
fi

#update scripts if old
#if update file is missing
if ! [ -f "$(cat /tmp/m_a_compath2)"/24update ]; then
echo $(stat -f "%Sm" -t "%Y%m%d%H%M") > "$(cat /tmp/m_a_compath2)"/24update
fi

#run it once
if ! [ "$one" = one ]; then
one=$(echo one)

#only check for update every 24 hours
if (($(echo $(stat -f "%Sm" -t "%Y%m%d%H%M") - $(cat "$(cat /tmp/m_a_compath2)"/24update) | bc -l) > 10000))
then
echo $(stat -f "%Sm" -t "%Y%m%d%H%M") > "$(cat /tmp/m_a_compath2)"/24update
#!/bin/bash
clear
echo "checking for updates..."

Local=$(wc -c < "$(cat /tmp/m_a_compath2)"/main.command)
RLocal=$(curl -sI https://bitbucket.org/Dannephoto/mlv_app_compiler/raw/default/Mlv_App_compiler.app/Contents/main.command | grep -i 'content-length' | tr '\r' '\n'  | awk '{print $2}')

if [ $Local != $RLocal ]; then
printf '\e[8;15;100t'
printf '\e[3;410;0t'
clear
read -p $(tput bold)"Your scripts are old or have recently changed, would you like to update from source?$(tput bold)$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#grab scripts for MLV_App_compiler
   curl -L https://bitbucket.org/Dannephoto/mlv_app_compiler/raw/default/Mlv_App_compiler.app/Contents/main.command -o "$(cat /tmp/m_a_compath2)"/main.command
esac
else
clear
echo "All files are already updated"
sleep 2
fi
fi
fi 

if ! [ -d ~/MLV-App-master ]
then
git clone https://github.com/ilia3101/MLV-App.git MLV-App-master
cd ~/MLV-App-master
else
echo "updating MLV-App-master source"
cd ~/MLV-App-master
git pull
if ! [ -f $(cat /tmp/"m_a_compath2")/commits ]; then
echo "first" > $(cat /tmp/"m_a_compath2")/commits
fi
commit1=$(cat $(cat /tmp/"m_a_compath2")/commits)
commit2=$(git log --oneline -3)
if ! [ "$commit1" = "$commit2" ]; then
git log --oneline -3 > $(cat /tmp/"m_a_compath2")/commits
echo ""
echo "Recent commits:"$(tput bold)$(tput setaf 2)
sleep 0.5
git log --oneline -3 | awk 'FNR == 1'
sleep 1.5
git log --oneline -3 | awk 'FNR == 2'
sleep 1.5
git log --oneline -3 | awk 'FNR == 3'
echo ""
sleep 1
echo $(tput setaf 0)"Scroll back up for recent commits"
sleep 2
git log --oneline -10
else
echo "Recent commits:"$(tput bold)$(tput setaf 2)$(tput setaf 0)
git log --oneline -10
fi
fi

printf '\e[8;20;70t'
printf '\e[3;410;0t'
clear
while :
do 
cat<<EOF

----------------
$(tput bold)MLV App compiler$(tput sgr0)(thanks to Ilia3101,masc,bouncyball)
----------------

current branch:$(tput bold)$(tput setaf 4) $(git branch | awk '/\*/ { print $2; }')$(tput sgr0)

$(tput bold)$(tput setaf 1)(c)   compile MLV App$(tput sgr0)
$(tput bold)$(tput setaf 1)(op)  compile MLV App with openmp$(tput sgr0)(macOS 10.10 and onwards)
$(tput bold)$(tput setaf 1)(b)   check out branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(U)   update dependecies$(tput sgr0)(if compiling fails)
$(tput bold)$(tput setaf 1)(m)   make clean$(tput sgr0)

$(tput bold)(q)   quit this compiler$(tput sgr0)

Please enter your selection number below and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "co") 
clear
echo "Welcome to the wonderful world of Cocoa."
sleep 2
echo ""
echo "This version is what brought MLV app to life through Ilia3101"
sleep 2
echo ""
echo "Most features are old and might not be working!"
sleep 2
echo ""
echo "have fun!"
sleep 2
cd ~/MLV-App-master/platform/qt/
make clean 
cd ~/MLV-App-master/platform/cocoa/
make clean 
cd platform/cocoa
make app -j4
open .
echo "

scroll upwards to check terminal outcome."
    ;;

    "c") 
clear
echo "let´s clean repo first(make clean)!"
sleep 1
cd ~/MLV-App-master/platform/qt/
make clean 
cd ~/MLV-App-master/platform/cocoa/
make clean 
cd ~/MLV-App-master/platform && \
rm -r Mlv_app_master
mkdir -p Mlv_app_master && \
cd Mlv_app_master && \
$(ls -d /usr/local/Cellar/qt/5* | head -1 | tr -d ':')/bin/qmake ~/MLV-App-master/platform/qt/MLVApp.pro QMAKE_MACOSX_DEPLOYMENT_TARGET=10.8 -spec macx-clang CONFIG+=x86_64 CONFIG+=release && /usr/bin/make -j4 && $(ls -d /usr/local/Cellar/qt/5* | head -1 | tr -d ':')/bin/macdeployqt ~/MLV-App-master/platform/Mlv_app_master/MLV\ App.app && \
make clean && \
open ~/MLV-App-master/platform/Mlv_app_master/
echo "

scroll upwards to check terminal outcome."
    ;;

    "op") 
clear
#openmp
if ! [ -d /usr/local/Cellar/llvm/6* ]
then
brew install llvm@6
fi

#Can´t see why this was needed anymore?
#+ld64 adresses this issue (SYSROOT) https://trac.macports.org/ticket/53784
#if ! [ -f /opt/local/bin/ld-xcode ]; then
#macports
 #if ! [ -f /opt/local/bin/port ]; then
   #clear
   #echo "Install MacPorts for your version of the Mac operating system"
   #sleep 2
   #echo ""
   #echo "This means you go straight to step 3 in the Quickstart and 
   #skip Xcode and the Xcode Command Line Tools installation"
   #sleep 2
   #echo ""
   #echo "Rerun the compiler when you are done!"
   #sleep 2
   #open https://www.macports.org/install.php
   #exit 0
 #fi
  #sudo port selfupdate
  #sudo port upgrade outdated
  #sudo port install ld64 +ld64_xcode
#fi

clear
echo "let´s clean repo first(make clean)!"
sleep 1
cd ~/MLV-App-master/platform/qt/
make clean 
cd ~/MLV-App-master/platform/cocoa/
make clean 
cd ~/MLV-App-master/platform && \
rm -r Mlv_app_master
mkdir -p Mlv_app_master && \
cd Mlv_app_master && \
$(ls -d /usr/local/Cellar/qt/5* | head -1 | tr -d ':')/bin/qmake ~/MLV-App-master/platform/qt/MLVApp.pro QMAKE_CC=/usr/local/opt/llvm/bin/clang QMAKE_CXX=/usr/local/opt/llvm/bin/clang++ QMAKE_LINK=/usr/local/opt/llvm/bin/clang++ QMAKE_CFLAGS+=-fopenmp QMAKE_CXXFLAGS+=-fopenmp INCLUDEPATH+=-I/usr/local/opt/llvm/include LIBS+=-L/usr/local/opt/llvm/lib LIBS+=-lgomp QMAKE_MACOSX_DEPLOYMENT_TARGET=10.8 -spec macx-clang CONFIG+=x86_64 CONFIG+=release && /usr/bin/make -j4 && $(ls -d /usr/local/Cellar/qt/5* | head -1 | tr -d ':')/bin/macdeployqt ~/MLV-App-master/platform/Mlv_app_master/MLV\ App.app && \
make clean && \
open ~/MLV-App-master/platform/Mlv_app_master/
echo "

scroll upwards to check terminal outcome."
    ;;

    "b")
printf '\e[8;18;70t'
printf '\e[3;410;0t'
while :
do 
branches=$(git branch -a | awk '{printf("%01d %s\n", NR, $0)}' | cut -d '/' -f3 | cut -d ' ' -f3)
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF

current branch:$(tput bold)$(tput setaf 4) $(git branch | awk '/\*/ { print $2; }')$(tput sgr0)

$(tput bold)$(printf "%s\n" $branches | awk '{printf("%01d %s\n", NR, $0)}' | awk '{$1=$1}1' OFS="\t")$(tput sgr0)

$(tput bold)$(tput setaf 1)(m)   main menu$(tput sgr0)
$(tput bold)(q)   quit this compiler$(tput sgr0)

Please enter branch number and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    "m") 
. "$(cat /tmp/m_a_compath2)"/main.command
    ;;

    "$i") 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
git checkout $(printf "%s\n" $branches | awk 'FNR == "'$i'"')
. "$(cat /tmp/m_a_compath2)"/main.command
    ;;

    esac
done

    ;;

    "U") 
clear
echo "Updating!"
#start in user directory
cd ~
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#Mojave requires
if [ -f /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.*.pkg ]; then
open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.*.pkg
fi
#check for qt versions
brew install qt5
brew upgrade qt5
    ;;

    "m") 
echo "cleaning!"
sleep 1
cd ~/MLV-App-master/platform/qt/
make clean 
cd ~/MLV-App-master/platform/cocoa/
make clean 
cd ~/MLV-App-master/
clear
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    esac
done
    ;;




