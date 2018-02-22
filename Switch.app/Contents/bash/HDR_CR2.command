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
if ! [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
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

#ffmpeg
if ! [ -f "/usr/local/bin/ffmpeg" ]
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
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
;;
esac
fi

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
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets.."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets..."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets...."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets....."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets......"$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets......."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets........"$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets........."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets.........."$(tput sgr0)
[ -f match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2' <<< $(cat match | tail -1) >/dev/null 2>&1 && echo $(cat match | tail -1)
sleep 1
 clear
done & pid1=$!

#unified setting. Set time gap
   if [ -f time ]
   then 
   gap=$(cat time)
   rm time
   else
   gap=$(echo 5)
   fi
   
#main loop(all_in)
if [ -f all_in ]
then
#start clean
 rm list
 rm match* 
 rm *preview3.jpg
 mkdir -p A_ORIGINALS
#exiv2 extracts your jp files embedded in CR2 files
 exiv2 -ep3 -l . *.{cr2,CR2}
#extract metadata info
 exiv2 -e X extract *.CR2
#rename xmp to work as sidecars 
 for i in *.xmp ; do
 mv "$i" "${i/.xmp}"-preview3.xmp
 done
#insert metadata recursively
 exiv2 -i X insert *.jpg 
#We are done, thanks exiv2
 rm *.xmp
#list CR2 files
 ls *.{cr2,CR2} > list
#let´s start
while grep 'CR2' list >/dev/null 2>&1
do
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    if ! [ -f match ]
    then
#CR2
    echo -n "$(cat list | awk 'FNR == 1')" >> match
#jpg
    echo -n "$(cat list | awk 'FNR == 1' | cut -d "." -f1)"-preview3.jpg >> matchB
    fi
#CR2
    echo -n " $(cat list | awk 'FNR == 2')" >> match
#jpg
    echo -n " $(cat list | awk 'FNR == 2' | cut -d "." -f1)"-preview3.jpg >> matchB
    echo -n "$(tail -n +2 list)" > list
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f match ]
    then
#CR2
    echo "" >> match
#jpg
    echo "" >> matchB
    fi
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f match ] && [ -f "$(cat list | awk 'FNR == 2')" ]
    then
#CR2
    echo -n $(cat list | awk 'FNR == 1') >> match
#jpg
    echo -n "$(cat list | awk 'FNR == 1' | cut -d "." -f1)"-preview3.jpg >> matchB
    fi
done
#end of all_in processing
    rm list
fi

#main loop(HDRmerge)
if [ -f HDRmerge ]
then
#start clean
 rm list
 rm match* 
 mkdir -p A_ORIGINALS
 ls *.{cr2,CR2} > list
#let´s start
while grep 'CR2' list >/dev/null 2>&1
do
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    if ! [ -f match ]
    then
    echo -n "$(cat list | awk 'FNR == 1')" >> match
    fi
    echo -n " $(cat list | awk 'FNR == 2')" >> match
    echo -n "$(tail -n +2 list)" > list
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f match ]
    then
    echo "" >> match
    fi
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f match ] && [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    echo -n $(cat list | awk 'FNR == 1') >> match
    fi
done
#end of HDRmerge processing
    rm list
fi

#main loop(enfuse,FFmpeg)
if [ -f enfuse ] || [ -f FFmpeg ] 
then
#start clean
 rm list
 rm match* 
 rm *preview3.jpg
 mkdir -p A_ORIGINALS
#exiv2 extracts your jp files embedded in CR2 files
 exiv2 -ep3 -l . *.{cr2,CR2}
#extract metadata info
 exiv2 -e X extract *.CR2
#rename xmp to work as sidecars 
 for i in *.xmp ; do
 mv "$i" "${i/.xmp}"-preview3.xmp
 done
#insert metadata recursively
 exiv2 -i X insert *.jpg 
#We are done, thanks exiv2
 rm *.xmp
#list jpg,tiff files
 ls *.{jpg,JPG,tif,tiff,TIF,TIFF} > list
#let´s start
while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' list >/dev/null 2>&1
do
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    if ! [ -f match ]
    then
    echo -n "$(cat list | awk 'FNR == 1')" >> match
    fi
    echo -n " $(cat list | awk 'FNR == 2')" >> match
    echo -n "$(tail -n +2 list)" > list
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f match ]
    then
    echo "" >> match
    fi
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 list)" > list
    if [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f match ] && [ -f "$(cat list | awk 'FNR == 2')" ]
    then
    echo -n $(cat list | awk 'FNR == 1') >> match
    fi
done
rm list
mv *.{cr2,CR2} A_ORIGINALS
fi

#when bracketing list is done go here
kill -9 $pid1 
sleep 1
clear
echo $(tput bold)"Bracketing done!"$(tput sgr0)
sleep 2

#let´s continue by splitting match list for multiprocessing purposes
split -l $(( $( wc -l < match ) / 3 + 1 )) match match
rm match
#if all_in mode selected
if [ -f all_in ]
then
split -l $(( $( wc -l < matchB ) / 3 + 1 )) matchB matchB
rm matchB
fi

#remove unwanted subscripts
if ! [ -f matchaa ]
 then
  rm HDR1.command
  rm HDRmerge enfuse FFmpeg all_in
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
mkdir -p A_ORIGINALS

