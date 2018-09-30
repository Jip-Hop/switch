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

cat <<'EOF' > /tmp/HDR_match.command
#!/bin/bash

#print Switch path hdr path if doesn´t exist
if ! [ -f /tmp/folder_paths.txt ]; then 
cat /tmp/DUALISO/path_1 > /tmp/folder_paths.txt
fi

cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')"
workingDir=`dirname "$0"`

#not needed
rm LOG.txt

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

#exiftool dependency
if ! [ -f "/usr/local/bin/exiftool" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for exiftool, please wait..."
sleep 2
read -p $(tput bold)"exiftool is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install exiftool
if [ -f "/usr/local/bin/exiftool" ]
then
clear && echo "exiftool is intalled and ready for use"
else
clear && echo "exiftool did not install"
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

#if AE project file included
 if ! ls *.aep >/dev/null 2>&1
 then
#what´s going on
printf '\e[8;6;50t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Let´s group /tmp/matched CR2 files before merging"$(tput sgr0)
sleep 2

while : 
do
 clear
echo $(tput bold)"Still building brackets"$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets.."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets..."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets...."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets....."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets......"$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets......."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets........"$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets........."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
echo $(tput bold)"Still building brackets.........."$(tput sgr0)
[ -f /tmp/match ] && grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF\|CR2\|cr2' <<< $(cat /tmp/match | tail -1) >/dev/null 2>&1 && echo $(cat /tmp/match | tail -1)
sleep 1
 clear
done & pid1=$!
fi

#unified setting. Set time gap
   if [ -f /tmp/time ]
   then 
   gap=$(cat /tmp/time)
   rm /tmp/time
   else
   gap=$(echo 5)
   fi
   
#main loop(all_in)
if [ -f /tmp/all_in ]
then
#start clean
 rm /tmp/list
 rm /tmp/match* 
 rm *preview3.jpg
 mkdir -p A_ORIGINALS
#exiv2 extracts your jpg files embedded in CR2 files
 exiv2 -ep3 -l . *.{cr2,CR2}
#extract metadata info
 exiv2 -e X extract *.{cr2,CR2}
#rename xmp to work as sidecars 
 for i in *.xmp ; do
 mv "$i" "${i/.xmp}"-preview3.xmp
 done
#insert metadata recursively
 exiv2 -i X insert *.jpg 
#We are done, thanks exiv2
 rm *.xmp
#list CR2 files
 ls *.{cr2,CR2} > /tmp/list
#let´s start
while grep 'CR2\|cr2' /tmp/list >/dev/null 2>&1
do
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    if ! [ -f /tmp/match ]
    then
#CR2
    echo -n "$(cat /tmp/list | awk 'FNR == 1')" >> /tmp/match
#jpg
    echo -n "$(cat /tmp/list | awk 'FNR == 1' | cut -d "." -f1)"-preview3.jpg >> /tmp/matchB
    fi
#CR2
    echo -n " $(cat /tmp/list | awk 'FNR == 2')" >> /tmp/match
#jpg
    echo -n " $(cat /tmp/list | awk 'FNR == 2' | cut -d "." -f1)"-preview3.jpg >> /tmp/matchB
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f /tmp/match ]
    then
#CR2
    echo "" >> /tmp/match
#jpg
    echo "" >> /tmp/matchB
    fi
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f /tmp/match ] && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
#CR2
    echo -n $(cat /tmp/list | awk 'FNR == 1') >> /tmp/match
#jpg
    echo -n "$(cat /tmp/list | awk 'FNR == 1' | cut -d "." -f1)"-preview3.jpg >> /tmp/matchB
    fi
done
#end of all_in processing
    rm /tmp/list
fi

#main loop(HDRmerge)
if [ -f /tmp/HDRmerge ]
then
#start clean
 rm /tmp/list
 rm /tmp/match* 
 mkdir -p A_ORIGINALS
 ls *.{cr2,CR2} > /tmp/list
#let´s start
while grep 'CR2\|cr2' /tmp/list >/dev/null 2>&1
do
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    if ! [ -f /tmp/match ]
    then
    echo -n "$(cat /tmp/list | awk 'FNR == 1')" >> /tmp/match
    fi
    echo -n " $(cat /tmp/list | awk 'FNR == 2')" >> /tmp/match
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f /tmp/match ]
    then
    echo "" >> /tmp/match
    fi
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f /tmp/match ] && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    echo -n $(cat /tmp/list | awk 'FNR == 1') >> /tmp/match
    fi
done
#end of HDRmerge processing
    rm /tmp/list
fi

