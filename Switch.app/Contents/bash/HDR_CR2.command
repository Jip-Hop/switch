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

cat <<'EOF' > HDR_match.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

#hugin dependency
if ! [ -f "/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for hugin, please wait..."
sleep 2
read -p $(tput bold)"hugin is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install hugin
if [ -f "/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack" ]
then
clear && echo "hugin is installed and ready for use"
else
clear && echo "hugin did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
;;
esac
fi

#exiv2 dependency
if ! [ -f "/usr/local/bin/exiv2" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for exiv2, please wait..."
sleep 2
read -p $(tput bold)"exiv2 is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install exiv2
if [ -f "/usr/local/bin/exiv2" ]
then
clear && echo "exiv2 is intalled and ready for use"
else
clear && echo "exiv2 did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
;;
esac
fi

#HDRmerge dependency
if ! [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ] && [ -f HDRmerge ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for HDRmerge, please wait..."
sleep 2
read -p $(tput bold)"HDRMerge is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
[ ! -f "`which wget`" ] && brew install wget
wget -O HDRMerge.dmg https://github.com/jcelaya/hdrmerge/releases/download/v0.5.0/HDRMerge.dmg && hdiutil attach HDRMerge.dmg && cp -r /Volumes/HDRMerge\ for\ Mac/HDRMerge.app /Applications && hdiutil eject /Volumes/HDRMerge\ for\ Mac && rm HDRMerge.dmg
sleep 2
if [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
then
clear && echo "HDRmerge is intalled and ready for use"
else
clear && echo "HDRmerge did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
;;
esac
fi

#dcraw
if ! [ -f "/usr/local/bin/dcraw" ] && [ -f enfuse ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for dcraw, please wait..."
sleep 2
read -p $(tput bold)"dcraw is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
brew install dcraw
if [ -f "/usr/local/bin/dcraw" ]
then
clear && echo "dcraw is installed and ready for use"
else
clear && echo "dcraw did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi

#ffmpeg
if ! [ -f "/usr/local/bin/ffmpeg" ] && [ -f FFmpeg ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for ffmpeg, please wait..."
sleep 2
read -p $(tput bold)"ffmpeg is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
brew install ffmpeg
if [ -f "/usr/local/bin/ffmpeg" ]
then
clear && echo "ffmpeg is installed and ready for use"
else
clear && echo "ffmpeg did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi

#start clean
 rm list
 rm match*    
 rm *preview3.jpg
#exiv2 extracts your jp files embedded in CR2 files
 exiv2 -ep3 -l . *.{cr2,CR2}
#list jpg files
 ls *.jpg > list

#what´s going on
printf '\e[8;6;50t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Let´s group matched CR2 files before merging"$(tput sgr0)
sleep 2

while : 
do
 clear
echo $(tput bold)"Still building brackets"$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets.."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets..."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets...."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets....."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets......"$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets......."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets........"$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets........."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"Still building brackets.........."$(tput sgr0)
sleep 1
 clear
done & pid1=$!

#main loop
while grep 'jpg' list >/dev/null 2>&1
do
 value=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -a test "$(cat list | awk 'FNR == 1')" "$(cat list | awk 'FNR == 2')" | grep -m 1 'after 100 iteration\|No Feature Points\|Multiple images output\|You have too few control points') 

#if you get a matching pair
if [ "$value" = "Multiple images output" ]
 then
#check for matching list
  if [ -f match ]
   then
   echo "" >> match
  fi
 echo -n "$(cat list | awk 'FNR == 1' | cut -d "-" -f1).CR2" >> match 
fi 
#keep on going if all matches  
 while [ "$value" = "Multiple images output" ]
  do
   echo -n " $(cat list | awk 'FNR == 2' | cut -d "-" -f1).CR2" >> match
    rm "$(cat list | awk 'FNR == 1')"
    echo -n "$(tail -n +2 list)" > list
   value=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -a test "$(cat list | awk 'FNR == 1')" "$(cat list | awk 'FNR == 2')" | grep -m 1 'after 100 iteration\|No Feature Points\|Multiple images output\|You have too few control points')
  done

#if no match just erase and move on
 while [ "$value" = "No Feature Points" ] || [ "$(echo $value | cut -d "(" -f1)" = "after 100 iteration" ] || [ "$(echo $value | cut -d "(" -f1)" = "You have too few control points " ] || [ x"$value" = x ] && [ "$(ls *.jpg | head -1)" ] 
  do
   rm "$(cat list | awk 'FNR == 1')"
    echo -n "$(tail -n +2 list)" > list
   value=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -a test "$(cat list | awk 'FNR == 1')" "$(cat list | awk 'FNR == 2')" | grep -m 1 'after 100 iteration\|No Feature Points\|Multiple images output\|You have too few control points')
 done
done

rm list
kill -9 $pid1 
sleep 1
clear
echo $(tput bold)"Bracketing done!"$(tput sgr0)
sleep 2

#let´s continue by splitting match list for multiprocessing purposes
split -l $(( $( wc -l < match ) / 3 + 1 )) match match
rm match

#remove unwanted subscripts
if ! [ -f matchaa ]
 then
  rm HDR1.command
  rm HDRmerge enfuse FFmpeg 
  else
  chmod u=rwx HDR1.command
  open HDR1.command & 
fi

if ! [ -f matchab ]
 then
  rm HDR2.command
  else
  chmod u=rwx HDR2.command 
  open HDR2.command & 
fi

if ! [ -f matchac ]
 then
  rm HDR3.command
  else
  chmod u=rwx HDR3.command
  open HDR3.command &  
fi

if ! [ -f matchad ]
 then
  rm HDR4.command
  else
  chmod u=rwx HDR4.command 
  open HDR4.command & 
fi

#remove first command and start HDRmerge processing
sleep 2 && rm HDR_match.command & echo -n -e "\033]0;end\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end")' & exit 

EOF

#now build multiprocessing subscripts
#process1
cat <<'EOF' > HDR1.command
workingDir=`dirname "$0"`
cd "${workingDir}"

printf '\e[8;6;40t'
printf '\e[3;410;100t'
#stash away originals
mkdir -p CR2_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg &
 while grep 'CR2' matchaa >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 1 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -a $(cat matchaa | awk 'FNR == 1')
    mv $(cat matchaa | awk 'FNR == 1') CR2_ORIGINALS
   echo "$(tail -n +2 matchaa)" > matchaa
  done
 sleep 2 && rm HDR1.command & rm matchaa
clear
echo $(tput bold)"HDR script 1 finished processing"$(tput sgr0)
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi
EOF

#process2
cat <<'EOF' > HDR2.command
workingDir=`dirname "$0"`
cd "${workingDir}"

printf '\e[8;6;40t'
printf '\e[5;410;100t'
#stash away originals
mkdir -p CR2_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg &
 while grep 'CR2' matchab >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 2 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -a $(cat matchab | awk 'FNR == 1')
    mv $(cat matchab | awk 'FNR == 1') CR2_ORIGINALS
   echo "$(tail -n +2 matchab)" > matchab
  done
 sleep 2 && rm HDR2.command & rm matchab
clear
echo $(tput bold)"HDR script 2 finished processing"$(tput sgr0)
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi
EOF

#process3
cat <<'EOF' > HDR3.command
workingDir=`dirname "$0"`
cd "${workingDir}"

printf '\e[8;6;40t'
printf '\e[7;410;100t'
#stash away originals
mkdir -p CR2_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg &
 while grep 'CR2' matchac >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 3 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -a $(cat matchac | awk 'FNR == 1')
    mv $(cat matchac | awk 'FNR == 1') CR2_ORIGINALS
   echo "$(tail -n +2 matchac)" > matchac
  done
 sleep 2 && rm HDR3.command & rm matchac
clear
echo $(tput bold)"HDR script 3 finished processing"$(tput sgr0)
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi
EOF

#process4
cat <<'EOF' > HDR4.command
workingDir=`dirname "$0"`
cd "${workingDir}"

printf '\e[8;6;40t'
printf '\e[9;410;100t'
#stash away originals
mkdir -p CR2_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg &
 while grep 'CR2' matchad >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 4 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -a $(cat matchad | awk 'FNR == 1')
    mv $(cat matchad | awk 'FNR == 1') CR2_ORIGINALS
   echo "$(tail -n +2 matchad)" > matchad
  done
 sleep 2 && rm HDR4.command & rm matchad
clear
echo $(tput bold)"HDR script 4 finished processing"$(tput sgr0)
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi
EOF
