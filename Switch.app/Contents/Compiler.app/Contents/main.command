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
printf '\e[8;27;70t'
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
$(tput bold)$(tput setaf 1)(p)  platform$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  modules$(tput sgr0)
$(tput bold)$(tput setaf 1)(M)  make clean$(tput sgr0)
$(tput bold)$(tput setaf 1)(u)  pull and update magic lantern source code$(tput sgr0)
$(tput bold)$(tput setaf 1)(C)  development installation script$(tput sgr0)
$(tput bold)$(tput setaf 1)(c)  download magic lantern repository$(tput sgr0)
$(tput bold)$(tput setaf 1)(s)  select a new repository$(tput sgr0)
$(tput bold)$(tput setaf 1)(t)  terminal$(tput sgr0)
$(tput bold)$(tput setaf 1)(l)  my repo list$(tput sgr0)
$(tput bold)$(tput setaf 1)(o)  open up Compiler.app main script$(tput sgr0)
$(tput bold)$(tput setaf 1)(hg) hg.command$(tput sgr0)(expert option)
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
num1=$(echo 1)
num2=$(echo 30)
num=$(printf "%s\n" sed -n "$num1","$num2"p)
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF


current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(hg branches | awk '{printf("%01d %s\n", NR, $0)}' | cut -d ' ' -f1,2 | awk '{$1=$1}1' OFS="\t" | $num)

Total of $(hg branches | wc -l | tr -d " ") branches

current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(s)  branch keyword search$(tput sgr0)
$(tput bold)$(tput setaf 1)(n)  next 30 branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(b)  go back 30 branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(f)  print full list of branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(r)  refresh branch list$(tput sgr0)
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
if [ "$input_variable" = n ];
then
if [ "$num2" = "$(hg branches | wc -l | tr -d " ")" ]
then
num1=$(echo 1)
num2=$(echo 30)
num=$(printf "%s\n" sed -n "$num1","$num2"p)
else
num1=$(echo $num1+30 | bc -l)
num2=$(echo $num2+30 | bc -l)
num=$(printf "%s\n" sed -n "$num1","$num2"p)
fi
fi
if [ "$input_variable" = b ];
then
if ! [ "$num1" = 1 ]
then
num1=$(echo $num1-30 | bc -l)
num2=$(echo $num2-30 | bc -l)
num=$(printf "%s\n" sed -n "$num1","$num2"p)
else
clear
echo "You can only go forward from here"
sleep 1
fi
fi
if [ "$input_variable" = f ];
then
num1=$(echo 1)
num2=$(hg branches | wc -l | tr -d " ")
num=$(printf "%s\n" sed -n "$num1","$num2"p)
fi
if [ "$input_variable" = r ];
then
num1=$(echo 1)
num2=$(echo 30)
num=$(printf "%s\n" sed -n "$num1","$num2"p)
fi
#keyword search
if [ "$input_variable" = s ];
then
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
echo "repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo " current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)"
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(b)  back to branches$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo $(tput bold)"Please specify a $(tput sgr0)(branch)$(tput bold)search keyword:$(tput sgr0)(e.g crop or lua)"
read input_variable
i=$input_variable
case "$i" in

    "$i")
if [ "$input_variable" = q ];
then
osascript -e 'tell application "Terminal" to close first window' & exit
fi
if [ "$input_variable" = b ];
then
cd "$(cat /tmp/compath1)"
else
num=$(printf "%s\n" grep $input_variable)
fi
    ;;

    esac
fi



done
    ;;

#platform

    "p") 
cd platform
printf '\e[8;34;80t'
printf '\e[3;410;0t'
while :
do 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
cat<<EOF


current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(ls -d */ | cut -f1 -d'/' | awk '{printf("%01d %s\n", NR, $0)}' | awk '{$1=$1}1' OFS="\t")$(tput sgr0)

current branch:$(tput bold)$(tput setaf 4) $(hg branch)$(tput sgr0)

$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit$(tput sgr0)

Select your camera to compile and hit enter:
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
platform=$(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
cd $(ls -d */ | cut -f1 -d'/' | awk 'FNR == "'$i'"' | cut -d ' ' -f1)
while :
do
clear
echo "You are here:" $(tput setaf 4)$(tput bold)$platform$(tput sgr0)
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(c)  compile$(tput sgr0)
$(tput bold)$(tput setaf 1)(M)  make clean$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo $(tput bold)"Please specify any command or choose from menu above:$(tput sgr0)"
read input_variable
i=$input_variable
case "$i" in

    "c") 
make zip
clear
echo "grab your compiled zip file and put it on your camera"
sleep 2
open . 
input_variable=$(echo zipp)
    ;;

    "M") 
make clean
input_variable=$(echo zipp)
    ;;

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;
    esac
if ! [ "$input_variable" = zipp ];
then
$input_variable
fi
sleep 1
done
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

$(tput bold)$(ls -d */ | cut -f1 -d'/' | awk '{printf("%01d %s\n", NR, $0)}' | awk '{$1=$1}1' OFS="\t")$(tput sgr0)

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
echo > /tmp/cloning
open "$(cat /tmp/compath2)"/source_location.app
clear
echo $(tput bold)"