#if AE project file included
 if ls *.aep >/dev/null 2>&1
 then
. "$(cat /tmp/DUALISO/path_2)"/bash/AE.command &
#what´s going on
printf '\e[8;4;35t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"AE processing(might take a while)"$(tput sgr0)
sleep 2
while ls AE_0*.command >/dev/null 2>&1
do 
 clear
echo $(tput bold)"AE processing"$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"AE processing."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"AE processing.."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"AE processing..."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"AE processing...."$(tput sgr0)
sleep 1
 clear
echo $(tput bold)"AE processing....."$(tput sgr0)
sleep 1
 clear
done 

#Bracket info
#what´s going on
printf '\e[8;4;50t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Let´s group /tmp/matched CR2 files before merging"$(tput sgr0)
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
done & pid1=$!
 fi

#main loop(enfuse,FFmpeg)
if [ -f /tmp/enfuse ] || [ -f /tmp/FFmpeg ] 
then
#start clean
 rm /tmp/list
 rm /tmp/match* 
 rm *preview3.jpg
 mkdir -p A_ORIGINALS
#if AE project
 if ! ls *.aep >/dev/null 2>&1
 then
#exiv2 extracts your jpg files embedded in CR2 files
 exiv2 -ep3 -l . *.{cr2,CR2}
#extract metadata info
 exiv2 -e X extract *.{cr2,CR2}
#rename xmp to work as sidecars 
 for i in *.xmp ; do
 mv "$i" "${i/.xmp}"-preview3.xmp
 done
#insert metadata recursively
 exiv2 -i X insert *.jpg 
#We are done, thanks exiv2
 rm *.xmp
 fi
#list jpg,tiff files
 ls *.{jpg,JPG,tif,tiff,TIF,TIFF} > /tmp/list