#choose HDR workflow
#process 1
if [ -f HDRmerge ] || [ -f all_in ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg >/dev/null 2>&1 & 
#set prefix if all_in mode
if [ -f all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2' matchaa >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 1 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat matchaa | awk 'FNR == 1')
    mv $(cat matchaa | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 matchaa)" > matchaa
  done
#all_in mode
if ! [ -f all_in ]
then
 sleep 2 && rm HDR1.command & rm matchaa
clear
echo $(tput bold)"HDR script 1 finished processing"$(tput sgr0)
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
else
rm matchaa
mv matchBaa matchaa
fi
fi

if [ -f enfuse ] || [ -f all_in ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg >/dev/null 2>&1 & 
#all_in mode
if [ -f all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm Enfuse_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm FFmpeg_"$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchaa | awk 'FNR == 1')
then
mv $(cat matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchaa)" > matchaa
done
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls HDR2.command HDR3.command HDR4.command)
then 
rm all_in
rm LOG.txt
fi
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)  
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchaa | awk 'FNR == 1')
then
mv $(cat matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchaa)" > matchaa
  done
fi
 sleep 2 && rm HDR1.command & rm matchaa
clear
echo $(tput bold)"HDR script 1 finished processing"$(tput sgr0)
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi

if [ -f FFmpeg ]
then
sleep 5 && rm HDRmerge enfuse FFmpeg >/dev/null 2>&1 & 
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat matchaa | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchaa | awk 'FNR == 1')
then
mv $(cat matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 matchaa)" > matchaa
#erase 
   rm aligned1*.tif 
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
mkdir -p A_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ] || [ -f all_in ]
then
#set prefix if all_in mode
if [ -f all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2' matchab >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 2 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat matchab | awk 'FNR == 1')
    mv $(cat matchab | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 matchab)" > matchab
  done
#all_in mode
if ! [ -f all_in ]
then
 sleep 2 && rm HDR2.command & rm matchab
clear
echo $(tput bold)"HDR script 2 finished processing"$(tput sgr0)
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
else
rm matchab
mv matchBab matchab
fi
fi

if [ -f enfuse ] || [ -f all_in ]
then
#all_in mode
if [ -f all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm Enfuse_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm FFmpeg_"$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchab | awk 'FNR == 1')
then
mv $(cat matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchab)" > matchab
done
#remove all_in list
if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls HDR1.command HDR3.command HDR4.command)
then 
rm all_in
rm LOG.txt
fi
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)  
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchab | awk 'FNR == 1')
then
mv $(cat matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchab)" > matchab
  done
fi
 sleep 2 && rm HDR2.command & rm matchab
clear
echo $(tput bold)"HDR script 2 finished processing"$(tput sgr0)
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi

if [ -f FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat matchab | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchab | awk 'FNR == 1')
then
mv $(cat matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 matchab)" > matchab
#erase 
   rm aligned2*.tif 
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
mkdir -p A_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ] || [ -f all_in ]
then
#set prefix if all_in mode
if [ -f all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2' matchac >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 3 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat matchac | awk 'FNR == 1')
    mv $(cat matchac | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 matchac)" > matchac
  done
#all_in mode
if ! [ -f all_in ]
then
 sleep 2 && rm HDR3.command & rm matchac
clear
echo $(tput bold)"HDR script 3 finished processing"$(tput sgr0)
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
else
rm matchac
mv matchBac matchac
fi
fi

if [ -f enfuse ] || [ -f all_in ]
then
#all_in mode
if [ -f all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm Enfuse_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm FFmpeg_"$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchac | awk 'FNR == 1')
then
mv $(cat matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchac)" > matchac
done
#remove all_in list
if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls HDR2.command HDR1.command HDR4.command)
then 
rm all_in
rm LOG.txt
fi
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)  
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchac | awk 'FNR == 1')
then
mv $(cat matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchac)" > matchac
  done
fi
 sleep 2 && rm HDR3.command & rm matchac
clear
echo $(tput bold)"HDR script 3 finished processing"$(tput sgr0)
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi

if [ -f FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat matchac | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchac | awk 'FNR == 1')
then
mv $(cat matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 matchac)" > matchac
#erase 
   rm aligned3*.tif 
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
mkdir -p A_ORIGINALS

#choose HDR workflow
if [ -f HDRmerge ] || [ -f all_in ]
then
#set prefix if all_in mode
if [ -f all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2' matchad >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 4 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat matchad | awk 'FNR == 1')
    mv $(cat matchad | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 matchad)" > matchad
  done
#all_in mode
if ! [ -f all_in ]
then
 sleep 2 && rm HDR4.command & rm matchad
clear
echo $(tput bold)"HDR script 4 finished processing"$(tput sgr0)
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
else
rm matchad
mv matchBad matchad
fi
fi

if [ -f enfuse ] || [ -f all_in ]
then
#all_in mode
if [ -f all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm Enfuse_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm FFmpeg_"$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchad | awk 'FNR == 1')
then
mv $(cat matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchad)" > matchad
done
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls HDR2.command HDR3.command HDR1.command)
then 
rm all_in
rm LOG.txt
fi
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)  
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchad | awk 'FNR == 1')
then
mv $(cat matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 matchad)" > matchad
  done
fi
 sleep 2 && rm HDR4.command & rm matchad
clear
echo $(tput bold)"HDR script 4 finished processing"$(tput sgr0)
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi

if [ -f FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
   cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
   cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat matchad | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert *.tif 
   rm "$(cat matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat matchad | awk 'FNR == 1')
then
mv $(cat matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 matchad)" > matchad
#erase 
   rm aligned4*.tif 
done
 sleep 2 && rm HDR4.command & rm matchad
clear
echo $(tput bold)"HDR script 4 finished processing"$(tput sgr0)
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi
EOF