Choose source code location path"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

   "s") 
echo > /tmp/reposelect
open "$(cat /tmp/compath2)"/source_location.app
clear
echo $(tput bold)"


Choose repository path"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;

    "t") 
/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear
while :
do
echo "You are here:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo $(tput bold)"Please specify any command:$(tput sgr0)(scroll up to check outcome)"
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
    esac
$input_variable
sleep 2
clear
done
    ;;


    "l") 
#here we go. Main script
if (( $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l) > 14 ))
then
num=$(echo $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l)+14 | bc -l)
else
num=$(echo 27)
fi
printf '\e[8;'$num';70t'
printf '\e[3;410;0t'
#if the file is missing from the start
if ! grep "$(cat /tmp/compath1)" <<< "$(cat "$(cat /tmp/compath2)"/repolist.txt)"
then
echo "$(cat /tmp/compath1)" | cat - "$(cat /tmp/compath2)"/repolist.txt > temp && mv temp "$(cat /tmp/compath2)"/repolist.txt
fi
if ! [ -f "$(cat /tmp/compath2)"/repolist.txt ]
then
printf "%s\n" "$(cat /tmp/compath1)" > "$(cat /tmp/compath2)"/repolist.txt
fi
if [ x"$(cat "$(cat /tmp/compath2)"/repolist.txt)" = x ]
then
printf "%s\n" "$(cat /tmp/compath1)" > "$(cat /tmp/compath2)"/repolist.txt
fi

/usr/bin/osascript -e 'tell application "System Events" to tell process "Terminal" to keystroke "k" using command down'
clear

while :
do
echo $(tput bold)"My repo list:$(tput sgr0)"
echo ""
    OLDIFS=$IFS
    IFS=$'\n'
printf "%s\n" $(tput bold)$(cat "$(cat /tmp/compath2)"/repolist.txt | awk '{printf("%01d %s\n", NR, $0)}' | awk '{$1=$1}1' OFS="\t")$(tput sgr0)
    IFS=$OLDIFS 
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(r)  reset my repo list$(tput sgr0)
$(tput bold)$(tput setaf 1)(d)  download a repository$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo "current repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo ""
echo $(tput bold)"Select a repo number to enter it or drag repository paths and 
press enter to extend your list:$(tput sgr0)"
read input_variable
i=$input_variable
case "$i" in

    "r") 
rm "$(cat /tmp/compath2)"/repolist.txt
input_variable=
clear
echo "list deleted"
sleep 1
printf '\e[8;'27';70t'
printf '\e[3;410;0t'
    ;;


    "d") 
clear
echo ""
echo "current repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(f)  download a full user repo section$(tput sgr0)
$(tput bold)$(tput setaf 1)(l)  return to my repo list$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo $(tput bold)"Paste a repository url and press enter:$(tput sgr0)
(repo will be downloaded to home folder)"
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

    "f")
cd ~ 
clear
echo ""
echo "current repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(l)  return to my repo list$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF
echo ""
echo $(tput bold)"Paste a user repo url and press enter:$(tput sgr0)
(e.g https://bitbucket.org/hudson/)
All repos will be downloaded to ~/repo_ripper folder"
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
list=$(printf '%s\n' $(grep -o -E 'repo-list--repo-name" href=".{0,50}' <<< $(curl -L $input_variable) | cut -d '/' -f3 | cut -d '"' -f1))
ext=_$(echo $input_variable | rev | cut -d '/' -f2 | rev)
mkdir -p repo_ripper
cd repo_ripper
while read -r line; do
    hg clone $input_variable$line "$line$ext" 
if ! grep "$line$ext" <<< $(cat "$(cat /tmp/compath2)"/repolist.txt) && [ -d "$line$ext" ]
then
printf "%s\n" ~/repo_ripper/$line$ext >> "$(cat /tmp/compath2)"/repolist.txt
fi
done <<< "$list"
    ;;

esac
printf '\e[8;'27';70t'
printf '\e[3;410;0t'
    ;;

    "$i")
if ! [ "$input_variable" = l ];
then
cd ~ 
clear
fold="$(echo $input_variable | rev | cut -d '/' -f1 | rev)"
if [ -d "$(echo $input_variable | rev | cut -d '/' -f1 | rev)" ]
then
fold="$(echo $input_variable | rev | cut -d '/' -f1 | rev)"
ext=_"$(echo $input_variable | rev | cut -d '/' -f2 | rev)"
fi
if ! [ -d $fold$ext ] || ! [ -d "$(echo $input_variable | rev | cut -d '/' -f1 | rev)" ]
then
if ! grep 'hg clone' <<< $input_variable
then
hg clone $input_variable $fold$ext
else
$input_variable $fold$ext
fi
echo "$input_variable repository downloaded"
echo ~/$fold$ext >> "$(cat /tmp/compath2)"/repolist.txt
else
clear
echo "repository folder name already exists, sorry"
sleep 2
fi
if (( $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l) > 14 ))
then
num=$(echo $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l)+14-1 | bc -l)
else
num=$(echo 27)
fi
fi
printf '\e[8;'$num';70t'
printf '\e[3;410;0t'
    ;;