#let´s start
while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/list >/dev/null 2>&1
do
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#group jpg files accordingly
    while (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    if ! [ -f /tmp/match ]
    then
    echo -n "$(cat /tmp/list | awk 'FNR == 1')" >> /tmp/match
    fi
    echo -n " $(cat /tmp/list | awk 'FNR == 2')" >> /tmp/match
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    done
    if [ -f /tmp/match ]
    then
    echo "" >> /tmp/match
    fi
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
#if not hdr keep shaving
    while ! (( $(echo "$num < $gap" |bc -l) )) && ! (( $(echo "$num < 0" |bc -l) )) && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    do
    echo -n "$(tail -n +2 /tmp/list)" > /tmp/list
    if [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    num1=$(exiftool "$(cat /tmp/list | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num2=$(exiftool "$(cat /tmp/list | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num2" - "$num1" | bc -l)
    fi
    done
#if the first and last file isn´t a hdr file
    if [ -f /tmp/match ] && [ -f "$(cat /tmp/list | awk 'FNR == 2')" ]
    then
    echo -n $(cat /tmp/list | awk 'FNR == 1') >> /tmp/match
    fi
done
rm /tmp/list
mv *.{cr2,CR2} A_ORIGINALS
fi

#when bracketing /tmp/list is done go here
kill -9 $pid1 
sleep 1
clear
echo $(tput bold)"Bracketing done!"$(tput sgr0)
sleep 2

#let´s continue by splitting /tmp/match /tmp/list for multiprocessing purposes
if [ -f /tmp/match ]
then
split -l $(( $( wc -l < /tmp/match ) / 4 + 1 )) /tmp/match /tmp/match
rm /tmp/match
#if all_in mode selected
if [ -f /tmp/all_in ]
then
split -l $(( $( wc -l < /tmp/matchB ) / 4 + 1 )) /tmp/matchB /tmp/matchB
rm /tmp/matchB
fi
fi
#for when the folder starts empty
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ] && ! [ -f /tmp/matchaa ] 
    then
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    else
#remove unwanted subscripts
#set silent mode
    if [ -f /tmp/silent ]
    then
    sleep 5 && rm /tmp/silent &
    mode=$(echo .)
    else
    mode=$(echo open)
    fi
#if we are working with multiple folder paths
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    mode=$(echo .)
    fi
if ! [ -f /tmp/matchaa ]
then
  rm /tmp/HDR1.command
  else
  chmod u=rwx /tmp/HDR1.command
  $mode /tmp/HDR1.command & 
fi

if ! [ -f /tmp/matchab ] 
 then
  rm /tmp/HDR2.command
  else
  chmod u=rwx /tmp/HDR2.command 
  $mode /tmp/HDR2.command & 
fi

if ! [ -f /tmp/matchac ]
 then
  rm /tmp/HDR3.command
  else
  chmod u=rwx /tmp/HDR3.command
  $mode /tmp/HDR3.command &  
fi

if ! [ -f /tmp/matchad ]
 then
  rm /tmp/HDR4.command
  else
  chmod u=rwx /tmp/HDR4.command 
  $mode /tmp/HDR4.command & 
fi
    fi
#remove first command and start HDRmerge processing
sleep 2 && rm /tmp/HDR_match.command & echo -n -e "\033]0;end\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end")' & exit 
EOF

#now build multiprocessing subscripts
#process1
cat <<'EOF' > /tmp/HDR1.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[3;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
#process 1
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"HDRmerge script 1 is working!"$(tput sgr0)
#check for alternate output
if ! [ -d "$(cat /tmp/HDRCR2output)" ]
    then
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchaa | awk 'FNR == 1')
    else
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o "$(cat /tmp/HDRCR2output)"/$pre%iF[0]-%in[-1].dng $(cat /tmp/matchaa | awk 'FNR == 1')
    fi
    echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
    done
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_ORIGINALS
    fi
#check if A_previews is empty and the erase it
    if [ x"$(ls A_previews/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_previews
    fi
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
else
rm /tmp/matchaa
mv /tmp/matchBaa /tmp/matchaa
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
done
#if we are working with multiple folder paths
    if ! [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    rm /tmp/HDR1.command
    rm /tmp/matchaa
    fi
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
then 
rm /tmp/all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)  
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
  done
fi
rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
#erase 
   rm aligned1*.tif 
done
    rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi
EOF

#process2
cat <<'EOF' > /tmp/HDR2.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[5;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchab >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 2 is working!"$(tput sgr0)
#check for alternate output
if ! [ -d "$(cat /tmp/HDRCR2output)" ]
    then
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchab | awk 'FNR == 1')
    else
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o "$(cat /tmp/HDRCR2output)"/$pre%iF[0]-%in[-1].dng $(cat /tmp/matchab | awk 'FNR == 1')
    fi
    echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
    done
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_ORIGINALS
    fi
#check if A_previews is empty and the erase it
    if [ x"$(ls A_previews/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_previews
    fi
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
else
rm /tmp/matchab
mv /tmp/matchBab /tmp/matchab
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchab | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
   rm FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
done
#if we are working with multiple folder paths
    if ! [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    rm /tmp/HDR2.command
    rm /tmp/matchab
    fi
#remove all_in list
if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
then 
rm all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)  
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
  done
fi
rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchab | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
#move original file
   mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
#erase 
   rm aligned2*.tif 
done
    rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi
EOF

#process3
cat <<'EOF' > /tmp/HDR3.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[7;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchac >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 3 is working!"$(tput sgr0)
#check for alternate output
if ! [ -d "$(cat /tmp/HDRCR2output)" ]
    then
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchac | awk 'FNR == 1')
    else
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o "$(cat /tmp/HDRCR2output)"/$pre%iF[0]-%in[-1].dng $(cat /tmp/matchac | awk 'FNR == 1')
    fi
    echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
    done
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_ORIGINALS
    fi
#check if A_previews is empty and the erase it
    if [ x"$(ls A_previews/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_previews
    fi
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
else
rm /tmp/matchac
mv /tmp/matchBac /tmp/matchac
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchac | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
   rm FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
done
#if we are working with multiple folder paths
    if ! [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    rm /tmp/HDR3.command
    rm /tmp/matchac
    fi
#remove all_in list
if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
then 
rm all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)  
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
  done
fi
rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchac | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
#erase 
   rm aligned3*.tif 
done
    rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi
EOF

#process4
cat <<'EOF' > /tmp/HDR4.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[9;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchad >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 4 is working!"$(tput sgr0)
#check for alternate output
if ! [ -d "$(cat /tmp/HDRCR2output)" ]
    then
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchad | awk 'FNR == 1')
    else
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o "$(cat /tmp/HDRCR2output)"/$pre%iF[0]-%in[-1].dng $(cat /tmp/matchad | awk 'FNR == 1')
    fi
    echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
    done
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_ORIGINALS
    fi
#check if A_previews is empty and the erase it
    if [ x"$(ls A_previews/*)" = x ] && ! [ -f /tmp/all_in ]
    then
    rm -r A_previews
    fi
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
else
rm /tmp/matchad
mv /tmp/matchBad /tmp/matchad
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchad | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
   rm FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
done
#if we are working with multiple folder paths
    if ! [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    rm /tmp/HDR4.command
    fi
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
then 
rm all_in
fi
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)  
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
  done
fi
rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchad | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
#erase 
   rm aligned4*.tif 
done
    rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi
EOF
