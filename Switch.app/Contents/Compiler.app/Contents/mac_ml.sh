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

#let´s download magic-lantern and place it anywhere, but only if we go through source_location.app
if ls /tmp/source_location >/dev/null 2>&1;
then
cd "$(cat /tmp/compath1)"
rm /tmp/source_location
hg clone https://bitbucket.org/hudson/magic-lantern
cd magic-lantern
if ! [ -f Makefile.user ]
then
    cat <<'EOT' > Makefile.user
#
# Host compiler settings
#
HOST_CC=gcc-5
HOST_LD=gcc-5
HOST_AR=$(shell which ar)
EOT
fi
echo "$(cat /tmp/compath1)"/magic-lantern > /tmp/compath1
cd magic-lantern
fi


#check for missing dependencies
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
  exit 0
fi

if [ ! -d "/Library/Developer/CommandLineTools" ]; 
then 
cltools=$(tput setaf 1)$(echo commandLineTools missing)$(tput sgr0)
fi
if ! [ -f "/usr/local/bin/hg" ]
then
hg=$(tput setaf 1)$(echo mercurial missing)$(tput sgr0)
fi
if ! [ -f "/usr/local/bin/brew" ]
then
brew=$(tput setaf 1)$(echo brew missing)$(tput sgr0)
fi
if ! test -d ~/gcc-arm-none-eabi-4_8-2013q4; 
then
gcc4=$(tput setaf 1)$(echo gcc4_8-2013q4 missing)$(tput sgr0)
fi
if ! test -d ~/gcc-arm-none-eabi-5_4-2016q3; 
then
gcc5=$(tput setaf 1)$(echo gcc5_4-2016q3 missing)$(tput sgr0)
fi

#create a few user interaction alternatives
if ! [ x"$cltools$hg$brew$gcc4$gcc5" = x ]
then 
clear
echo $(tput bold)"following dependencies are missing"$(tput sgr0)
echo "$cltools
$hg
$brew
$gcc4
$gcc5" 
sleep 2
echo "It´s advised to run the full dependency install script before continuing"
sleep 2 
read -p $(tput bold)"Enter $(tput setaf 1)Y$(tput sgr0)$(tput bold) to install dependencies:$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/usr/bin/env bash
clear
echo "Follow instructions in terminal window"
clear
sleep 2
cd ~
#dfort installation script
cd ~
. "$(cat /tmp/compath2)"/mac_ml.sh
clear
echo $(tput bold)"Magic Lantern development environment setup finished."
sleep 5
cltools=
hg=
brew=
gcc4=
gcc5=
clear
cd "$(cat /tmp/compath1)"
;;
  n|N ) 
clear
echo $(tput bold)"You entered no!" 
sleep 1
echo "You can still run the script from the Main menu"
echo "have fun!"$(tput bold)
sleep 3
;;
esac
fi

#enter ml path
if ! [ -d "$(cat /tmp/compath1)" ]
then 
rm /tmp/compath1
printf '\e[8;21;100t'
printf '\e[3;410;0t'
clear 
echo $(tput bold)"Path to magic lantern repository is missing"$(tput sgr0) 
sleep 2
echo ""
echo "Solution:$(tput bold)$(tput setaf 2) 

Drag repository folder onto Compiler.app to set its path"
sleep 2
echo ""
echo $(tput sgr0)$(tput bold)"or.."
sleep 2
echo ""
echo $(tput bold)$(tput setaf 2)"Clone magic-lantern repo straight away before continuing"
sleep 2
if [ -d ~/magic-lantern ]
then
echo ""
echo $(tput setaf 2)"Wait a minute. Seems you already have a magic-lantern repository downloaded, let´s use that one"$(tput sgr0)
sleep 4
echo ~/magic-lantern > /tmp/compath1
cd "$(cat /tmp/compath1)"
else
clear
read -p $(tput sgr0)$(tput bold)"Would you like to clone magic-lantern to your system?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
cd ~ 
clear
hg clone https://bitbucket.org/hudson/magic-lantern
sleep 2
cd magic-lantern
if ! [ -f Makefile.user ]
then
    cat <<'EOT' > Makefile.user
#
# Host compiler settings
#
HOST_CC=gcc-5
HOST_LD=gcc-5
HOST_AR=$(shell which ar)
EOT
fi
echo ~/magic-lantern > /tmp/compath1
$(tput sgr0)
;;
  n|N ) 