esac
printf '\e[8;'27';70t'
printf '\e[3;410;0t'
    ;;

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;
    esac

case $i in
    ''|*[!0-9]*) if ! [ -f "$(cat /tmp/compath2)"/repolist.txt ]; 
then
printf "%s\n" "$(cat /tmp/compath1)" > "$(cat /tmp/compath2)"/repolist.txt
else
if [ -d $(printf "%s\n" $input_variable | awk 'FNR == 1') ]
then
printf "%s\n" $input_variable >> "$(cat /tmp/compath2)"/repolist.txt
else
clear
if ! [ "$input_variable" = l ] && [ x"$list" = x ];
then
echo "not a repository, try to drag a folder"
sleep 1
fi
fi
fi
input_variable=
fold=
ext=
 ;;
    *) 
if [ -d $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"') ]
then

#check if reselecting the same branch
if [ $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"') = "$(cat /tmp/compath1)" ]
then
clear
echo "You have reselected an existing path"
sleep 1
echo ""
echo "What would you like to do?"
sleep 2
echo ""
cat<<EOF
$(tput bold)$(tput setaf 1)(d)  delete folder path from repolist$(tput sgr0)(no files erased)
$(tput bold)$(tput setaf 1)(X)  erase folder path and also remove the folder and all its content$(tput sgr0)
$(tput bold)$(tput setaf 1)(m)  main$(tput sgr0)
$(tput bold)$(tput setaf 1)(l)  return to my repo list$(tput sgr0)
$(tput bold)$(tput setaf 1)(q)  exit $(tput sgr0)
EOF

echo ""
echo "current repository path:$(tput setaf 4) $(cat /tmp/compath1)$(tput sgr0)"
echo ""
echo $(tput bold)"Select from menu and press enter:$(tput sgr0)"
    read -n2
    case "$REPLY" in

    "d") 
sed -e ''$i'd' "$(cat /tmp/compath2)"/repolist.txt > "$(cat /tmp/compath2)"/repolisttmp.txt
mv "$(cat /tmp/compath2)"/repolisttmp.txt "$(cat /tmp/compath2)"/repolist.txt
#see to it that first one in line is chosen
i=1
clear
echo "folder path deleted"
sleep 1
if (( $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l) > 14 ))
then
num=$(echo $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l)+14-1 | bc -l)
else
num=$(echo 27)
fi
printf '\e[8;'$num';70t'
printf '\e[3;410;0t'
    ;;

    "X") 
if [ -d $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"') ]
then
clear
read -p $(tput bold)"This will remove the entire repository from your drive, are you sure?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/usr/bin/env bash
clear
rm -r $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"')
sed -e ''$i'd' "$(cat /tmp/compath2)"/repolist.txt > "$(cat /tmp/compath2)"/repolisttmp.txt
mv "$(cat /tmp/compath2)"/repolisttmp.txt "$(cat /tmp/compath2)"/repolist.txt
clear
echo "folder path and all its content erased"
sleep 1
;;
esac
fi
    ;;

    "m") 
cd "$(cat /tmp/compath1)"
. "$(cat /tmp/compath2)"/main.command
    ;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
    ;;
    esac
fi
cd $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"') && echo $(cat "$(cat /tmp/compath2)"/repolist.txt | awk 'FNR == "'$i'"') > /tmp/compath1
else
clear
echo "folder no longer exist"
sleep 1
sed -e ''$i'd' "$(cat /tmp/compath2)"/repolist.txt > "$(cat /tmp/compath2)"/repolisttmp.txt
mv "$(cat /tmp/compath2)"/repolisttmp.txt "$(cat /tmp/compath2)"/repolist.txt
fi
 ;;
esac
if (( $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l) > 14 ))
then
num=$(echo $(cat "$(cat /tmp/compath2)"/repolist.txt | wc -l)+14 | bc -l)
else
num=$(echo 27)
fi
printf '\e[8;'$num';70t'
printf '\e[3;410;0t'
clear
done
    ;;

   "o")  
open -a TextEdit "$(cat /tmp/compath2)"/main.command
;;

   "hg")  
. "$(cat /tmp/compath2)"/hg.command
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
echo "2 - now select either modules or platform depending on what to compile"
sleep 3
echo ""
echo "3 - to compile for your camera simply select your camera platform and 
then specify $(tput sgr0)make zip$(tput bold) or select $(tput bold)$(tput setaf 1)(c)  compile$(tput sgr0) $(tput bold)from the submenu"
sleep 3
echo ""
echo "4 - when done head back to main menu and select $(tput bold)$(tput setaf 1)(M)  make clean$(tput sgr0) $(tput bold)to 
reset your repository to origin"
sleep 3
echo ""
echo "feel free to test the other menu options in main menu and report any 
problems at https://www.magiclantern.fm/forum/"
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