clear
echo $(tput bold)"You entered no!" 
sleep 1
echo "You can still download a repo from Main menu"
echo "have fun!"$(tput sgr0)
sleep 3
;;
esac
fi 
else
cd "$(cat /tmp/compath1)"
fi

#here we go. Main script
printf '\e[8;23;70t'
printf '\e[3;410;0t'
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF

     $(tput sgr0)----
     $(tput bold)Main$(tput sgr0) 
     ----
repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)
 current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(b)  branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  modules$(tput sgr0)
$(tput bold)$(tput setaf 1)(p)  platform$(tput sgr0)
$(tput bold)$(tput setaf 1)(M)  make clean$(tput sgr0)
$(tput bold)$(tput setaf 1)(u)  pull and update source code$(tput sgr0)
$(tput bold)$(tput setaf 1)(C)  development installation script$(tput sgr0)(dfort)
$(tput bold)$(tput setaf 1)(c)  clone magic lantern repository$(tput sgr0)
$(tput bold)$(tput setaf 1)(o)  open source code$(tput sgr0)
$(tput bold)$(tput setaf 4)(h)  HOWTO$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)

Please enter your selection number below and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "b") 
printf '\e[8;200;100t'
printf '\e[3;410;0t'
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF


current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(hg branches | awk '{printf("%01d %s\n", NR, $0)}' | cut -d ' ' -f1,2)$(tput sgr0)

current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit$(tput sgr0)

Please enter your selection number below and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    "$i") 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
hg update $(hg branches | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
    ;;

    esac
done
    ;;


#modules

    "m") 
cd modules
printf '\e[8;200;100t'
printf '\e[3;410;0t'
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF


current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(ls -d */ | cut -f1 -d'/' | awk '{printf("%01d %s\n", NR, $0)}')$(tput sgr0)

current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit$(tput sgr0)

Please enter your selection number below and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    "$i") 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
module=$(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
cd $(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
clear
echo "You are here:" $(tput setaf 4)$(tput bold)$module$(tput sgr0)
echo ""
echo $(tput bold)"Please specify command:$(tput sgr0)e.g $(tput bold)make mlv_dump$(tput sgr0) then hit enter)"
read input_variable
$input_variable
open . 
cd ..
sleep 2 && open -a terminal &
    ;;

    esac
done
    ;;


#platform

    "p") 
cd platform
printf '\e[8;35;80t'
printf '\e[3;410;0t'
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF


current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(ls -d */ | cut -f1 -d'/' | awk '{printf("%01d %s\n", NR, $0)}')$(tput sgr0)

current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit$(tput sgr0)

Please enter your selection number below and press enter:
EOF
read input_variable
i=$input_variable
case "$i" in

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    "$i") 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
module=$(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
cd $(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
clear
echo "You are here:" $(tput setaf 4)$(tput bold)$module$(tput sgr0)
echo ""
echo $(tput bold)"Please specify command:$(tput sgr0)(e.g $(tput bold)make zip$(tput sgr0) then hit enter)"
read input_variable
$input_variable
open . 
cd ..
sleep 2 && open -a terminal &
    ;;

    esac
done
    ;;


#main

    "C")
cd ~
#dfort installation script
. "$(cat /tmp/compath2)"/mac_ml.sh
cd "$(cat /tmp/compath1)"
    ;;

    "M") 
make clean
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
    ;;

   "u")  
#pull from source
cd "$(cat /tmp/compath1)"
clear
   hg pull https://bitbucket.org/hudson/magic-lantern
   hg update
sleep 3
;;

   "c") 
open "$(cat /tmp/compath2)"/source_location.app
clear
echo $(tput bold)"


Choose source code location path"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

   "o")  
open -a TextEdit "$(cat /tmp/compath2)"/main.command
;;

   "h")  
clear
echo $(tput bold)"Welcome to Compiler howto"
sleep 2
echo ""
echo "The steps are very easy to follow"
sleep 2
echo ""
echo "1 - select a branch you want to work with then go back to main menu"
sleep 3
echo ""
echo "2 - then select either modules or platform depending on what to do"
sleep 3
echo ""
echo "3 - select module or platform then type what´s needed to compile"
sleep 3
echo ""
echo "Good luck!"
sleep 2
echo ""
echo $(tput setaf 1)"Enter any key to get back to main menu:"
    read -n1
    case "$REPLY" in
    * )  
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;
    esac
;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    esac
done
