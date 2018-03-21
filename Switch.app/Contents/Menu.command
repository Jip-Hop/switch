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
 # Free Software Foundation, Inc,
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.


#check for sd or cf card
#Check if filmed crop_rec
#menu RAW_demolish settings
#RAW pixel fix
#new output folder
#Main menu
#DUALISO_CR2
#HDR processing
#mlv_dump
#mlv_dump_on_steroids
#ProRes output
#AE_question
#tif spit raw to tif
#X to ProRes
#tif spit X to tif

export PATH="$(cat /tmp/DUALISO/"path_2")":$PATH

#default to mlv_dump_on_steroids
    if ! [ -f /tmp/mlv_dump_on_steroids_settings ]
    then
    echo > /tmp/mlv_dump_on_steroids_settings
    fi

#check for sd or cf card
if ! [ -f /tmp/DUALISO/CF_set ]
then
if [ -d /Volumes/EOS_*/DCIM/ ]
then 
echo > /tmp/DUALISO/CF_set
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;6;60t'
printf '\e[3;410;100t'

open -a Terminal

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

clear
echo "

${bold}$(tput setaf 2)Seems we have a CF or SD card attached, please wait$(tput sgr0)"
sleep 3


#printf '\e[3;0;0t'
printf '\e[8;28;95t'
printf '\e[3;410;100t'


while :
do 

    clear
    cat<<EOF
    ====================  
    ${bold}$(tput setaf 1)Copy files to folder$(tput sgr0)
    --------------------

$(tput bold)input folder: $(tput setaf 4)$(cat /tmp/DUALISO/"path_1")/$(tput sgr0)
 
    $(tput bold)(01) Copy all content from card(CF/SD) to selected folder$(tput sgr0)(MLV,RAW,CR2,MOV,DNG,etc)	
    $(tput bold)(1X) Copy all content from CF/SD to selected folder then DELETE files from CF/SD card			 
    $(tput bold)(02) $(tput sgr0)Copy only $(tput bold)MLV and RAW $(tput sgr0)to selected folder
    $(tput bold)(03) $(tput sgr0)Copy only $(tput bold)DNG $(tput sgr0)to selected folder	
    $(tput bold)(04) $(tput sgr0)Copy only $(tput bold)MOV $(tput sgr0)to selected folder
    $(tput bold)(05) $(tput sgr0)Copy only $(tput bold)CR2 $(tput sgr0)to selected folder
    $(tput bold)(06) $(tput sgr0)Copy only $(tput bold)JPG $(tput sgr0)to selected folder
    $(tput bold)(ML) $(tput sgr0)$(tput bold)DELETE$(tput sgr0) MLV files from CF/SD card$(tput bold)
    $(tput bold)(MO) $(tput sgr0)$(tput bold)DELETE$(tput sgr0) MOV files from CF/SD card$(tput bold)
    $(tput bold)(DN) $(tput sgr0)$(tput bold)DELETE$(tput sgr0) DNG files from CF/SD card$(tput bold)
    $(tput bold)(CR) $(tput sgr0)$(tput bold)DELETE$(tput sgr0) CR2 files from CF/SD card$(tput bold)
    $(tput bold)(JP) $(tput sgr0)$(tput bold)DELETE$(tput sgr0) JPG files from CF/SD card$(tput bold)
    $(tput bold)$(tput setaf 1)(mp) MlRawViewer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(op) Open CF/SD folder$(tput sgr0)
    $(tput bold)$(tput setaf 1)(EJ) Eject SD/CF card$(tput sgr0)
    $(tput bold)$(tput setaf 1)(Xx) DELETE all files from CF/SD card$(tput bold)
    $(tput bold)$(tput setaf 1)(m)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  Exit Switch$(tput sgr0)

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "01")  
echo > /tmp/DUALISO/COPY1
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command &
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "1X")  
clear
read -p $(tput bold)"Are you sure about this?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo > /tmp/DUALISO/COPY2
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying to selected folder then DELETING files from CF card"$(tput sgr0) ; sleep 3
. "$(cat /tmp/DUALISO/path_2)"Menu.command
else
rm /tmp/DUALISO/CF_set
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
;;

    "02")  
echo > /tmp/DUALISO/COPY3
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying MLV and RAW..."$(tput sgr0) ; sleep 2
;;

    "03")  
echo > /tmp/DUALISO/COPY4
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying DNG..."$(tput sgr0) ; sleep 2
;;

   "04")  
echo > /tmp/DUALISO/COPY5
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying MOV..."$(tput sgr0) ; sleep 2
;;

   "05") 
echo > /tmp/DUALISO/COPY6
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command & 
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying CR2..."$(tput sgr0) ; sleep 2
;;

   "06") 
echo > /tmp/DUALISO/COPY7
open "$(cat /tmp/DUALISO/path_2)"progress_bar_CF_SD.command & 
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Copying JPG..."$(tput sgr0) ; sleep 2
;;

   "ML")
clear
read -p $(tput bold)"Are you sure about deleting?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then  
find /Volumes/EOS_*/DCIM -name "*.MLV" -type f -delete &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
DELETING MLV files from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

   "MO") 
clear
read -p $(tput bold)"Are you sure about deleting?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then 
find /Volumes/EOS_*/DCIM -name "*.MOV" -type f -delete &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
DELETING MOV files from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

   "DNG")  
clear
read -p $(tput bold)"Are you sure about deleting?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then 
find /Volumes/EOS_*/DCIM -name "*.DNG" -type f -delete &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
DELETING DNG files from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

   "CR")  
clear
read -p $(tput bold)"Are you sure about deleting?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then 
find /Volumes/EOS_*/DCIM -name "*.CR2" -type f -delete &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
DELETING CR2 files from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

   "JP")  
clear
read -p $(tput bold)"Are you sure about deleting?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then 
find /Volumes/EOS_*/DCIM -name "*.JPG" -type f -delete &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
DELETING JPG files from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

   "Xx")  
clear
read -p $(tput bold)"This action will DELETE all files on your CF/SD folder$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
find /Volumes/EOS_*/DCIM -type f -exec rm -f {} \; &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
All files DELETED from SD/CF card..."$(tput sgr0) ; sleep 2
fi
;;

    "mp")
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer.app/Contents/MacOS/mlrawviewer "$(find /Volumes/EOS_*/DCIM -name "*.MLV" | head -1)" & sleep 2
find /Volumes/EOS_*/DCIM -name "*.WAV" -type f -delete 
find /Volumes/EOS_*/DCIM -name "*.MRX" -type f -delete 
while [ -n "$(pgrep mlrawviewer </dev/null)" ];
do sleep 1
done
find /Volumes/EOS_*/DCIM -name "*.WAV" -type f -delete 
find /Volumes/EOS_*/DCIM -name "*.MRX" -type f -delete 
;;

   "m")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

   "op")  
open "$(find /Volumes/EOS_*/DCIM -type f | head -1 | cut -d "/" -f1,2,3,4,5)"
;;

   "EJ")  
hdiutil eject /Volumes/EOS_*
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
fi
fi


#Check if filmed crop_rec
if ls /tmp/DUALISO/crop_rec?
then
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;16;95t'
printf '\e[3;410;100t'

open -a Terminal

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    ================	  
    ${bold}$(tput setaf 1)crop_rec footage$(tput sgr0)
    ----------------
 
    $(tput bold)(01) crop_rec footage?$(tput sgr0)(Cropmode 3x3 720p)				 
    $(tput bold)(02) this is not crop_rec footage$(tput sgr0) 

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "01")  
rm /tmp/DUALISO/crop_rec?
echo > /tmp/DUALISO/crop_rec
cp -r "$(cat /tmp/DUALISO/"path_2")"mlvfs/crop_rec/crop80000331_1808x727.fpm "$(cat /tmp/DUALISO/"path_2")"mlvfs/80000331_1808x727.fpm
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
crop_rec footage"$(tput sgr0) ; sleep 1
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "02")  
rm /tmp/DUALISO/crop_rec?
cp -r "$(cat /tmp/DUALISO/"path_2")"mlvfs/crop_rec/80000331_1808x727.fpm "$(cat /tmp/DUALISO/"path_2")"mlvfs/80000331_1808x727.fpm
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
not crop_rec footage"$(tput sgr0) ; sleep 1
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
fi



#menu RAW_demolish settings
if ls /tmp/DUALISO/RAW_demolish
then
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;20;95t'
printf '\e[3;410;100t'

open -a Terminal

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}$(tput setaf 1)RAW processing options$(tput sgr0)(thanks to bouncyball)
    ------------------------------
 
    $(tput bold)(01)$(tput sgr0) Convert legacy RAW to MLV(same folder output)	
    $(tput bold)(02)$(tput sgr0) Specify output location for MLV files			 
    $(tput bold)(03)$(tput sgr0) Process RAW to dng (without creation of MLV files)  


    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "01")  
echo 01_legacy_RAW_to_MLV > /tmp/DUALISO/RAW
rm /tmp/DUALISO/RAW_demolish
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
MLV files will be created"$(tput sgr0) ; sleep 3  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "02")
echo 01_legacy_RAW_to_MLV > /tmp/DUALISO/RAW
echo > /tmp/DUALISO/RAW_OUTPUT
open "$(cat /tmp/DUALISO/path_2)"new_output.app
clear
echo $(tput bold)"


Choose MLV output path"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
;;


    "03")  
echo 02_Process_RAW_to_dng > /tmp/DUALISO/RAW
rm /tmp/DUALISO/RAW_demolish 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")  echo $(tput bold)$(tput setaf 1)"

Nothing was selected"$(tput sgr0) ; sleep 3 ; rm /tmp/DUALISO/RAW_demolish ; rm /tmp/DUALISO/RAW ; osascript -e 'tell application "Terminal" to close first window' & exit ;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
exit 0
fi


#RAW pixel fix 
if ls /tmp/DUALISO/what_cam_lock
then
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;47;65t'
printf '\e[3;810;0t'

open -a Terminal

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

Mod=$(cat /tmp/DUALISO/MOD)
rm /tmp/DUALISO/MOD
fpss=$(cat /tmp/DUALISO/fpss)
rm /tmp/DUALISO/fpss
fs=$(cat /tmp/DUALISO/image_size)
rm /tmp/DUALISO/def_scal

while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}What camera and video mode are you using?$(tput sgr0)
    ------------------------------
    $(tput bold)$(tput setaf 1)Please enter your camera model to add correct meta data 
    to your dng files.$(tput sgr0)
 	

    $(tput bold)$(tput smul)mv1080$(tput sgr0)       					
    $(tput bold)(01)$(tput sgr0) Canon EOS 650D		        					
    $(tput bold)(02)$(tput sgr0) Canon EOS 700D
    $(tput bold)(03)$(tput sgr0) Canon EOS 100D			       					     $(tput bold)(04)$(tput sgr0) Canon EOS 6D (video mode not affected)		   			
    $(tput bold)(05)$(tput sgr0) Canon EOS 70D (video mode not affected)	$(tput sgr0)

    $(tput bold)$(tput smul)mv720$(tput sgr0)       				
    $(tput bold)(06)$(tput sgr0) Canon EOS M		
    $(tput bold)(07)$(tput sgr0) Canon EOS 650D		        					
    $(tput bold)(08)$(tput sgr0) Canon EOS 700D
    $(tput bold)(09)$(tput sgr0) Canon EOS 100D$(tput sgr0)

    $(tput bold)$(tput smul)mv1080crop$(tput sgr0)       				
    $(tput bold)(10)$(tput sgr0) Canon EOS M		
    $(tput bold)(11)$(tput sgr0) Canon EOS 650D		        					
    $(tput bold)(12)$(tput sgr0) Canon EOS 700D
    $(tput bold)(13)$(tput sgr0) Canon EOS 100D$(tput sgr0)

    $(tput bold)$(tput smul)zoom(centre spot recommended)$(tput sgr0)       				
    $(tput bold)(14)$(tput sgr0) Canon EOS M		
    $(tput bold)(15)$(tput sgr0) Canon EOS 650D		        					
    $(tput bold)(16)$(tput sgr0) Canon EOS 700D
    $(tput bold)(17)$(tput sgr0) Canon EOS 100D$(tput sgr0)

    $(tput bold)Camera model $(tput setaf 4)$Mod$(tput sgr0)
    $(tput bold)Video size   $(tput setaf 4)$fs$(tput sgr0)
    $(tput bold)FPS$(tput setaf 1)          $(tput setaf 4)$fpss$(tput sgr0)    
    $(tput bold)$(tput setaf 1)    
    (q)  I don,t care about meta data please exit$(tput sgr0)				       

   
Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in
     
    "01")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 650D > /tmp/DUALISO/this_cam 
echo mv1080 > /tmp/DUALISO/mode
echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 650D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  

osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "02")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 700D > /tmp/DUALISO/this_cam 
echo mv1080 > /tmp/DUALISO/mode
echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 700D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1 
 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "03") 
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 100D > /tmp/DUALISO/this_cam 
echo mv1080 > /tmp/DUALISO/mode
echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 100D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  

osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "04")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 6D > /tmp/DUALISO/this_cam 

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 6D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "05") 
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 70D > /tmp/DUALISO/this_cam 

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 70D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "06")
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS M > /tmp/DUALISO/this_cam 
echo mv720 > /tmp/DUALISO/mode
printf "%s\n" -M"set Exif.SubImage1.DefaultScale Rational 1/1 5/3" > /tmp/DUALISO/def_scal

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS M"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;
 
    "07")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 650D > /tmp/DUALISO/this_cam 
echo mv720 > /tmp/DUALISO/mode
printf "%s\n" -M"set Exif.SubImage1.DefaultScale Rational 1/1 5/3" > /tmp/DUALISO/def_scal

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 650D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "08")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 700D > /tmp/DUALISO/this_cam 
echo mv720 > /tmp/DUALISO/mode
printf "%s\n" -M"set Exif.SubImage1.DefaultScale Rational 1/1 5/3" > /tmp/DUALISO/def_scal

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 700D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "09") 
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 100D > /tmp/DUALISO/this_cam 
echo mv720 > /tmp/DUALISO/mode
printf "%s\n" -M"set Exif.SubImage1.DefaultScale Rational 1/1 5/3" > /tmp/DUALISO/def_scal

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 100D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "10")
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS M > /tmp/DUALISO/this_cam 
echo mv1080crop > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS M"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;
 
    "11")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 650D > /tmp/DUALISO/this_cam 
echo mv1080crop > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 650D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "12")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 700D > /tmp/DUALISO/this_cam 
echo mv1080crop > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 700D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "13") 
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 100D > /tmp/DUALISO/this_cam 
echo mv1080crop > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 100D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "14")
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS M > /tmp/DUALISO/this_cam 
echo zoom > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS M"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "15")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 650D > /tmp/DUALISO/this_cam 
echo zoom > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 650D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "16")  
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 700D > /tmp/DUALISO/this_cam 
echo zoom > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 700D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "17") 
rm /tmp/DUALISO/this_cam 1> /dev/null 2>&1
echo Canon EOS 100D > /tmp/DUALISO/this_cam 
echo zoom > /tmp/DUALISO/mode

echo $(tput bold)$(tput setaf 1)"

You,ve chosen Canon EOS 100D"$(tput sgr0) ; sleep 2
rm /tmp/DUALISO/what_cam_lock 1> /dev/null 2>&1  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")  echo $(tput bold)$(tput setaf 1)"

Frames per second and white balance meta data will still be added"$(tput sgr0) ; sleep 3 ; rm /tmp/DUALISO/what_cam_lock ; osascript -e 'tell application "Terminal" to close first window' & exit ;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
exit 0
fi


#Main menu
#remove destructive switch
if [ -f /tmp/DUALISO/DEL_DNG ]
then
rm /tmp/DUALISO/DEL_DNG
fi

if ls /tmp/DUALISO/DUALISO
then
#!/bin/bash
#new output folder
if ! ls /tmp/DUALISO/O_trap
then
if ls /tmp/output
then
echo > /tmp/DUALISO/O_trap
mkdir -p "$(cat /tmp/output)"
out=$(cat /tmp/"output")
bold="$(tput bold)"
normal="$(tput sgr0)"
blue="$(tput setaf 4)"
green="$(tput setaf 2)"
clear
echo "

"$(tput bold)"your current output folder is "$(tput setaf 4)"$(cat /tmp/output)""$(tput sgr0)"
sleep 2
else
out=
fi
fi

#afplayer

if ls /tmp/afplay_path
then
bold="$(tput bold)"
normal="$(tput sgr0)"
blue="$(tput setaf 4)"
green="$(tput setaf 2)"
mkdir -p "$(cat /tmp/afplay_path)"
shuf=$(cat /tmp/"afplay_path")
afplay=$(echo "$bold""$green"added!"$normal")

if ! ls /tmp/DUALISO/afplayON
then

#trap
  if ! [ `ls -1 $(cat /tmp/"afplay_path")/list* 2>/dev/null | wc -l ` -gt 0 ];
  then
    if ! [ -n "$(pgrep afplay </dev/null)" ];
    then
open "$(cat /tmp/DUALISO/path_2)"afplayer.command &
    fi
  fi
fi
else
shuf=
afplay=
fi

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;37;60t'
printf '\e[3;450;0t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

FLAT= ; DARK= ; darkfr_storage= ; cr2hdr_a= ; mlv_dump_a= ; X_pro_a= ; pro_a= ; THREADS= ; HDR=

if ls /tmp/DUALISO/FLATFRAMES
then
FLAT=$(echo "$bold""$green"added!"$normal")
fi
if ls /tmp/DARK
then
DARK=$(echo "$bold""$green"added!"$normal")
fi
if ls /tmp/DARK_FOLDER
then
if ls "$(cat /tmp/DARK_FOLDER)"
then
DARK=$(echo "$bold""$green"Storage_added!"$normal")
darkfr_storage=$(cat /tmp/"DARK_FOLDER")
else
rm /tmp/DARK_FOLDER
DARK=
darkfr_storage=
fi
fi
if ls /tmp/DUALISO/FLATFRAME_A
then
FLAT=$(echo "$bold""$green"added!"$normal")
fi

if ls /tmp/DUALISO/FULL_AUTO
then
auto=$(echo "$bold""$green"auto mode!"$normal")
if ls /tmp/A_cr2hdr_settings.txt
then
cr2hdr_a=$(echo "$bold""$green"auto mode!"$normal")
fi
mlv_dump_a=$(echo "$bold""$green"auto mode!"$normal")
if ls /tmp/FFmpeg_settings*
then
pro_a=$(echo "$bold""$green"auto mode!"$normal")
fi
if ls /tmp/_X_Pro*
then
X_pro_a=$(echo "$bold""$green"auto mode!"$normal")
fi
if ls /tmp/DARK
then
DARK=$(echo "$bold""$green"auto mode!"$normal")
fi
fi
if [ -f /tmp/THREADS ]
then
THREADS=$(cat /tmp/THREADS)
fi
if [ -f /tmp/HDRCR2 ]
then 
HDR=$(echo "$bold""$green"HDR_CR2_added!"$normal")
fi
#if mov is added
if ls /tmp/_X_Pro* >/dev/null 2>&1
then
X_pro_a=$(echo "$bold""$green"added"$normal")
fi
#if prores is added
if ls /tmp/FFmpeg_settings* >/dev/null 2>&1
then
pro_a=$(echo "$bold""$green"added"$normal")
fi


#set your output folder
    if ! [ x"$(cat /tmp/"output")" = x ]
    then
out=$(cat /tmp/"output")/
    else
out=$(cat /tmp/DUALISO/"path_1")/
    fi

#but what if prores folders are empty? Let´s erase them since they will only annoyit
#prores files MOV etc
    if [ x"$(ls "$out"$(date +%F)_X_ProRes4444/*)" = x ]
    then
    rm -r "$out"$(date +%F)_X_ProRes4444/
    fi
#proxy folder
    if [ x"$(ls "$out"$(date +%F)_X_Proxy/*)" = x ]
    then
    rm -r "$out"$(date +%F)_X_Proxy/
    fi
#prores output dng files
    if [ x"$(ls "$out"$(date +%F)_ProRes4444/*)" = x ]
    then
    rm -r "$out"$(date +%F)_ProRes4444/
    fi
#proxy folder
    if [ x"$(ls "$out"$(date +%F)_Proxy/*)" = x ]
    then
    rm -r "$out"$(date +%F)_Proxy/
    fi

#Mlv App path
if [ -f "$(cat /tmp/mlvapp)"/Contents/MacOS/MLV\ App ]
then
mlvapp=$(cat /tmp/mlvapp)
else
mlvapp=
fi

while :
do 

    clear
    cat<<EOF
    =========
    ${bold}Main menu$(tput sgr0)
    ---------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)
$(tput bold)Mlv App:$(tput setaf 2)$mlvapp$(tput sgr0)
$(tput bold)darkframe storage:$(tput setaf 4)$darkfr_storage$(tput sgr0)
$(tput bold)afplayer: $(tput setaf 4)$shuf$(tput sgr0)

    $(tput bold)$(tput setaf 1)(ms) mlv_dump_on_steroids$(tput sgr0)(default)$(tput bold)(MLV)$(tput sgr0)
    $(tput bold)$(tput setaf 1)(m)  mlv_dump$(tput sgr0)$(tput bold)(MLV)$(tput sgr0) $mlv_dump_a
    $(tput bold)$(tput setaf 1)(p)  ProRes output$(tput sgr0)$(tput bold)(MLV,RAW,dng)$(tput sgr0) $pro_a
    $(tput bold)$(tput setaf 1)(o)  X to ProRes$(tput sgr0)$(tput bold)(mov,mts etc)$(tput sgr0) $X_pro_a
    $(tput bold)$(tput setaf 1)(d)  cr2hdr dualiso processing$(tput sgr0)$(tput bold)(CR2)$(tput sgr0) $cr2hdr_a
    $(tput bold)$(tput setaf 1)(h)  HDR processing$(tput sgr0)$(tput bold)(CR2)$(tput sgr0) $HDR
    $(tput bold)$(tput setaf 1)(ma) Mlv app workflow$(tput sgr0)(Ilia3101,masc,bouncyball)
    $(tput bold)$(tput setaf 1)(ml) MLVFS workflow$(tput sgr0)
    $(tput bold)$(tput setaf 1)(b)  bash section$(tput sgr0)

    $(tput bold)$(tput setaf 1)(C)  select new output folder$(tput sgr0)$(tput bold)(MLV,RAW,dng,mov)$(tput sgr0)
    $(tput bold)$(tput setaf 1)(CP) set running threads manually(max 4)$(tput sgr0)$(tput bold)$(tput setaf 4) $THREADS
    $(tput bold)$(tput setaf 1)(O)  open up your working folder list$(tput sgr0)
    $(tput bold)$(tput setaf 1)(R)  reset Switch to defaults$(tput sgr0)
    $(tput bold)$(tput setaf 1)(A)  darkframe average automation$(tput sgr0)$(tput bold)$(tput sgr0) $DARK
    $(tput bold)$(tput setaf 1)(F)  flatframe average automation$(tput sgr0)$(tput bold)$(tput sgr0) $FLAT
    $(tput bold)$(tput setaf 1)(a)  full auto mode$(tput sgr0) $auto
    $(tput bold)$(tput setaf 1)(pl) afplay$(tput sgr0) $(tput bold)$afplay$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(DB) run Switch in debug mode$(tput sgr0)
    $(tput bold)$(tput setaf 1)(to) useful scripts(toolbox)$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)   

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in



    "d")
#DUALISO_CR2

#Erase full auto setting
if ls /tmp/DUALISO/FULL_AUTO
then
if ls /tmp/A_cr2hdr_settings.txt
then
cr2hdr_a=
rm /tmp/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm /tmp/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm /tmp/cpuboost 1> /dev/null 2>&1 &
clear 
echo "$(tput setaf 1)""Erased cr2hdr auto settings"
sleep 1
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
fi

echo > /tmp/cpuboost

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;38;50t'
printf '\e[3;410;0t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

if grep 'amaze' /tmp/A_cr2hdr_settings.txt 
then 
amaze=$(echo "$bold""$green"added!"$normal")
fi
if grep 'mean' /tmp/A_cr2hdr_settings.txt 
then 
mean=$(echo "$bold""$green"added!"$normal")
fi
if grep 'force' /tmp/A_cr2hdr_settings.txt 
then 
force=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2x2' /tmp/A_cr2hdr_settings.txt 
then 
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3x3' /tmp/A_cr2hdr_settings.txt 
then 
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5x5' /tmp/A_cr2hdr_settings.txt 
then 
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-cs' /tmp/A_cr2hdr_settings.txt 
then 
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'levels' /tmp/A_cr2hdr_settings.txt 
then 
salev=$(echo "$bold""$green"added!"$normal")
fi
if grep 'compress' /tmp/A_cr2hdr_cmpr.txt 
then 
lole=$(echo "$bold""$green"added!"$normal")
fi
if grep 'compress-lossy' /tmp/A_cr2hdr_cmpr.txt 
then 
lossy=$(echo "$bold""$green"added!"$normal")
lole=
fi
if ls /tmp/cpuboost
then 
cpu=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    ===============
    ${bold}$(tput setaf 1)cr2hdr settings$(tput sgr0)
    ---------------
${bold}note! Reenter selection to erase!

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)

${bold}Interpolation methods$(tput sgr0)
    $(tput bold)(a)$(tput sgr0) Amaze edge(default) $amaze			 
    $(tput bold)(m)$(tput sgr0) Mean23(faster) $mean  
    $(tput bold)(f)$(tput sgr0) Force dualiso processing $force

${bold}Chroma smoothing$(tput sgr0)
    $(tput bold)(2)$(tput sgr0) apply 2x2(default) $cs2				 
    $(tput bold)(3)$(tput sgr0) apply 3x3 $cs3
    $(tput bold)(5)$(tput sgr0) apply 5x5 $cs5				 
    $(tput bold)(di)$(tput sgr0) disable chroma smoothing $nocs

${bold}Flicker handling$(tput sgr0)
    $(tput bold)(s)$(tput sgr0) same-levels(avoid flicker) $salev  

${bold}DNG compression$(tput sgr0)(requires Adobe DNG Converter) 
    $(tput bold)(l)$(tput sgr0) lossless $lole
    $(tput bold)(k)$(tput sgr0) lossy $lossy

${bold}Speed increase$(tput sgr0)
    $(tput bold)(B)$(tput sgr0) CPU boost $cpu

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(d)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "a")
if grep 'amaze' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --amaze-edge//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--amaze-edge//g'
amaze=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --amaze-edge" >> /tmp/A_cr2hdr_settings.txt
amaze=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --mean23//g' 
mean=
fi
;;

    "m")
if grep 'mean' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --mean23//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--mean23//g'
mean=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --mean23" >> /tmp/A_cr2hdr_settings.txt
mean=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --amaze-edge//g' 
amaze=
fi
;;

    "f")
if grep 'force' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --force//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--force//g'
force=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --force" >> /tmp/A_cr2hdr_settings.txt
force=$(echo "$bold""$green"added!"$normal")
fi
;;

    "2")
if grep 'cs2x2' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs2x2//g'
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs2x2" >> /tmp/A_cr2hdr_settings.txt
cs2=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g' 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs3=
cs5=
fi
;;

    "3")
if grep 'cs3x3' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs3x3//g'
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs3x3" >> /tmp/A_cr2hdr_settings.txt
cs3=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs2=
cs5=
fi
;;

    "5")
if grep 'cs5x5' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs5x5//g'
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs5x5" >> /tmp/A_cr2hdr_settings.txt
cs5=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs2=
cs3=
fi
;;

    "di")
if grep 'no-cs' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--no-cs//g'
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --no-cs" >> /tmp/A_cr2hdr_settings.txt
nocs=$(echo "$bold""$green"added!"$normal")
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "s")
if grep 'levels' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --same-levels//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--same-levels//g'
salev=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --same-levels" >> /tmp/A_cr2hdr_settings.txt
salev=$(echo "$bold""$green"added!"$normal")
fi
;;
   
    "l")
if grep 'compress-lossy' /tmp/A_cr2hdr_cmpr.txt 
then 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/ --compress-lossy//g'
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/--compress-lossy//g'
fi
if grep 'compress' /tmp/A_cr2hdr_cmpr.txt 
then 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/ --compress//g'
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/--compress//g'
lole=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/ --compress-lossy//g'
echo -n " --compress" >> /tmp/A_cr2hdr_cmpr.txt
lole=$(echo "$bold""$green"added!"$normal")
lossy=
fi
;;
 
    "k")
if grep 'compress-lossy' /tmp/A_cr2hdr_cmpr.txt 
then 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/ --compress-lossy//g'
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/--compress-lossy//g'
if grep 'lossy' /tmp/A_cr2hdr_cmpr.txt 
then 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/-lossy//g'
fi
lossy=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/A_cr2hdr_cmpr.txt | xargs perl -pi -e 's/ --compress//g'
echo -n " --compress-lossy" >> /tmp/A_cr2hdr_cmpr.txt
lossy=$(echo "$bold""$green"added!"$normal")
lole=
fi
;;

    "B")
if ls /tmp/cpuboost 
then 
rm /tmp/cpuboost
cpu=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > /tmp/cpuboost
cpu=$(echo "$bold""$green"added!"$normal")
fi
;;

    "E")
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy= ; out= ; force=
rm /tmp/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm /tmp/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm /tmp/cpuboost 1> /dev/null 2>&1 &
rm /tmp/DUALISO/O_trap 1> /dev/null 2>&1 &
;;

    "d")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")  
perl -pi -e 's/^[\ \t]+|[\ \t]+$//g' /tmp/A_cr2hdr_settings.txt
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

#HDR processing
    "h")
#identifier
if ! [ -f /tmp/HDRCR2 ]
then 
    echo > /tmp/HDRCR2
else
rm /tmp/HDRCR2
HDR=
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi


if ! [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
then
clear
echo $(tput bold)"
Checking for HDRMerge, please wait..."
sleep 2
read -p $(tput bold)"
HDRMerge is not installed would you like to install it?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
[ ! -f "`which wget`" ] && brew install wget
wget -O HDRMerge.dmg https://github.com/jcelaya/hdrmerge/releases/download/v0.5.0/HDRMerge.dmg && hdiutil attach HDRMerge.dmg && cp -r /Volumes/HDRMerge\ for\ Mac/HDRMerge.app /Applications && hdiutil eject /Volumes/HDRMerge\ for\ Mac && rm HDRMerge.dmg
if [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
then
clear && echo "HDRMerge is intalled and ready for use"
else
clear && echo "HDRMerge did not install, please check terminal window for any error or install manually"
fi
sleep 2
else
clear && echo "
Please install HDRMerge manually"
sleep 2
fi
fi




#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;32;76t'
printf '\e[3;410;0t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

b24= ; b32= ; na= ; nc= ; gap= ; blur= ; HDROUT= ; CR2OUT=


if grep ' \-b 24' /tmp/HDRCR2_settings 
then
b24=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-b 32' /tmp/HDRCR2_settings 
then
b32=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \--no-align' /tmp/HDRCR2_settings 
then
na=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \--no-crop' /tmp/HDRCR2_settings 
then
nc=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-g' /tmp/HDRCR2_settings 
then
gap=$(tput bold)$(tput setaf 4)$(grep ' \-g' /tmp/HDRCR2_settings | tr -d " \-g")sec$(tput sgr0)
fi
if grep ' \-r' /tmp/HDRCR2_settings 
then
blur="$(tput bold)$(tput setaf 4)$(grep ' \-r' /tmp/HDRCR2_settings | tr -d " \-r") pixels$(tput sgr0)"
fi
if [ -d "$(cat /tmp/HDRCR2output)" ]
then
CR2OUT=$(cat /tmp/"HDRCR2output"); 
HDROUT=$(echo "$bold""$green"added!"$normal");
fi 

while :
do 

    clear
    cat<<EOF
    ==================
    ${bold}$(tput setaf 1)HDR automation$(tput sgr0)(CR2)
    ------------------
(install into /Applications folder):
${bold}https://github.com/jcelaya/hdrmerge/releases/download/v0.5.0/HDRMerge.dmg 
$(if [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ] 
then 
echo $blue"HDRMerge is installed"$normal 
else 
echo $red"HDRMerge is NOT installed"$normal 
fi)

$(tput bold)output: $(tput setaf 4)$CR2OUT$(tput sgr0)

    $(tput bold)(t)$(tput sgr0)  specify time gap(default 10sec) $gap
    $(tput bold)(24)$(tput sgr0) output to 24bit(default 16bit) $b24
    $(tput bold)(32)$(tput sgr0) output to 32bit(default 16bit) $b32
    $(tput bold)(bl)$(tput sgr0) mask blur radius between images(default 3 pixels) $blur
    $(tput bold)(na)$(tput sgr0) no aligning $na
    $(tput bold)(nc)$(tput sgr0) no cropping $nc
    $(tput bold)(O)$(tput sgr0)  select a new output folder for your dng files $HDROUT

${bold}Fast button$(tput sgr0)(starts immediately)$(tput sgr0)
    $(tput bold)(s)$(tput sgr0)  run HDRmerge(defaults,16bit,10sec/gap if nothing else selected)
 			 
    $(tput bold)$(tput setaf 1)(ho) how does it work$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(h)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)  
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)
					        					

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "t")
if grep ' \-g' /tmp/HDRCR2_settings 
then
echo "removing"
perl -pi -e 's/'"$(grep ' \-g' /tmp/HDRCR2_settings)"'//g' /tmp/HDRCR2_settings
gap=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify time gap:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 12 and hit enter)"
read input_variable
echo "time gap is set to: $(tput bold)$(tput setaf 4)$input_variable sec"$(tput sgr0)
printf "%s\n" " -g $input_variable" >> /tmp/HDRCR2_settings
gap=$(tput bold)$(tput setaf 4)$(grep ' \-g' /tmp/HDRCR2_settings | tr -d " \-g")sec$(tput sgr0)
fi
printf '\e[8;32;76t'
printf '\e[3;410;0t'
;;

    "24")
if grep ' \-b 24' /tmp/HDRCR2_settings 
then
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ -b 24//g' 
b24=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -b 24" >> /tmp/HDRCR2_settings
b24=$(echo "$bold""$green"added!"$normal")
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ -b 32//g'
b32=
fi
;;

    "32")
if grep ' \-b 32' /tmp/HDRCR2_settings 
then
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ -b 32//g' 
b32=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -b 32" >> /tmp/HDRCR2_settings
b32=$(echo "$bold""$green"added!"$normal")
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ -b 24//g'
b24=
fi
;;

    "bl")
if grep ' \-r' /tmp/HDRCR2_settings 
then
echo "removing"
perl -pi -e 's/'"$(grep ' \-r' /tmp/HDRCR2_settings)"'//g' /tmp/HDRCR2_settings
blur=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify radius blur:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 15 and hit enter)"
read input_variable
echo "radius blur set to: $(tput bold)$(tput setaf 4)$input_variable pixels"$(tput sgr0)
printf "%s\n" " -r $input_variable" >> /tmp/HDRCR2_settings
blur="$(tput bold)$(tput setaf 4)$(grep ' \-r' /tmp/HDRCR2_settings | tr -d " \-r") pixels$(tput sgr0)"
fi
printf '\e[8;32;76t'
printf '\e[3;410;0t'
;;

    "na")
if grep ' \--no-align' /tmp/HDRCR2_settings 
then
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ --no-align//g' 
na=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-align" >> /tmp/HDRCR2_settings
na=$(echo "$bold""$green"added!"$normal")
fi
;;

    "nc")
if grep ' \--no-crop' /tmp/HDRCR2_settings 
then
find /tmp/HDRCR2_settings | xargs perl -pi -e 's/ --no-crop//g' 
nc=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-crop" >> /tmp/HDRCR2_settings
nc=$(echo "$bold""$green"added!"$normal")
fi
;;

    "O")
if [ -f /tmp/HDRCR2output ]
then
rm /tmp/HDRCR2output
HDROUT=
CR2OUT=
else
echo > /tmp/HDRCR2OUT
open "$(cat /tmp/DUALISO/path_2)"new_output.app
printf '\e[8;10;50t'
printf '\e[3;410;0t'
clear
echo "


$(tput bold)Select an output folder"
sleep 2

#trap
    while ls /tmp/HDRCR2OUT &>/dev/null
    do
    sleep 0.3
    done
clear &
echo "


$(tput bold)$(tput setaf 2)New output folder selected"$(tput sgr0)
sleep 1
HDROUT=$(echo "$bold""$green"added!"$normal")
CR2OUT=$(cat /tmp/"HDRCR2output");
clear &
printf '\e[8;32;76t'
printf '\e[3;410;0t'
fi
;;

    "s")  
echo > /tmp/HDRCR2
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "r")  
echo > /tmp/HDRCR2
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "ho") 
printf '\e[8;14;90t'
printf '\e[3;410;100t'
clear
echo $(tput bold)How to work with CR2 files through HDRmerge http://jcelaya.github.io/hdrmerge/
echo 
echo $(tput bold)1$(tput sgr0) - Download and install: "
${bold}https://github.com/jcelaya/hdrmerge/releases/download/v0.5.0/HDRMerge.dmg"
echo $(tput bold)2$(tput sgr0) - Move HDRmerge into applications folder 
echo $(tput bold)3$(tput sgr0) - Add HDR CR2 files in your folder and add any settings you wish from the menu
echo $(tput bold)4$(tput sgr0) - Whenever ready press $(tput bold)$(tput setaf 1)"(r)"${bold}$(tput setaf 1)  run Switch$(tput sgr0)
echo
echo $(tput bold)TIP!$(tput sgr0) -If output looks strange add around 30 pixels of radius blur "(bl)"
echo
echo $(tput bold)$(tput setaf 1)${bold}$(tput setaf 1)Hit any key to return to HDR automation menu$(tput sgr0)
    read -n1
    case "$REPLY" in

    * )  
printf '\e[8;32;76t'
printf '\e[3;410;0t'
;;
    esac
;;

    "E")
b24= ; b32= ; na= ; nc= ; gap= ; blur= ; HDR= ; HDROUT= ; CR2OUT=
rm /tmp/HDRCR2output
rm /tmp/HDRCR2_settings
rm /tmp/HDRCR2
;;

    "h")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;


#mlv_dump
    "m") 
#erase mlv_dump_on_steroids settings
rm /tmp/mlv_dump_on_steroids_UNC
rm /tmp/mlv_dump_on_steroids_settings

printf '\e[8;38;73t'
printf '\e[3;450;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

#disable dualiso automation as default
    echo > /tmp/dualisodisable

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; dual= ; c= ; cc= ; ccc= ; ato= ; proxy=
if grep 'no-cs' /tmp/mlv_dump_settings 
then
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2' /tmp/mlv_dump_settings 
then
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3' /tmp/mlv_dump_settings 
then
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5' /tmp/mlv_dump_settings 
then
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixcp' /tmp/mlv_dump_settings 
then
fixcp=$(echo "$bold""$green"added!"$normal")
fi
if grep ' --fixcp2' /tmp/mlv_dump_settings 
then
fixcp=
fixcp2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-stripes' /tmp/mlv_dump_settings 
then
nostripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'black-fix' /tmp/mlv_dump_settings 
then
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' /tmp/mlv_dump_settings)
fi
if grep 'white-fix' /tmp/mlv_dump_settings 
then
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' /tmp/mlv_dump_settings)
fi
if ls /tmp/dualisodisable
then
dual=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-c' /tmp/mlv_dump_settings 
then
c=$(echo "$bold""$green"added!"$normal")
fi
if [ -f /tmp/mlv_dump_UNC ] 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc= ; ato= ; proxy=
rm /tmp/mlv_dump_settings
ccc=$(echo "$bold""$green"added!"$normal")
cc=
fi
if grep 'd' /tmp/mlv_dump_UNC 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato= ; proxy=
rm /tmp/mlv_dump_settings
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
if grep 'relaxed\|skip-xref' /tmp/mlv_dump_settings 
then
ato=$(echo "$bold""$green"added!"$normal")
else
ato=
fi
if grep 'relaxed' /tmp/mlv_dump_UNC
then
ato=$(echo "$bold""$green"added!"$normal")
fi
if [ -f /tmp/PROXYONLY ] 
then
proxy=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    --------
    $(tput bold)mlv_dump$(tput sgr0)
    --------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)
	
-- DNG output --
    $(tput bold)(01) no chroma smoothing$(tput sgr0)   $nocs
    $(tput bold)(02) 2x2 chroma smoothing$(tput sgr0)  $cs2	
    $(tput bold)(03) 3x3 chroma smoothing$(tput sgr0)  $cs3
    $(tput bold)(04) 5x5 chroma smoothing$(tput sgr0)  $cs5
    $(tput bold)(05) turn off cold pixels$(tput sgr0)  $fixcp 
    $(tput bold)(06) fix non-static$(tput sgr0)(moving) $(tput bold)cold pixels$(tput sgr0)(slow) $fixcp2
    $(tput bold)(07) disable vertical stripes in highlights  $nostripes
    $(tput bold)(08) set black level  $(tput setaf 4)$bll$(tput sgr0)
    $(tput bold)(09) set white level  $(tput setaf 4)$wll$(tput sgr0)
    $(tput bold)(10) compress dng files using LJ92$(tput sgr0) $c
    $(tput bold)(11) compress/decompress MLV files using LJ92$(tput sgr0) $cr
    $(tput bold)(12) Uncompressed exporting(no other settings apply!)$(tput sgr0) $cc
    $(tput bold)(13) Uncompr + compr exporting(no other settings apply!)$(tput sgr0) $ccc
    $(tput bold)(14) autopsy settings$(tput sgr0) $ato
    $(tput bold)(15) disable dualiso automation$(tput sgr0)  $dual
    $(tput bold)(16) build a hot/dead pixel list$(tput sgr0)(ImageJ)$(tput sgr0)
    $(tput bold)(17) create a sample files package$(tput sgr0)$(tput sgr0) 
    $(tput bold)(18) white balance picker$(tput sgr0)$(tput sgr0)(ImageJ)$(tput sgr0)
    $(tput bold)(19) MLV+proxy$(tput sgr0)$(tput sgr0)(outputs only MOV(default MOV+MLV)$(tput sgr0) $proxy

    $(tput bold)$(tput setaf 1)(mp) MlRawViewer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(m)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch$(tput sgr0)
			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
rm /tmp/mlv_dump_UNC
cc=
if grep 'no-cs' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-cs" >> /tmp/mlv_dump_settings
nocs=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g'
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "02")
rm /tmp/mlv_dump_UNC
cc=
if grep 'cs2' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs2x2" >> /tmp/mlv_dump_settings
cs2=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs3=
cs5=
fi
;;

    "03")
rm /tmp/mlv_dump_UNC
cc=
if grep 'cs3' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs3x3" >> /tmp/mlv_dump_settings
cs3=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs2=
cs5=
fi
;;

    "04")
rm /tmp/mlv_dump_UNC
cc=
if grep 'cs5' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs5x5" >> /tmp/mlv_dump_settings
cs5=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g'
nocs=
cs2=
cs3=
fi
;;



    "05")
rm /tmp/mlv_dump_UNC
cc=
if grep 'no-fixcp' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixcp" >> /tmp/mlv_dump_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
fi
;;



    "06")
rm /tmp/mlv_dump_UNC
cc=
if grep ' --fixcp2' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g'
printf "%s\n" " --fixcp2" >> /tmp/mlv_dump_settings
fixcp2=$(echo "$bold""$green"added!"$normal")
fixcp=
fi
;;

    "07")
if grep 'no-stripes' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-stripes//g' 
nostripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-stripes" >> /tmp/mlv_dump_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;



    "08")
rm /tmp/mlv_dump_UNC
cc=
if grep 'black-fix' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}black-fix.{0,6}' /tmp/mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
black level setting reset"$(tput sgr0) ; 
sleep 1
bll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify black level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 2048 and hit enter)"
read input_variable
echo "black level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --black-fix"=$input_variable >> /tmp/mlv_dump_settings
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' /tmp/mlv_dump_settings)
fi
sleep 1 
printf '\e[8;38;73t'
printf '\e[3;450;0t'
;;

    "09")
rm /tmp/mlv_dump_UNC
cc=
if grep 'white-fix' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}white-fix.{0,6}' /tmp/mlv_dump_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
white level setting reset"$(tput sgr0) ; 
sleep 1
wll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify white level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 15000 and hit enter)"
read input_variable
echo "white level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --white-fix"=$input_variable >> /tmp/mlv_dump_settings
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' /tmp/mlv_dump_settings)
fi
sleep 1 
printf '\e[8;38;73t'
printf '\e[3;450;0t'
;;


    "10")
rm /tmp/mlv_dump_UNC
cc=
if grep ' \-c' /tmp/mlv_dump_settings 
then
perl -pi -e 's/ -c//g' /tmp/mlv_dump_settings
c=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -c" >> /tmp/mlv_dump_settings
c=$(echo "$bold""$green"added!"$normal")
fi
;;

    "11")
rm /tmp/mlv_dump_UNC
cc=
echo > /tmp/DUALISO/MLV_cprs
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command
;;


    "12")
if [ x"$ccc" = x ]
then
if [ -f /tmp/mlv_dump_UNC ]
then
rm /tmp/mlv_dump_UNC
cc=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato= ; proxy=
rm /tmp/mlv_dump_settings
printf "%s\n" "-c -c -d" > /tmp/mlv_dump_UNC
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
else
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato= ; proxy=
rm /tmp/mlv_dump_settings
printf "%s\n" "-c -c -d" > /tmp/mlv_dump_UNC
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
;;

    "13")
if [ x"$cc" = x ]
then
if [ -f /tmp/mlv_dump_UNC ]
then
rm /tmp/mlv_dump_UNC
ccc=
ato=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc=
printf "%s\n" "-c -c" > /tmp/mlv_dump_UNC
if grep 'relaxed' /tmp/mlv_dump_settings 
then
printf "%s\n" " --relaxed" >> /tmp/mlv_dump_UNC
rm /tmp/mlv_dump_settings
fi
ccc=$(echo "$bold""$green"added!"$normal")
cc=
fi
else
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc=
rm /tmp/mlv_dump_settings
printf "%s\n" "-c -c" > /tmp/mlv_dump_UNC
ccc=$(echo "$bold""$green"added!"$normal")
cc=
fi
;;


    "14")
printf '\e[8;14;83t'
printf '\e[3;450;0t'

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

rel= ; skip= 

if grep 'relaxed' /tmp/mlv_dump_settings 
then
rel=$(echo "$bold""$green"added!"$normal")
fi
if grep 'skip-xref' /tmp/mlv_dump_settings 
then
skip=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    ================
    ${bold}$(tput setaf 1)mlv_dump autopsy$(tput sgr0)(minor selection)
    ----------------
		 
    $(tput bold)(1) relaxed$(tput sgr0)(do not exit on every error, skip blocks that are erroneous) $rel
    $(tput bold)(2) skip-xref$(tput sgr0)(read block in MLV file's order instead of presorted) $skip

    $(tput bold)$(tput setaf 1)(m) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) quit$(tput sgr0)  
    $(tput bold)$(tput setaf 1)(r) run Switch$(tput sgr0)					        					

Please enter your selection number below:
EOF
    read -n1
    case "$REPLY" in

    "1")  
rm /tmp/mlv_dump_UNC
cc=
if grep ' \--relaxed' /tmp/mlv_dump_settings 
then
perl -pi -e 's/ --relaxed//g' /tmp/mlv_dump_settings
rel=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --relaxed" >> /tmp/mlv_dump_settings
rel=$(echo "$bold""$green"added!"$normal")
fi
;;

    "2")
rm /tmp/mlv_dump_UNC
cc=
if grep ' \--skip-xref' /tmp/mlv_dump_settings 
then
perl -pi -e 's/ --skip-xref//g' /tmp/mlv_dump_settings
skip=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --skip-xref" >> /tmp/mlv_dump_settings
skip=$(echo "$bold""$green"added!"$normal")
fi
;;

    "m")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q") 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "r")  
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;



    "15")
if ! ls /tmp/dualisodisable
then 
echo > /tmp/dualisodisable
dual=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/dualisodisable
dual=
fi
;;

    "16")
if ! ls /Applications/ImageJ/ImageJ.app
then
printf '\e[8;20;65t'
printf '\e[3;650;0t'
clear 
echo "You need imageJ installed and the PointPicker plugin installed
for the Pixel picker to work."
sleep 2
open "$(cat /tmp/DUALISO/path_2)"ImageJ.txt
printf '\e[8;35;60t'
printf '\e[3;450;0t'
cd "$(cat /tmp/DUALISO/"path_1")"
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 "$(ls *.MLV | head -1)"
    rm *_.wav
    IFS=$OLDIFS 
cd .. 
else
cd "$(cat /tmp/DUALISO/"path_1")"
open "$(cat /tmp/DUALISO/path_2)"ImageJ.txt
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 "$(ls *.MLV | head -1)"
    dcraw +M -c -6 -W -q 3 "$(ls *.MLV | head -1 | cut -d "." -f1)"_000001.dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 "$(ls *.MLV | head -1 | cut -d "." -f1)"_000001.tif
    rm *_.wav
    IFS=$OLDIFS 
    open -a /Applications/ImageJ/ImageJ.app "$(ls *.tif | head -1)" &
cd .. 
fi
;;

    "17")
#mlv_dump settings
    mlv=$(cat /tmp/mlv_dump_settings)
cd "$(cat /tmp/DUALISO/"path_1")"
#list all mlv files
    ls *.MLV > /tmp/DUALISO/samples
#menu
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$(cat /tmp/DUALISO/path_2)"progress_bar.command &
    while grep 'MLV' /tmp/DUALISO/samples
    do
cd "$(cat /tmp/DUALISO/"path_1")"
mkdir -p "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples
#Debug log file
    rm "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exec &> >(tee -a "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt >&2 )
    OLDIFS=$IFS
    mlv_dump -f 4 -o "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)" "$(cat /tmp/DUALISO/samples | head -1)" &
    mlv_dump $mlv --dng -f 0 -o "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)" "$(cat /tmp/DUALISO/samples | head -1)" & sleep 2
    killall mlv_dump
    mv "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"000000.dng "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng
    mlv_dump -v "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)"
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exiftool "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    if ls "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    then
    rm "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".MLV.wav
    exiftool "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    fi
    zip "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)" "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    mv "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples.zip ./
    rm -r "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples 
    IFS=$OLDIFS 
    echo "$(tail -n +2 /tmp/DUALISO/samples)" > /tmp/DUALISO/samples
    done
cd ..
;;

    "18")
if ! ls /Applications/ImageJ/ImageJ.app
then
printf '\e[8;20;65t'
printf '\e[3;650;0t'
clear 
echo "You need imageJ installed and the PointPicker plugin installed
for the Pixel picker to work."
sleep 2
open "$(cat /tmp/DUALISO/path_2)"ImageJ.txt
printf '\e[8;35;60t'
printf '\e[3;450;0t'
cd "$(cat /tmp/DUALISO/"path_1")"
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 "$(ls *.MLV | head -1)" & sleep 1
    killall mlv_dump
    rm *_.wav
    IFS=$OLDIFS 
cd .. 
else
echo > /tmp/DUALISO/WB_PICK_MLV
#enter parent folder
    cd "$(cat /tmp/DUALISO/path_1)" 
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
fi
;;

    "19")
if ! ls /tmp/PROXYONLY
then 
echo > /tmp/PROXYONLY
proxy=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/PROXYONLY
proxy=
fi
;;

    "mp")
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer.app/Contents/MacOS/mlrawviewer "$(cat /tmp/DUALISO/"path_1")" & sleep 2
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
while [ -n "$(pgrep mlrawviewer </dev/null)" ];
do sleep 1
done
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
;;

    "E")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= dual= ; c= ; cc= ; ccc= ; ato= ; proxy=
rm /tmp/PROXYONLY
rm /tmp/mlv_dump_UNC
rm /tmp/mlv_dump_settings 1> /dev/null 2>&1 &
rm /tmp/dualisodisable 1> /dev/null 2>&1 &
;;

    "m")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")  
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;


#mlv_dump_on_steroids
    "ms")
#erase mlv_dump settings 
if ! [ -f /tmp/mlv_dump_on_steroids_settings ]
then
echo > /tmp/mlv_dump_on_steroids_settings
fi
rm /tmp/mlv_dump_UNC
rm /tmp/mlv_dump_settings

printf '\e[8;43;73t'
printf '\e[3;450;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

#disable dualiso automation as default
    echo > /tmp/dualisodisable

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; dual= ; p= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
if grep 'no-cs' /tmp/mlv_dump_on_steroids_settings 
then
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2' /tmp/mlv_dump_on_steroids_settings 
then
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3' /tmp/mlv_dump_on_steroids_settings 
then
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5' /tmp/mlv_dump_on_steroids_settings 
then
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixfp' /tmp/mlv_dump_on_steroids_settings 
then
fixfp=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixcp' /tmp/mlv_dump_on_steroids_settings 
then
fixcp=$(echo "$bold""$green"added!"$normal")
fi
if grep ' --fixcp2' /tmp/mlv_dump_on_steroids_settings 
then
fixcp=
fixcp2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-stripes' /tmp/mlv_dump_on_steroids_settings 
then
nostripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'black-fix' /tmp/mlv_dump_on_steroids_settings 
then
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
if grep 'white-fix' /tmp/mlv_dump_on_steroids_settings 
then
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
if ls /tmp/dualisodisable
then
dual=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-c' /tmp/mlv_dump_on_steroids_settings 
then
c=$(echo "$bold""$green"added!"$normal")
fi
if [ -f /tmp/mlv_dump_on_steroids_UNC ] 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
rm /tmp/mlv_dump_on_steroids_settings
p=$(echo "$bold""$green"added!"$normal")
fi
if grep 'relaxed' /tmp/mlv_dump_on_steroids_settings 
then
ato=$(echo "$bold""$green"added!"$normal")
else
ato=
fi
if grep 'relaxed' /tmp/mlv_dump_on_steroids_UNC
then
ato=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-audio' /tmp/mlv_dump_on_steroids_settings 
then
w=$(echo "$bold""$green"added!"$normal")
fi
if grep 'force-stripes' /tmp/mlv_dump_on_steroids_settings 
then
fstripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'fpn' /tmp/mlv_dump_on_steroids_settings 
then
fpn=$(echo "$bold""$green"added!"$normal")
fi
if grep 'deflicker' /tmp/mlv_dump_on_steroids_settings 
then
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
if grep ' \-b' /tmp/mlv_dump_on_steroids_settings 
then
btp=$(grep -Eo '.{0,0}-b.{0,3}' /tmp/mlv_dump_on_steroids_settings)
fi
if grep 'no-bitpack' /tmp/mlv_dump_on_steroids_settings 
then
fdepth=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \--fpi' /tmp/mlv_dump_on_steroids_settings 
then
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)
fi
if grep ' \--bpi' /tmp/mlv_dump_on_steroids_settings 
then
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)
fi
if [ -f /tmp/PROXYONLY ] 
then
proxy=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    --------
    $(tput bold)mlv_dump_on_steroids$(tput sgr0)(Bouncyball)
    --------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)
	
-- DNG output --
    $(tput bold)(00) no chroma smoothing$(tput sgr0)   $nocs
    $(tput bold)(01) 2x2 chroma smoothing$(tput sgr0)  $cs2	
    $(tput bold)(02) 3x3 chroma smoothing$(tput sgr0)  $cs3
    $(tput bold)(03) 5x5 chroma smoothing$(tput sgr0)  $cs5
    $(tput bold)(04) do not fix focus pixels$(tput sgr0)  $fixfp
    $(tput bold)(05) do not fix cold pixels$(tput sgr0)  $fixcp 
    $(tput bold)(06) fix non-static$(tput sgr0)(moving) $(tput bold)cold pixels$(tput sgr0)(slow) $fixcp2
    $(tput bold)(07) disable vertical stripes in highlights  $nostripes
    $(tput bold)(08) force vertical stripes$(tput sgr0)(slow, every frame)  $fstripes
    $(tput bold)(09) set black level  $(tput setaf 4)$bll$(tput sgr0)
    $(tput bold)(10) set white level  $(tput setaf 4)$wll$(tput sgr0)
    $(tput bold)(11) compress dng files using LJ92$(tput sgr0) $c
    $(tput bold)(12) compress/decompress MLV files using LJ92$(tput sgr0) $cr
    $(tput bold)(13) pass through original raw data without processing$(tput sgr0) $p
    $(tput bold)(14) no audio$(tput sgr0)(no WAV file nor wav metadata) $w
    $(tput bold)(15) relaxed$(tput sgr0)(skip blocks that are erroneous) $ato
    $(tput bold)(16) fix pattern noise$(tput sgr0) $fpn
    $(tput bold)(17) deflicker$(tput sgr0) 3072(default) $(tput bold)$(tput setaf 4)$dfl$(tput sgr0)
    $(tput bold)(18) convert to bit depth$(tput sgr0)(1-16) $(tput bold)$(tput setaf 4)$btp$(tput sgr0)
    $(tput bold)(19) write DNG to 16 bit$(tput sgr0) $fdepth
    $(tput bold)(20) focus pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=0$(tput bold)$(tput setaf 4) $fcpm$(tput sgr0)
    $(tput bold)(21) bad pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=1$(tput bold)$(tput setaf 4) $bpm$(tput sgr0)
    $(tput bold)(22) disable dualiso automation$(tput sgr0)  $dual
    $(tput bold)(23) create a sample files package$(tput sgr0)
    $(tput bold)(24) MLV+proxy$(tput sgr0)$(tput sgr0)(outputs only MOV(default MOV+MLV)$(tput sgr0) $proxy

    $(tput bold)$(tput setaf 1)(mp) MlRawViewer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ms) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch$(tput sgr0)
			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "00")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'no-cs' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-cs" >> /tmp/mlv_dump_on_steroids_settings
nocs=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "01")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'cs2' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs2x2" >> /tmp/mlv_dump_on_steroids_settings
cs2=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs3=
cs5=
fi
;;

    "02")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'cs3' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs3x3" >> /tmp/mlv_dump_on_steroids_settings
cs3=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs2=
cs5=
fi
;;

    "03")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'cs5' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs5x5" >> /tmp/mlv_dump_on_steroids_settings
cs5=$(echo "$bold""$green"added!"$normal")
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g'
nocs=
cs2=
cs3=
fi
;;

    "04")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'no-fixfp' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixfp" >> /tmp/mlv_dump_on_steroids_settings
fixfp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --fixcp2//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
fi
;;

    "05")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'no-fixcp' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixcp" >> /tmp/mlv_dump_on_steroids_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --fixcp2//g'
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
fi
;;

    "06")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' --fixcp2' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixcp//g'
printf "%s\n" " --fixcp2" >> /tmp/mlv_dump_on_steroids_settings
fixcp2=$(echo "$bold""$green"added!"$normal")
fixcp=
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixfp//g' 
fixfp=
fi
;;

    "07")
if grep 'no-stripes' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-stripes//g' 
nostripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-stripes" >> /tmp/mlv_dump_on_steroids_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "08")
if grep 'force-stripes' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --force-stripes//g' 
fstripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --force-stripes" >> /tmp/mlv_dump_on_steroids_settings
fstripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "09")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'black-fix' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}black-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
black level setting reset"$(tput sgr0) ; 
sleep 1
bll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify black level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 2048 and hit enter)"
read input_variable
echo "black level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --black-fix"=$input_variable >> /tmp/mlv_dump_on_steroids_settings
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "10")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'white-fix' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}white-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
white level setting reset"$(tput sgr0) ; 
sleep 1
wll=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify white level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 15000 and hit enter)"
read input_variable
echo "white level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --white-fix"=$input_variable >> /tmp/mlv_dump_on_steroids_settings
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;


    "11")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' \-c' /tmp/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ -c//g' /tmp/mlv_dump_on_steroids_settings
c=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -c" >> /tmp/mlv_dump_on_steroids_settings
c=$(echo "$bold""$green"added!"$normal")
fi
;;

    "12")
rm /tmp/mlv_dump_on_steroids_UNC
p=
echo > /tmp/DUALISO/MLV_cprs
if ! [ -f /tmp/mlv_dump_on_steroids_settings ]
then
echo > /tmp/mlv_dump_on_steroids_settings
fi
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command
;;


    "13")
if [ -f /tmp/mlv_dump_on_steroids_UNC ]
then
rm /tmp/mlv_dump_on_steroids_UNC
p=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
rm /tmp/mlv_dump_on_steroids_settings
printf "%s\n" "-p" > /tmp/mlv_dump_on_steroids_UNC
p=$(echo "$bold""$green"added!"$normal")
fi
;;

    "14")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'no-audio' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-audio//g' 
w=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-audio" >> /tmp/mlv_dump_on_steroids_settings
w=$(echo "$bold""$green"added!"$normal")
fi
;;


    "15")  
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' \--relaxed' /tmp/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ --relaxed//g' /tmp/mlv_dump_on_steroids_settings
ato=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --relaxed" >> /tmp/mlv_dump_on_steroids_settings
ato=$(echo "$bold""$green"added!"$normal")
fi
;;

    "16")  
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'fpn' /tmp/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ --fpn//g' /tmp/mlv_dump_on_steroids_settings
fpn=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --fpn" >> /tmp/mlv_dump_on_steroids_settings
fpn=$(echo "$bold""$green"added!"$normal")
fi
;;


    "17")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'deflicker' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}deflicker.{0,6}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
deflicker level setting reset"$(tput sgr0) ; 
sleep 1
dfl=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify deflicker level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 3072 and hit enter)"
read input_variable
echo "deflicker level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --deflicker"=$input_variable >> /tmp/mlv_dump_on_steroids_settings
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "18")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' \-b' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}-b.{0,3}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
bitdepth reset"$(tput sgr0) ; 
sleep 1
btp=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify bitdepth:$(tput sgr0)(between$(tput sgr0) 1-16 and hit enter)"
read input_variable
echo "bitdepth is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " -b $input_variable" >> /tmp/mlv_dump_on_steroids_settings
btp=$(grep -Eo '.{0,0}-b.{0,3}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "19")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep 'no-bitpack' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-bitpack//g' 
fdepth=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-bitpack" >> /tmp/mlv_dump_on_steroids_settings
fdepth=$(echo "$bold""$green"added!"$normal")
fi
;;

    "20")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' \--fpi' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--fpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
focus pixel method reset"$(tput sgr0) ; 
sleep 1
fcpm=
else
printf '\e[8;16;65t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify focus pixel method:$(tput sgr0)(between$(tput sgr0) 0 or 1 and hit enter)"
read input_variable
echo "focus pixel method is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --fpi $input_variable" >> /tmp/mlv_dump_on_steroids_settings
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "21")
rm /tmp/mlv_dump_on_steroids_UNC
p=
if grep ' \--bpi' /tmp/mlv_dump_on_steroids_settings 
then
find /tmp/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--bpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)"'//g'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
bad pixel method reset"$(tput sgr0) ; 
sleep 1
bpm=
else
printf '\e[8;16;65t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify bad pixel method:$(tput sgr0)(between$(tput sgr0) 0 or 1 and hit enter)"
read input_variable
echo "bad pixel method is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" " --bpi $input_variable" >> /tmp/mlv_dump_on_steroids_settings
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' /tmp/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;43;73t'
printf '\e[3;450;0t'
;;

    "22")
if ! ls /tmp/dualisodisable
then 
echo > /tmp/dualisodisable
dual=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/dualisodisable
dual=
fi
;;

    "23")
if ! [ -f /tmp/mlv_dump_on_steroids_settings ]
then
echo > /tmp/mlv_dump_on_steroids_settings
fi
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
#mlv_dump settings
    mlv=$(cat /tmp/mlv_dump_on_steroids_settings)
cd "$(cat /tmp/DUALISO/"path_1")"
#list all mlv files
    ls *.MLV > /tmp/DUALISO/samples
#menu
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$(cat /tmp/DUALISO/path_2)"progress_bar.command &
    while grep 'MLV' /tmp/DUALISO/samples
    do
cd "$(cat /tmp/DUALISO/"path_1")"
mkdir -p "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples
#Debug log file
    rm "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exec &> >(tee -a "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt >&2 )
    OLDIFS=$IFS
    $mlv_dump -f 4 -o "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)" "$(cat /tmp/DUALISO/samples | head -1)" &
    $mlv_dump $mlv --dng -f 0 -o "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)" "$(cat /tmp/DUALISO/samples | head -1)" & sleep 2
    killall $mlv_dump
    mv "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"000000.dng "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng
    $mlv_dump -v "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)"
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exiftool "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt
    if ls "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    then
    rm "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".MLV.wav
    exiftool "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    fi
    zip "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1)" "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".dng "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_LOG.txt "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)".wav
    mv "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples/"$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples.zip ./
    rm -r "$(cat /tmp/DUALISO/samples | head -1 | cut -d "." -f1)"_samples 
    IFS=$OLDIFS 
    echo "$(tail -n +2 /tmp/DUALISO/samples)" > /tmp/DUALISO/samples
    done
cd ..
;;

    "24")
if ! ls /tmp/PROXYONLY
then 
echo > /tmp/PROXYONLY
proxy=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/PROXYONLY
proxy=
fi
;;

    "mp")
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer.app/Contents/MacOS/mlrawviewer "$(cat /tmp/DUALISO/"path_1")" & sleep 2
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
while [ -n "$(pgrep mlrawviewer </dev/null)" ];
do sleep 1
done
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
;;

    "E")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= dual= ; p= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
rm /tmp/PROXYONLY
rm /tmp/mlv_dump_on_steroids_UNC
rm /tmp/mlv_dump_on_steroids_settings 1> /dev/null 2>&1 &
rm /tmp/dualisodisable 1> /dev/null 2>&1 &
;;

    "ms")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")  
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;


#ProRes output
    "p") 

#Erase full auto setting
if ls /tmp/DUALISO/FULL_AUTO
then
if ls /tmp/FFmpeg_settings*
then
pro_a=
rm /tmp/FFmpeg_settings 1> /dev/null 2>&1 &
rm /tmp/FFmpeg_settingsPR 1> /dev/null 2>&1 &
clear 
echo "$(tput setaf 1)""Erased ProRes auto settings"
sleep 1
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
fi

printf '\e[8;57;65t'
printf '\e[3;450;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

#create base folders
#new output folder
if ls /tmp/output
then
mkdir -p "$(cat /tmp/output)"/$(date +%F)_Proxy
mkdir -p "$(cat /tmp/output)"/$(date +%F)_ProRes4444
else
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
fi

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra= ; wle= ; AE_HDR= ; DEL_DNG=

if grep 'lincineon' /tmp/FFmpeg_settings 
then
lincin=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linlogC' /tmp/FFmpeg_settings 
then
linlogC=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linear' /tmp/FFmpeg_settings 
then
linear=$(echo "$bold""$green"added!"$normal")
fi
if grep 'rec709' /tmp/FFmpeg_settings 
then
rec709=$(echo "$bold""$green"added!"$normal")
fi
if grep 'xyz' /tmp/FFmpeg_settings 
then
xyz=$(echo "$bold""$green"added!"$normal")
fi
if grep 'aces' /tmp/FFmpeg_settings 
then
aces=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat /tmp/_X_pres_SCALE) = x ] 
then
Pscale=$(echo "$bold""$green"added!"$normal")
Paspect=$(cat /tmp/_X_pres_SCALE)
else
Pscale=
Paspect=
fi
if grep 'AE_template' /tmp/FFmpeg_settings 
then
AE=$(echo "$bold""$green"added!"$normal")
fi
if grep 'AE_temp_HDR' /tmp/FFmpeg_settings 
then
AE_HDR=$(echo "$bold""$green"added!"$normal")
fi

if grep 'lincineonpr' /tmp/FFmpeg_settingsPR 
then
lincinpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linlogCpr' /tmp/FFmpeg_settingsPR 
then
linlogCpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linearpr' /tmp/FFmpeg_settingsPR 
then
linearpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'rec709pr' /tmp/FFmpeg_settingsPR 
then
rec709pr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'xyzpr' /tmp/FFmpeg_settingsPR 
then
xyzpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'acespr' /tmp/FFmpeg_settingsPR 
then
acespr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Pcodec_lt' /tmp/FFmpeg_settingsPR 
then
Pcodec_lt=$(echo "$bold""$green"added!"$normal")
fi
if [ -f /tmp/DUALISO/DEL_DNG ]
then
DEL_DNG=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat /tmp/prox_SCALE) = x ] 
then
Xscale=$(echo "$bold""$green"added!"$normal")
Xaspect=$(cat /tmp/prox_SCALE)
else
Xscale=
Xaspect=
fi

if ! [ x$(cat /tmp/denoise) = x ] 
then
denoise=$(echo "$bold""$green"denoise!"$normal")
else
denoise=
fi
if ! [ x$(cat /tmp/sharpen) = x ] 
then
sharpen=$(echo "$bold""$green"sharpen!"$normal")
else
sharpen=
fi

if grep 'AWB' /tmp/FFmpeg_settings 
then
AWB=$(echo "$bold""$green"added!"$normal")
fi
if grep 'dcrawA' /tmp/FFmpeg_settings 
then
dcrawA=$(echo "$bold""$green"added!"$normal")
fi

if grep 'HDR' /tmp/pr4444_HDR
then
HDRa=$(echo "$bold""$green"added!"$normal")
fi
if grep 'halfhdr' /tmp/pr4444_HDR
then
halfhdra=$(echo "$bold""$green"added!"$normal")
fi

if [ -f /tmp/FFmpeg_white_level ]
then
wle=$(cat /tmp/FFmpeg_white_level)
fi

while :
do 

    clear
    cat<<EOF
    -------------
    $(tput bold)ProRes output$(tput sgr0)(MLV,RAW,dng)
    -------------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)

-- ProRes4444 output --
    $(tput bold)(01) linear to cineon$(tput sgr0)(recommended) $lincin
    $(tput bold)(02) linear to logC$(tput sgr0)(recommended) $linlogC	
    $(tput bold)(03) linear$(tput sgr0) $linear
    $(tput bold)(04) rec709$(tput sgr0) $rec709 
    $(tput bold)(05) xyz$(tput sgr0) $xyz
    $(tput bold)(06) aces$(tput sgr0) $aces
    $(tput bold)(07) switch to another codec$(tput sgr0) $bold$blue$(if [ -f /tmp/FFmpeg_settings ]; then cat /tmp/FFmpeg_settings | grep 'x264a\|x264b\|prores_422\|DNxHD_422' ; fi)$normal
-- other settings(ProRes4444)
    $(tput bold)(08) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$Paspect$(tput sgr0) $Pscale

-- ProRes Proxy output --
    $(tput bold)(09) linear to cineon$(tput sgr0) $lincinpr
    $(tput bold)(10) linear to logC$(tput sgr0) $linlogCpr
    $(tput bold)(11) linear$(tput sgr0) $linearpr
    $(tput bold)(12) rec709$(tput sgr0) $rec709pr 
    $(tput bold)(13) xyz$(tput sgr0) $xyzpr
    $(tput bold)(14) aces$(tput sgr0) $acespr
    $(tput bold)(15) switch to ProRes LT codec$(tput sgr0) $Pcodec_lt
-- other settings(proxy)
    $(tput bold)(16) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$Xaspect$(tput sgr0) $Xscale

-- Denoise and sharpen filters --
    $(tput bold)(17) set denoise and sharpening$(tput sgr0)  $denoise $sharpen

-- misc settings --
    $(tput bold)(18) auto white balance$(tput sgr0)(median of 6 dng files)$(tput sgr0) $AWB
    $(tput bold)(19) dcraw auto white balance$(tput sgr0)$(tput sgr0) $dcrawA
    $(tput bold)(20) set white level  $(tput setaf 4)$wle$(tput sgr0)

-- HDR output(affects both prores4444 and proxy) --
    $(tput bold)(21) HDR footage$(tput sgr0)(e.g 100/1600iso) $HDRa
    $(tput bold)(22) drop frames$(tput sgr0)(50fps to 25fps etc) $halfhdra

-- AE template -- 
    $(tput bold)(23) Export footage through AE(aerender)$(tput sgr0) $AE
    $(tput bold)(24) Export HDR footage through AE(aerender)$(tput sgr0) $AE_HDR
    $(tput bold)(25) open first dng in every folder(ACR)$(tput sgr0)

    $(tput bold)$(tput setaf 1)(X)  Delete dng folder after ProRes is created$(tput sgr0) $DEL_DNG
    $(tput bold)$(tput setaf 1)(mp) MlRawViewer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ho) HOWTO$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ti) tif previews$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'lincineon' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g' 
lincin=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "lincineon" >> /tmp/FFmpeg_settings
lincin=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
linlogC=
linear=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "02")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'linlogC' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
linlogC=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linlogC" >> /tmp/FFmpeg_settings
linlogC=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linear=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "03")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'linear' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
linear=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linear" >> /tmp/FFmpeg_settings
linear=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "04")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'rec709' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g' 
rec709=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "rec709" >> /tmp/FFmpeg_settings
rec709=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
linear=
sRGB=
xyz=
aces=
fi
;;

    "05")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'xyz' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g' 
xyz=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "xyz" >> /tmp/FFmpeg_settings
xyz=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
linear=
rec709=
sRGB=
aces=
fi
;;

    "06")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'aces' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/aces//g' 
aces=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "aces" >> /tmp/FFmpeg_settings
aces=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
lincin=
linlogC=
linear=
rec709=
sRGB=
xyz=
fi
;;


    "07")
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444

#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
printf '\e[8;20;67t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

H2a= ; H2b= ; pr422= ; dc=

if grep -q 'x264a' /tmp/FFmpeg_settings 
then
H2a=$(echo "$bold""$green"added!"$normal")
fi
if grep -q 'x264b' /tmp/FFmpeg_settings 
then
H2b=$(echo "$bold""$green"added!"$normal")
fi
if grep -q 'prores_422' /tmp/FFmpeg_settings 
then
pr422=$(echo "$bold""$green"added!"$normal")
fi
if grep -q 'qual0' /tmp/FFmpeg_settings 
then
dc=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    =======================
    ${bold}$(tput setaf 1)Alternate codec setting$(tput sgr0)
    -----------------------
 
    $(tput bold)(01)$(tput sgr0) lossless x264(ultrafast - crf 10 - recommended) $H2a
    $(tput bold)(02)$(tput sgr0) lossless x264(ultrafast,huge files) $H2b
    $(tput bold)(03)$(tput sgr0) prores_422 $pr422				   

    $(tput bold)$(tput setaf 1)(dc) set dcraw quality to 0 (faster)$(tput sgr0) $dc
    $(tput bold)$(tput setaf 1)(p)  return to prores menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(R)  reset$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  quit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in


    "01")  
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'x264a' /tmp/FFmpeg_settings
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264a//g' 
H2a=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "x264a" >> /tmp/FFmpeg_settings
H2a=$(echo "$bold""$green"added!"$normal")
#remove unwanted codecs
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264b//g'
H2b=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/prores_422//g' 
pr422=
fi
;;

    "02")  
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'x264b' /tmp/FFmpeg_settings
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264b//g' 
H2b=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "x264b" >> /tmp/FFmpeg_settings
H2b=$(echo "$bold""$green"added!"$normal")
#remove unwanted codecs
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264a//g'
H2a=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/prores_422//g' 
pr422=
fi
;;

    "03")  
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'prores_422' /tmp/FFmpeg_settings
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/prores_422//g' 
pr422=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "prores_422" >> /tmp/FFmpeg_settings
pr422=$(echo "$bold""$green"added!"$normal")
#remove unwanted codecs
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264a//g'
H2a=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264b//g'
H2b=
fi
;;

    "dc")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'qual0' /tmp/FFmpeg_settings
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/qual0//g' 
dc=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "qual0" >> /tmp/FFmpeg_settings
dc=$(echo "$bold""$green"added!"$normal")
fi
;;

    "p")  
echo > /tmp/DUALISO/tif_back  
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command
;;


    "R")  
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/prores_422//g' 
pr422=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264a//g'
H2a=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/x264b//g'
H2b=
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/qual0//g' 
dc=
;;


    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;








     "08")
if ! [ x$(cat /tmp/_X_pres_SCALE) = x ]
then
rm /tmp/_X_pres_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
Pscale=
Paspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1 > /tmp/_X_pres_SCALE
if ! [ x$(cat /tmp/_X_pres_SCALE) = x ]
then
Pscale=$(echo "$bold""$green"added!"$normal")
Paspect=$(cat /tmp/_X_pres_SCALE)
else
Pscale=
Paspect=
fi
fi
sleep 1 
printf '\e[8;57;65t'
printf '\e[3;450;0t'
;;

    "09")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'lincineonpr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g' 
lincinpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "lincineonpr" >> /tmp/FFmpeg_settingsPR
lincinpr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
linlogCpr=
linearpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "10")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'linlogCpr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
linlogCpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linlogCpr" >> /tmp/FFmpeg_settingsPR
linlogCpr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linearpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "11")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'linearpr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
linearpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linearpr" >> /tmp/FFmpeg_settingsPR
linearpr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "12")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'rec709pr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g' 
rec709pr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "rec709pr" >> /tmp/FFmpeg_settingsPR
rec709pr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
linearpr=
xyzpr=
acespr=
fi
;;


    "13")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'xyzpr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g' 
xyzpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "xyzpr" >> /tmp/FFmpeg_settingsPR
xyzpr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
linearpr=
rec709pr=
acespr=
fi
;;

    "14")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'acespr' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g' 
acespr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "acespr" >> /tmp/FFmpeg_settingsPR
acespr=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
lincinpr=
linlogCpr=
linearpr=
rec709pr=
xyzpr=
fi
;;

    "15")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
if grep 'Pcodec_lt' /tmp/FFmpeg_settingsPR 
then
find /tmp/FFmpeg_settingsPR | xargs perl -pi -e 's/Pcodec_lt//g' 
Pcodec_lt=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Pcodec_lt" >> /tmp/FFmpeg_settingsPR
Pcodec_lt=$(echo "$bold""$green"added!"$normal")
fi
;;

     "16")
if ! [ x$(cat /tmp/prox_SCALE) = x ]
then
rm /tmp/prox_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
Xscale=
Xaspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1 > /tmp/prox_SCALE
if ! [ x$(cat /tmp/prox_SCALE) = x ]
then
Xscale=$(echo "$bold""$green"added!"$normal")
Xaspect=$(cat /tmp/prox_SCALE)
else
Xscale=
Xaspect=
fi
fi
sleep 1 
printf '\e[8;57;65t'
printf '\e[3;450;0t'
;;

    "17")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
printf '\e[8;25;60t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=

if grep 'hqdn3d=0:0:2:2' /tmp/denoise
then
sl_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:4:4' /tmp/denoise 
then
me_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:6:6' /tmp/denoise 
then
st_h=$(echo "$bold""$green"added!"$normal")
fi

if grep 'unsharp=5:5:1.0:5:5:0.0' /tmp/sharpen 
then
sl_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=7:7:0.8:7:7:0' /tmp/sharpen 
then
me_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=9:9:1.0:9:9:0' /tmp/sharpen 
then
st_s=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF

    ==============================
    ${bold}$(tput setaf 1)FFmpeg hqdn3d$(tput sgr0)
    ------------------------------
    $(tput bold)(1)$(tput sgr0) Slight denoising   $sl_h				 
    $(tput bold)(2)$(tput sgr0) Medium denoising   $me_h
    $(tput bold)(3)$(tput sgr0) Strong denoising   $st_h

    ==============================
    ${bold}$(tput setaf 1)FFmpeg sharpen(unsharp)$(tput sgr0)
    ------------------------------
    $(tput bold)(4)$(tput sgr0) Slight sharpening   $sl_s				 
    $(tput bold)(5)$(tput sgr0) Medium sharpening   $me_s
    $(tput bold)(6)$(tput sgr0) Strong sharpening   $st_s

    $(tput bold)$(tput setaf 1)(q) X to ProRes menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E) erase all settings$(tput sgr0)
					        					
Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

    "1") 
if grep 'hqdn3d=0:0:2:2' /tmp/denoise 
then
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:2:2" >> /tmp/denoise
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight denoising"$(tput sgr0) ; 
fi
;;

    "2")
if grep 'hqdn3d=0:0:4:4' /tmp/denoise 
then
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:4:4" >> /tmp/denoise
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium denoising"$(tput sgr0) ; 
fi
;;

    "3")
if grep 'hqdn3d=0:0:6:6' /tmp/denoise 
then
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:6:6" >> /tmp/denoise
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find /tmp/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong denoising"$(tput sgr0) ; 
fi
;;

    "4")
if grep 'unsharp=5:5:1.0:5:5:0.0' /tmp/sharpen 
then
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=5:5:1.0:5:5:0.0" >> /tmp/sharpen
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g'
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight sharpening"$(tput sgr0) ; 
fi
;;

    "5")
if grep 'unsharp=7:7:0.8:7:7:0' /tmp/sharpen 
then
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=7:7:0.8:7:7:0" >> /tmp/sharpen
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium sharpening"$(tput sgr0) ; 
fi
;;

    "6")
if grep 'unsharp=9:9:1.0:9:9:0' /tmp/sharpen 
then
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=9:9:1.0:9:9:0" >> /tmp/sharpen
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find /tmp/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong sharpening"$(tput sgr0) ; 
fi
;;



#go back to prores menu
    "q") 
echo > /tmp/DUALISO/tif_back  
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command
;;

    "E")
sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

    "18")
if grep 'AWB' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/AWB//g' 
AWB=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "AWB" >> /tmp/FFmpeg_settings
AWB=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/dcrawA//g'
dcrawA=
fi
;;

    "19")
if grep 'dcrawA' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/dcrawA//g' 
dcrawA=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "dcrawA" >> /tmp/FFmpeg_settings
dcrawA=$(echo "$bold""$green"added!"$normal")
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/AWB//g'
AWB=
fi
;;

    "20")
if [ -f /tmp/FFmpeg_white_level ]
then
rm /tmp/FFmpeg_white_level
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
white level setting reset"$(tput sgr0) ; 
sleep 1
wle=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify white level:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 15000 and hit enter)"
read input_variable
echo "white level is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
printf "%s\n" "$input_variable" > /tmp/FFmpeg_white_level
wle=$(cat /tmp/FFmpeg_white_level)
fi
sleep 1 
printf '\e[8;57;65t'
printf '\e[3;450;0t'
;;

    "21")
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
if grep 'HDR' /tmp/pr4444_HDR
then
find /tmp/pr4444_HDR | xargs perl -pi -e 's/HDR//g'
HDRa=
find /tmp/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "HDR" >> /tmp/pr4444_HDR
HDRa=$(echo "$bold""$green"added!"$normal")
fi
;;

    "22")
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
if grep 'halfhdr' /tmp/pr4444_HDR 
then
find /tmp/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "halfhdr" >> /tmp/pr4444_HDR
halfhdra=$(echo "$bold""$green"added!"$normal")
if ! grep 'HDR' /tmp/pr4444_HDR
then
echo "HDR" >> /tmp/pr4444_HDR
HDRa=$(echo "$bold""$green"added!"$normal")
fi
fi
;;


    "23")
#AE_question
if ! grep 'AE_template' /tmp/FFmpeg_settings 
then
echo AE_template > /tmp/FFmpeg_settings
    mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
#Find aerender among multiple versions
    ls -td /Applications/Adobe\ After\ * > /tmp/DUALISO/AErenderPATH
    while ! ls "$(cat /tmp/DUALISO/AErenderPATH | head -1)"/aerender
    do
    echo "$(tail -n +2 /tmp/DUALISO/AErenderPATH)" > /tmp/DUALISO/AErenderPATH
    if ! grep 'Adobe' /tmp/DUALISO/AErenderPATH
    then
    rm /tmp/FFmpeg_settings
    clear
    echo $(tput bold)"

    $(tput sgr0)$(tput bold)$(tput setaf 1) 
aerender is missing, check your after effects version"$(tput sgr0) ; 
    sleep 2
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    fi
    done
#get the correct template
    if grep 'CC' <<< $(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)")
    then
    numb=$(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)" | awk 'FNR == 1 {print $5; }')
    if (( $(echo "$numb > 2015.2" |bc -l) )); 
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_templateCC.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;20;95t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"


while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}$(tput setaf 1)AE project settings$(tput sgr0)
    ------------------------------
 
    $(tput bold)(c)$(tput sgr0) I want to change AE project settings template				 
    $(tput bold)(r)$(tput sgr0) Continue without changes  

    $(tput bold)$(tput setaf 1)(p) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) quit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n1
    case "$REPLY" in

    "c")  
#Reset file if needed
if ! grep 'any_X' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
then
perl -pi -e 's/'"$(LC_ALL=C cat -v "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep | tr ' ' '\n' | grep -o -m 1 '[^ ]*C0000')"'/any_X/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
fi

#list dng directories
    cd "$(cat /tmp/DUALISO/"path_1")"
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
    cd -
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
#creating a dummy audio file if not present
    if ! ls "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav 
    then
    ffmpeg -t 1 -f s16le -acodec pcm_s16le -ac 2 -i /dev/zero -acodec copy "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    fi
#Add correct filename
perl -pi -e 's/any_X/'"$name"'/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
open "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep &

echo > /tmp/DUALISO/AE_question
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
;;

    "r") 
rm /tmp/magic_l_prores/AE_question 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
rm /tmp/magic_l_prores/AE_question 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
else
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_white_level
rm /tmp/FFmpeg_settings
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; DEL_DNG=
fi
;;


    "24")
#AE_question
if ! grep 'AE_temp_HDR' /tmp/FFmpeg_settings 
then
echo AE_temp_HDR > /tmp/FFmpeg_settings
    mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
#Find aerender among multiple versions
    ls -td /Applications/Adobe\ After\ * > /tmp/DUALISO/AErenderPATH
    while ! ls "$(cat /tmp/DUALISO/AErenderPATH | head -1)"/aerender
    do
    echo "$(tail -n +2 /tmp/DUALISO/AErenderPATH)" > /tmp/DUALISO/AErenderPATH
    if ! grep 'Adobe' /tmp/DUALISO/AErenderPATH
    then
    rm /tmp/FFmpeg_settings
    clear
    echo $(tput bold)"

    $(tput sgr0)$(tput bold)$(tput setaf 1) 
aerender is missing, check your after effects version"$(tput sgr0) ; 
    sleep 2
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    fi
    done
#get the correct template
#but first check if HDR template was chosen
    if grep 'AE_temp_HDR' /tmp/FFmpeg_settings
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template_HDR.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep    
    else
    if grep 'CC' <<< $(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)")
    then
    numb=$(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)" | awk 'FNR == 1 {print $5; }')
    if (( $(echo "$numb > 2015.2" |bc -l) )); 
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_templateCC.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    fi
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;20;95t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"


while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}$(tput setaf 1)AE project settings$(tput sgr0)
    ------------------------------
 
    $(tput bold)(c)$(tput sgr0) I want to change AE project settings template				 
    $(tput bold)(r)$(tput sgr0) Continue without changes  

    $(tput bold)$(tput setaf 1)(p) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) quit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n1
    case "$REPLY" in

    "c")  
#Reset file if needed
if ! grep 'any_X' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
then
perl -pi -e 's/'"$(LC_ALL=C cat -v "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep | tr ' ' '\n' | grep -o -m 1 '[^ ]*C0000')"'/any_X/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
fi

#list dng directories
    cd "$(cat /tmp/DUALISO/"path_1")"
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
    cd -
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
#creating a dummy audio file if not present
    if ! ls "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav 
    then
    ffmpeg -t 1 -f s16le -acodec pcm_s16le -ac 2 -i /dev/zero -acodec copy "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    fi
#Add correct filename
perl -pi -e 's/any_X/'"$name"'/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
open "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep &

echo > /tmp/DUALISO/AE_question
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
;;

    "r") 
rm /tmp/magic_l_prores/AE_question 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
rm /tmp/magic_l_prores/AE_question 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
else
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_white_level
rm /tmp/FFmpeg_settings
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; AE_HDR= ; DEL_DNG=
fi
;;

    "25")
cd "$(cat /tmp/DUALISO/path_1)"
open $(find . -maxdepth 2 -name '*C0000_000000.dng')
cd -
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "X")
if [ -f /tmp/DUALISO/DEL_DNG ]
then
rm /tmp/DUALISO/DEL_DNG
DEL_DNG=
else
echo > /tmp/DUALISO/DEL_DNG
DEL_DNG=$(echo "$bold""$green"added!"$normal")
fi
;;

    "mp")
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer1.app/Contents/MacOS/mlrawviewer "$(cat /tmp/DUALISO/"path_1")" & sleep 2
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
while [ -n "$(pgrep mlrawviewer </dev/null)" ];
do sleep 1
done
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
;;

    "ho") 
printf '\e[8;16;90t'
printf '\e[3;410;100t'
clear
echo $(tput bold)A short guide how to work with ProRes output menu
echo 
echo $(tput bold)$(tput setaf 1)Select a number and hit enter to add settings
echo Reselect any added settings and hit enter to erase$(tput sgr0)   
echo
echo $(tput bold)1$(tput sgr0) - Choose a $(tput bold)ProRes4444, ProRes Proxy output$(tput sgr0) or select from both
echo $(tput bold)2$(tput sgr0) - Select any $(tput bold)other settings$(tput sgr0) you desire$(tput sgr0) 
echo $(tput bold)3$(tput sgr0) - You can add up to three extra 3D luts"("cube")" in your output folders for creating
echo     further looks."("ProRes4444 and Proxy folders inside your parent folder")"$(tput sgr0)
echo $(tput bold)4$(tput sgr0) - Whenever ready press $(tput bold)$(tput setaf 1)"(r)"${bold}$(tput setaf 1)  run Switch$(tput sgr0)
echo
echo
echo $(tput bold)$(tput setaf 1)${bold}$(tput setaf 1)Hit any key to return to ProRes output menu$(tput sgr0)
    read -n1
    case "$REPLY" in

    * )  
printf '\e[8;57;65t'
printf '\e[3;450;0t'
;;
    esac
;;

#tif spit raw to tif
    "ti")
rm /tmp/DUALISO/tif_back
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command 1> /dev/null 2>&1 &
printf '\e[8;15;45t'
printf '\e[3;650;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

br=

if ls /tmp/DUALISO/BRIGHTER
then
br=$(cat /tmp/DUALISO/BRIGHTER)
fi


while :
do 

    clear
    cat<<EOF
    -------------
    $(tput bold)tif spit$(tput sgr0)
    -------------

    $(tput bold)$(tput setaf 1)(q) Quit tif spit$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) Run tif spit again$(tput sgr0)
    $(tput bold)$(tput setaf 1)(b) Increase brightness$(tput sgr0) $(tput bold)$(tput setaf 4)$br
    $(tput bold)$(tput setaf 1)(d) Increase darkness$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p) Pixel picker$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

#go back to prores menu
    "q") 
echo > /tmp/DUALISO/tif_back  
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command
;;

    "r")
#check for pixel pick list
    if ls "$out"$(date +%F)_ProRes4444/*.txt
    then
    tail -n +2 "$out"$(date +%F)_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out"$(date +%F)_ProRes4444/allbadpixels.map
    rm "$out"$(date +%F)_ProRes4444/*.txt
    fi
    if ls "$out""$date"_ProRes4444/*.xls
    then
    mv "$out""$date"_ProRes4444/*.xls "$out""$date"_ProRes4444/allbadpixels.txt
    tail -n +2 "$out""$date"_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out""$date"_ProRes4444/allbadpixels.map
    rm "$out""$date"_ProRes4444/*.txt
    fi
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command 1> /dev/null 2>&1 &
;;


    "b")
#check for pixel pick list
    if ls "$out"$(date +%F)_ProRes4444/*.txt 2>/dev/null
    then
    tail -n +2 "$out"$(date +%F)_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out"$(date +%F)_ProRes4444/allbadpixels.map
    rm "$out"$(date +%F)_ProRes4444/*.txt
    fi
    if ls "$out""$date"_ProRes4444/*.xls 2>/dev/null
    then
    mv "$out""$date"_ProRes4444/*.xls "$out""$date"_ProRes4444/allbadpixels.txt 
    tail -n +2 "$out""$date"_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out""$date"_ProRes4444/allbadpixels.map
    rm "$out""$date"_ProRes4444/*.txt
    fi
    if ! grep '2\|4\|6' /tmp/DUALISO/BRIGHTER 2>/dev/null
    then
    echo 2 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo +2)
    else
    if grep '2' /tmp/DUALISO/BRIGHTER
    then
    echo 4 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo +4)
    else
    if grep '4' /tmp/DUALISO/BRIGHTER 
    then
    echo 6 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo +6)
    else
    if grep '6' /tmp/DUALISO/BRIGHTER
    then
    rm /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=
    fi
    fi
    fi
    fi
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command 1> /dev/null 2>&1 &
;;


    "d")
#check for pixel pick list
    if ls "$out"$(date +%F)_ProRes4444/*.txt 2>/dev/null
    then
    tail -n +2 "$out"$(date +%F)_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out"$(date +%F)_ProRes4444/allbadpixels.map
    rm "$out"$(date +%F)_ProRes4444/*.txt
    fi
    if ls "$out""$date"_ProRes4444/*.xls 2>/dev/null
    then
    mv "$out""$date"_ProRes4444/*.xls "$out""$date"_ProRes4444/allbadpixels.txt
    tail -n +2 "$out""$date"_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out""$date"_ProRes4444/allbadpixels.map
    rm "$out""$date"_ProRes4444/*.txt
    fi
    if ! grep '8\|5\|3' /tmp/DUALISO/BRIGHTER 2>/dev/null
    then
    echo 0.8 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo -2)
    else
    if grep '8' /tmp/DUALISO/BRIGHTER
    then
    echo 0.5 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo -4)
    else
    if grep '5' /tmp/DUALISO/BRIGHTER 
    then
    echo 0.3 > /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=$(echo -6)
    else
    if grep '3' /tmp/DUALISO/BRIGHTER
    then
    rm /tmp/DUALISO/BRIGHTER 2>/dev/null
    br=
    fi
    fi
    fi
    fi
   
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command 1> /dev/null 2>&1 &
;;

    "p")
if ! ls /Applications/ImageJ/ImageJ.app
then
printf '\e[8;20;65t'
printf '\e[3;650;0t'
clear 
echo "You need imageJ installed and the PointPicker plugin installed
for the Pixel picker to work."
sleep 2
open "$(cat /tmp/DUALISO/path_2)"ImageJ.txt
printf '\e[8;15;45t'
printf '\e[3;650;0t'
fi
cd "$(cat /tmp/DUALISO/path_1)"/"$out"$(date +%F)_ProRes4444/
open -a /Applications/ImageJ/ImageJ.app $(ls *.tif | head -1) &
cd .. 
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

    "E")
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; AE_HDR= ; DEL_DNG=
rm /tmp/DUALISO/DEL_DNG
rm /tmp/FFmpeg_white_level
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_settings 1> /dev/null 2>&1 &
rm /tmp/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm /tmp/_X_pres_SCALE 1> /dev/null 2>&1 &
rm /tmp/prox_SCALE 1> /dev/null 2>&1 &
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

#X to ProRes
    "o") 

#Erase full auto setting
if ls /tmp/DUALISO/FULL_AUTO
then
if ls /tmp/_X_Pro*
then
X_pro_a=
rm /tmp/_X_ProRes4444 1> /dev/null 2>&1 &
rm /tmp/_X_Proxy 1> /dev/null 2>&1 &
clear 
echo "$(tput setaf 1)""Erased ProRes auto settings"
sleep 1
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
fi

printf '\e[8;45;65t'
printf '\e[3;450;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

#create base folders
if ls /tmp/output
then
mkdir -p "$(cat /tmp/output)"/$(date +%F)_X_Proxy
mkdir -p "$(cat /tmp/output)"/$(date +%F)_X_ProRes4444
else
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
fi

copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale ; aspect= ; PRscale ; PRaspect= ; denoise= ; sharpen=

if grep 'copy' /tmp/_X_ProRes4444 
then
copy=$(echo "$bold""$green"added!"$normal")
fi
if grep 'logN' /tmp/_X_ProRes4444 
then
logN=$(echo "$bold""$green"added!"$normal")
fi
if grep 'login' /tmp/_X_ProRes4444 
then
login=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Clog' /tmp/_X_ProRes4444 
then
Clog=$(echo "$bold""$green"added!"$normal")
fi
if grep 'logC' /tmp/_X_ProRes4444 
then
logC=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Xaces' /tmp/_X_ProRes4444 
then
Xaces=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ] 
then
PRscale=$(echo "$bold""$green"added!"$normal")
PRaspect=$(cat /tmp/_X_prores_SCALE)
else
PRscale=
PRaspect=
fi

if grep 'copypr' /tmp/_X_Proxy 
then
copypr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'logNpr' /tmp/_X_Proxy 
then
logNpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'loginpr' /tmp/_X_Proxy 
then
loginpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Clogpr' /tmp/_X_Proxy 
then
Clogpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'logCpr' /tmp/_X_Proxy 
then
logCpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Xacespr' /tmp/_X_Proxy 
then
Xacespr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'codec_lt' /tmp/_X_Proxy 
then
codec_lt=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat /tmp/_X_denoise) = x ] 
then
denoise=$(echo "$bold""$green"denoise!"$normal")
else
denoise=
fi
if ! [ x$(cat /tmp/_X_sharpen) = x ] 
then
sharpen=$(echo "$bold""$green"sharpen!"$normal")
else
sharpen=
fi
if grep 'HDR' /tmp/_X_HDR
then
HDR=$(echo "$bold""$green"added!"$normal")
fi
if grep 'halfhdr' /tmp/_X_HDR
then
halfhdr=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ] 
then
scale=$(echo "$bold""$green"added!"$normal")
aspect=$(cat /tmp/_X_proxy_SCALE)
else
scale=
aspect=
fi

while :
do 

    clear
    cat<<EOF
    -----------
    $(tput bold)X to ProRes$(tput sgr0)(mov,mts,HDR etc)
    -----------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)
	
-- ProRes4444 output --
    $(tput bold)(01) export to ProRes4444$(tput sgr0)   $copy
    $(tput bold)(02) rec709 to logNeutral$(tput sgr0)  $logN	
    $(tput bold)(03) logNeutral inverse$(tput sgr0)  $login
    $(tput bold)(04) rec709 to C-log$(tput sgr0)  $Clog 
    $(tput bold)(05) rec709 to logC$(tput sgr0)  $logC
    $(tput bold)(06) aces$(tput sgr0)  $Xaces
-- other settings(ProRes4444)
    $(tput bold)(07) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$PRaspect$(tput sgr0) $PRscale

-- ProRes Proxy output --
    $(tput bold)(08) export to Proxy$(tput sgr0)   $copypr
    $(tput bold)(09) rec709 to logNeutral$(tput sgr0)  $logNpr
    $(tput bold)(10) logNeutral inverse$(tput sgr0)  $loginpr
    $(tput bold)(11) rec709 to C-log$(tput sgr0)  $Clogpr 
    $(tput bold)(12) rec709 to logC$(tput sgr0)  $logCpr
    $(tput bold)(13) aces$(tput sgr0)  $Xacespr
-- other settings(proxy) --
    $(tput bold)(14) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$aspect$(tput sgr0) $scale 
    $(tput bold)(15) Switch to ProRes LT codec$(tput sgr0)  $codec_lt

-- Denoise and sharpen filters --
    $(tput bold)(16) set denoise and sharpening$(tput sgr0) $denoise $sharpen   
-- HDR output(affects both prores4444 and proxy) --
    $(tput bold)(17) HDR footage$(tput sgr0)(e.g 100/1600iso) $HDR
    $(tput bold)(18) drop frames$(tput sgr0)(50fps to 25fps etc) $halfhdr

    $(tput bold)$(tput setaf 1)(ho) HOWTO$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ti) tif previews$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(o)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'copy' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g' 
copy=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "copy" >> /tmp/_X_ProRes4444
copy=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g'
logN= ; login= ; Clog= ; logC= ; Xaces=
fi
;;

    "02")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'logN' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
logN=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "logN" >> /tmp/_X_ProRes4444
logN=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g'
copy= ; login= ; Clog= ; logC= ; Xaces=
fi
;;

    "03")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'login' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g' 
login=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "login" >> /tmp/_X_ProRes4444
login=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g'
copy= ; logN= ; Clog= ; logC= ; Xaces=
fi
;;

    "04")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'Clog' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g' 
Clog=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Clog" >> /tmp/_X_ProRes4444
Clog=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g'
copy= ; logN= ; login= ; logC= ; Xaces=
fi
;;

    "05")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'logC' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g' 
logC=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "logC" >> /tmp/_X_ProRes4444
logC=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g'
copy= ; logN= ; login= ; Clog= ; Xaces=
fi
;;

    "06")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444
if grep 'Xaces' /tmp/_X_ProRes4444 
then
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Xaces//g' 
Xaces=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Xaces" >> /tmp/_X_ProRes4444
Xaces=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/copy//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logN//g' 
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/login//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/Clog//g'
find /tmp/_X_ProRes4444 | xargs perl -pi -e 's/logC//g'
copy= ; logN= ; login= ; Clog= ; logC= 
fi
;;



     "07")
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
then
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
else

printf '\e[8;16;60t'
printf '\e[3;410;100t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    ------
    $(tput bold)Scaler$(tput sgr0)
    ------

    $(tput bold)$(tput setaf 1)(1) Any footage$(tput sgr0)
    $(tput bold)$(tput setaf 1)(2) Crop mode 3x3 720p$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

    "1") 
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
then
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1 > /tmp/_X_prores_SCALE
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
then
PRscale=$(echo "$bold""$green"added!"$normal")
PRaspect=$(cat /tmp/_X_prores_SCALE)
else
PRscale=
PRaspect=
fi
fi
sleep 1 
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "2")
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
then
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1,setdar=16:6,deflate > /tmp/_X_prores_SCALE
if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
then
PRscale=$(echo "$bold""$green"added!"$normal")
PRaspect=$(cat /tmp/_X_prores_SCALE)
else
PRscale=
PRaspect=
fi
fi
sleep 1 
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
fi
;;



    "08")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'copypr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g' 
copypr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "copypr" >> /tmp/_X_Proxy
copypr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g' 
logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr=
fi
;;

    "09")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'logNpr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
logNpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "logNpr" >> /tmp/_X_Proxy
logNpr=$(echo "$bold""$green"added!"$normal") 
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g'
copypr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr=
fi
;;

    "10")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'loginpr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g' 
loginpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "loginpr" >> /tmp/_X_Proxy
loginpr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g'
copypr= ; logNpr= ; Clogpr= ; logCpr= ; Xacespr=
fi
;;

    "11")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'Clogpr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g' 
Clogpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Clogpr" >> /tmp/_X_Proxy
Clogpr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g'
copypr= ; logNpr= ; loginpr= ; logCpr= ; Xacespr=
fi
;;

    "12")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'logCpr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g' 
logCpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "logCpr" >> /tmp/_X_Proxy
logCpr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g'
copypr= ; logNpr= ; loginpr= ; Clogpr= ; Xacespr=
fi
;;

    "13")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'Xacespr' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/Xacespr//g' 
Xacespr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Xacespr" >> /tmp/_X_Proxy
Xacespr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_Proxy | xargs perl -pi -e 's/copypr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logNpr//g' 
find /tmp/_X_Proxy | xargs perl -pi -e 's/loginpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/Clogpr//g'
find /tmp/_X_Proxy | xargs perl -pi -e 's/logCpr//g'
copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= 
fi
;;

     "14")
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
then
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
else

printf '\e[8;16;60t'
printf '\e[3;410;100t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    ------
    $(tput bold)Scaler$(tput sgr0)
    ------

    $(tput bold)$(tput setaf 1)(1) Any footage$(tput sgr0)
    $(tput bold)$(tput setaf 1)(2) Crop mode 3x3 720p$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

    "1") 
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
then
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1 > /tmp/_X_proxy_SCALE
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
then
PRscale=$(echo "$bold""$green"added!"$normal")
PRaspect=$(cat /tmp/_X_proxy_SCALE)
else
PRscale=
PRaspect=
fi
fi
sleep 1 
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "2")
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
then
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Scale setting erased"$(tput sgr0) ; 
sleep 1
PRscale=
PRaspect=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify only width:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1,setdar=16:6,deflate > /tmp/_X_proxy_SCALE
if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
then
PRscale=$(echo "$bold""$green"added!"$normal")
PRaspect=$(cat /tmp/_X_proxy_SCALE)
else
PRscale=
PRaspect=
fi
fi
sleep 1 
printf '\e[8;45;65t'
printf '\e[3;450;0t'
echo > /tmp/DUALISO/tif_back 
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
fi
;;


    "15")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'codec_lt' /tmp/_X_Proxy 
then
find /tmp/_X_Proxy | xargs perl -pi -e 's/codec_lt//g' 
codec_lt=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "codec_lt" >> /tmp/_X_Proxy
codec_lt=$(echo "$bold""$green"added!"$normal")
fi
;;

    "16")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
printf '\e[8;25;60t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=

if grep 'hqdn3d=0:0:2:2' /tmp/_X_denoise
then
sl_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:4:4' /tmp/_X_denoise 
then
me_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:6:6' /tmp/_X_denoise 
then
st_h=$(echo "$bold""$green"added!"$normal")
fi

if grep 'unsharp=5:5:1.0:5:5:0.0' /tmp/_X_sharpen 
then
sl_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=7:7:0.8:7:7:0' /tmp/_X_sharpen 
then
me_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=9:9:1.0:9:9:0' /tmp/_X_sharpen 
then
st_s=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF

    ==============================
    ${bold}$(tput setaf 1)FFmpeg hqdn3d$(tput sgr0)
    ------------------------------
    $(tput bold)(1)$(tput sgr0) Slight denoising   $sl_h				 
    $(tput bold)(2)$(tput sgr0) Medium denoising   $me_h
    $(tput bold)(3)$(tput sgr0) Strong denoising   $st_h

    ==============================
    ${bold}$(tput setaf 1)FFmpeg sharpen(unsharp)$(tput sgr0)
    ------------------------------
    $(tput bold)(4)$(tput sgr0) Slight sharpening   $sl_s				 
    $(tput bold)(5)$(tput sgr0) Medium sharpening   $me_s
    $(tput bold)(6)$(tput sgr0) Strong sharpening   $st_s

    $(tput bold)$(tput setaf 1)(q) X to ProRes menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E) erase all settings$(tput sgr0)
					        					
Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

    "1") 
if grep 'hqdn3d=0:0:2:2' /tmp/_X_denoise 
then
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:2:2" >> /tmp/_X_denoise
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight denoising"$(tput sgr0) ; 
fi
;;

    "2")
if grep 'hqdn3d=0:0:4:4' /tmp/_X_denoise 
then
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:4:4" >> /tmp/_X_denoise
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium denoising"$(tput sgr0) ; 
fi
;;

    "3")
if grep 'hqdn3d=0:0:6:6' /tmp/_X_denoise 
then
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:6:6" >> /tmp/_X_denoise
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find /tmp/_X_denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong denoising"$(tput sgr0) ; 
fi
;;

    "4")
if grep 'unsharp=5:5:1.0:5:5:0.0' /tmp/_X_sharpen 
then
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=5:5:1.0:5:5:0.0" >> /tmp/_X_sharpen
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g'
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight sharpening"$(tput sgr0) ; 
fi
;;

    "5")
if grep 'unsharp=7:7:0.8:7:7:0' /tmp/_X_sharpen 
then
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=7:7:0.8:7:7:0" >> /tmp/_X_sharpen
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium sharpening"$(tput sgr0) ; 
fi
;;

    "6")
if grep 'unsharp=9:9:1.0:9:9:0' /tmp/_X_sharpen 
then
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=9:9:1.0:9:9:0" >> /tmp/_X_sharpen
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find /tmp/_X_sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong sharpening"$(tput sgr0) ; 
fi
;;



#go back to prores menu
    "q") 
echo > /tmp/DUALISO/tif_back  
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "E")
sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

    "17")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'HDR' /tmp/_X_HDR 
then
find /tmp/_X_HDR | xargs perl -pi -e 's/HDR//g'
HDR=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "HDR" >> /tmp/_X_HDR
HDR=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_HDR | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_02 | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_03 | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_04 | xargs perl -pi -e 's/halfhdr//g' 
halfhdr=
fi
;;

    "18")
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy
if grep 'halfhdr' /tmp/_X_HDR 
then
find /tmp/_X_HDR | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_02 | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_03 | xargs perl -pi -e 's/halfhdr//g'
find /tmp/_X_HDR_04 | xargs perl -pi -e 's/halfhdr//g' 
halfhdr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "halfhdr" >> /tmp/_X_HDR
echo "halfhdr" >> /tmp/_X_HDR_02
echo "halfhdr" >> /tmp/_X_HDR_03
echo "halfhdr" >> /tmp/_X_HDR_04
halfhdr=$(echo "$bold""$green"added!"$normal")
find /tmp/_X_HDR | xargs perl -pi -e 's/HDR//g'
HDR=
fi
;;

    "o")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r") 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "ho") 
printf '\e[8;16;90t'
printf '\e[3;410;100t'
clear
echo $(tput bold)A short guide how to work with ProRes output menu
echo 
echo $(tput bold)$(tput setaf 1)Select a number and hit enter to add settings
echo Reselect any added settings and hit enter to erase$(tput sgr0)   
echo
echo $(tput bold)1$(tput sgr0) - Choose a $(tput bold)ProRes4444, ProRes Proxy output$(tput sgr0) or select from both
echo $(tput bold)2$(tput sgr0) - Select any $(tput bold)other settings$(tput sgr0) you desire$(tput sgr0) 
echo $(tput bold)3$(tput sgr0) - You can add up to three extra 3D luts"("cube")" in your output folders for creating
echo     further looks."("ProRes4444 and Proxy folders inside your parent folder")"$(tput sgr0)
echo $(tput bold)4$(tput sgr0) - Whenever ready press $(tput bold)$(tput setaf 1)"(r)"${bold}$(tput setaf 1)  run Switch$(tput sgr0)
echo
echo
echo $(tput bold)$(tput setaf 1)${bold}$(tput setaf 1)Hit any key to return to ProRes output menu$(tput sgr0)
    read -n1
    case "$REPLY" in

    * )  
printf '\e[8;45;65t'
printf '\e[3;450;0t'
;;
    esac
;;

#tif spit X to tif
    "ti")
rm /tmp/DUALISO/tif_back
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command 1> /dev/null 2>&1 &
printf '\e[8;15;45t'
printf '\e[3;650;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    -------------
    $(tput bold)tif spit$(tput sgr0)
    -------------

    $(tput bold)$(tput setaf 1)(q) Quit tif spit$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) Run tif spit again$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n1
    case "$REPLY" in

#go back to prores menu
    "q") 
echo > /tmp/DUALISO/tif_back  
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command
;;

    "r")
. "$(cat /tmp/DUALISO/path_2)"tif_spit_other.command 1> /dev/null 2>&1 &
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

    "E")
copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale= ; aspect= ; PRscale= ; PRaspect= ; denoise= ; sharpen= ; PRscale= ; PRaspect= ; scale= ; aspect=
rm /tmp/_X_ProRes4444 1> /dev/null 2>&1 &
rm /tmp/_X_Proxy 1> /dev/null 2>&1 &
rm /tmp/_X_HDR 1> /dev/null 2>&1 &
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;



   "b")
printf '\e[8;16;75t'
printf '\e[3;650;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

while :
do 

    clear
    cat<<EOF
    -------------
    $(tput bold)bash section$(tput sgr0)
    -------------

    $(tput bold)(mov) HDR MOV files$(tput sgr0)(hugin align/ffmpeg tblend)
    $(tput bold)(cr2) HDR CR2,JPG,tif automation$(tput sgr0)(hugin/exiv2/HDRmerge/enfuse/ffmpeg)

    $(tput bold)$(tput setaf 1)(b) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n3
    case "$REPLY" in

#go back to prores menu
    "mov") 
echo > /tmp/DUALISO/HDR_MOV
cd "$(cat /tmp/DUALISO/path_1)" 
. "$(cat /tmp/DUALISO/path_2)"/bash/HDR_MOV.command &
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "cr2") 
echo > /tmp/DUALISO/HDR_CR2
cd "$(cat /tmp/DUALISO/path_1)" 
. "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command &

printf '\e[8;17;75t'
printf '\e[3;650;0t'

while :
do 
    clear
    cat<<EOF
    ---------------------
    $(tput bold)Choose a HDR workflow$(tput sgr0)
    ---------------------

    $(tput bold)(ti) $(tput setaf 0)Specify time gap$(tput sgr0)(default 5sec) $gap
    $(tput bold)(si) $(tput setaf 0)Silent mode$(tput sgr0) (less verbosity) $silent
    $(tput bold)(hm) $(tput setaf 0)HDRmerge$(tput sgr0)(CR2)
    $(tput bold)(en) $(tput setaf 0)Enfuse$(tput sgr0)(CR2,JPG,tif)
    $(tput bold)(ff) $(tput setaf 0)FFmpeg$(tput sgr0)(CR2,JPG,tif)
    $(tput bold)(ai) $(tput setaf 0)All in$(tput sgr0) compare output all workflows(Only CR2 files)

    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)

Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "si")
if [ -f silent ] 
then
rm silent
clear
echo $(tput bold)"removing"
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')" ]
    do
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    rm silent
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    mkdir -p A_ORIGINALS
    done
    rm /tmp/folder_pathsHDR.txt
    fi
sleep 1
silent=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo > silent
clear
echo "silent added"
sleep 1
silent=$(echo "$bold""$green"added!"$normal")
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')" ]
    do
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    echo > silent
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    mkdir -p A_ORIGINALS
    done
    rm /tmp/folder_pathsHDR.txt
    fi
fi
printf '\e[8;17;75t'
printf '\e[3;650;0t'
;;

    "ti")
if [ -f time ] 
then
rm time
clear
echo $(tput bold)"removing"
sleep 1
gap=
else
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify time gap:$(tput sgr0)$(tput bold)\(e.g$(tput sgr0) 12 and hit enter\)"
read input_variable
echo "time gap is set to: $(tput bold)$(tput setaf 4)$input_variable sec"$(tput sgr0)
printf "%s\n" "$input_variable" >> time
gap=$(tput bold)$(tput setaf 4)$(cat time)sec$(tput sgr0)
fi
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 2')" ]
    do
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    cp "$(cat /tmp/DUALISO/path_1)"/time ./
    mkdir -p A_ORIGINALS
    done
    rm /tmp/folder_pathsHDR.txt
    fi
printf '\e[8;16;75t'
printf '\e[3;650;0t'
;;

    "hm") 
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 2')" ]
    do
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    mkdir -p A_ORIGINALS
    echo > HDRmerge
    rm enfuse
    rm FFmpeg
    rm all_in
    done
    rm /tmp/folder_pathsHDR.txt
    fi
echo > /tmp/DUALISO/HDR_CR2
cd "$(cat /tmp/DUALISO/path_1)"
sleep 1 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
echo > HDRmerge
rm enfuse
rm FFmpeg
rm all_in
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
#start processing
chmod u=rwx HDR_match.command 
sleep 1 && open HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
;;

    "en") 
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 2')" ]
    do
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    mkdir -p A_ORIGINALS
    echo > enfuse
    rm HDRmerge
    rm FFmpeg
    rm all_in
    done
    rm /tmp/folder_pathsHDR.txt
    fi
echo > /tmp/DUALISO/HDR_CR2
cd "$(cat /tmp/DUALISO/path_1)"
sleep 1 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
echo > enfuse
rm HDRmerge
rm FFmpeg
rm all_in
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
#start processing
chmod u=rwx HDR_match.command 
sleep 1 && open HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
;;

    "ff") 
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 2')" ]
    do
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    mkdir -p A_ORIGINALS
    echo > FFmpeg
    rm HDRmerge
    rm enfuse
    rm all_in
    done
    rm /tmp/folder_pathsHDR.txt
    fi
echo > /tmp/DUALISO/HDR_CR2
cd "$(cat /tmp/DUALISO/path_1)"
sleep 1 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
echo > FFmpeg
rm enfuse
rm HDRmerge
rm all_in
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
#start processing
chmod u=rwx HDR_match.command 
sleep 1 && open HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
;;

    "ai") 
#iterate in folder tree
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then 
    cp /tmp/folder_paths.txt /tmp/folder_pathsHDR.txt
    while [ -d "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 2')" ]
    do
    echo "$(tail -n +2 /tmp/folder_pathsHDR.txt )" > /tmp/folder_pathsHDR.txt
    cd "$(cat /tmp/folder_pathsHDR.txt | awk 'FNR == 1')"
    mkdir -p A_ORIGINALS
    echo > all_in
    rm HDRmerge
    rm enfuse
    rm FFmpeg
    done
    rm /tmp/folder_pathsHDR.txt
    fi
echo > /tmp/DUALISO/HDR_CR2
cd "$(cat /tmp/DUALISO/path_1)"
sleep 1 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
echo > all_in
rm enfuse
rm HDRmerge
rm FFmpeg
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
#start processing
chmod u=rwx HDR_match.command 
sleep 1 && open HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
done 
;;

    "b")
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done

;;

   "ma")
cd "$(cat /tmp/DUALISO/path_1)"
if [ -f "$(cat /tmp/mlvapp)"/Contents/MacOS/MLV\ App ]
then
open -a "$(cat /tmp/mlvapp)"/Contents/MacOS/MLV\ App *.MLV & 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
printf '\e[8;10;63t'
printf '\e[3;410;100t'
clear
echo  $(tput bold)"Your MLV files will open soon!"$(tput setaf 1)
sleep 2
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ]
    then
    rm -r A_ORIGINALS
    fi
osascript -e 'tell application "Terminal" to close first window' & exit
else
rm /tmp/mlvapp
printf '\e[8;10;63t'
printf '\e[3;410;100t'
clear
echo  $(tput bold)"Set your Mlv App location"
sleep 1
echo ""
echo  $(tput bold)"Once set your MLV files will open in Mlv App"$(tput setaf 1)
sleep 2
#add file so automator know what to choose in script
echo > /tmp/DUALISO/mlvapp_select
open "$(cat /tmp/DUALISO/path_2)"file_select.app
osascript -e 'tell application "Terminal" to close first window' & exit
fi
;;

   "ml")
#MLVFS
#root folder name
root=$(grep -o '[^/]*$' /tmp/DUALISO/"path_1")

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;59;110t'
printf '\e[3;410;0t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

cs2= ; cs3= ; cs5= ; bp= ; rbp= ; fpn= ; str ; def= ; pre= ; dua= ; ama= ; mea= ; noa= ; ali= ; fpz= ; fps= ; HL= ; NOH= ; TAG= ; AE= ; AE_HDR=

if grep 'cs2x2' /tmp/"$root"_settings.txt 
then 
cs2=$(echo "$bold""$green"X"$normal")
fi
if grep 'cs3x3' /tmp/"$root"_settings.txt 
then 
cs3=$(echo "$bold""$green"X"$normal")
fi
if grep 'cs5x5' /tmp/"$root"_settings.txt 
then 
cs5=$(echo "$bold""$green"X"$normal")
fi
if ! grep 'really-bad-pix' /tmp/"$root"_settings.txt 
then 
if grep 'bad-pix' /tmp/"$root"_settings.txt 
then 
bp=$(echo "$bold""$green"X"$normal")
fi
fi
if grep 'really-bad-pix' /tmp/"$root"_settings.txt 
then 
rbp=$(echo "$bold""$green"X"$normal")
fi
if grep 'fix-pattern-noise' /tmp/"$root"_settings.txt 
then 
fpn=$(echo "$bold""$green"X"$normal")
fi
if grep 'stripes' /tmp/"$root"_settings.txt 
then 
str=$(echo "$bold""$green"X"$normal")
fi
if grep 'deflicker' /tmp/"$root"_settings.txt 
then 
def=$(echo "$bold""$green"X"$normal")
fi


if grep 'preview' /tmp/"$root"_settings.txt 
then 
pre=$(echo "$bold""$green"X"$normal")
else
if grep 'dual-iso' /tmp/"$root"_settings.txt 
then 
dua=$(echo "$bold""$green"X"$normal")
fi
fi
if grep '2' <<< "$(grep -o '\<dual\>' /tmp/"$root"_settings.txt | wc -l)"
then
dua=$(echo "$bold""$green"X"$normal")
fi
if grep 'amaze-edge' /tmp/"$root"_settings.txt 
then 
ama=$(echo "$bold""$green"X"$normal")
fi
if grep 'mean23' /tmp/"$root"_settings.txt 
then 
mea=$(echo "$bold""$green"X"$normal")
fi
if grep 'no-alias-map' /tmp/"$root"_settings.txt 
then 
noa=$(echo "$bold""$green"X"$normal")
fi
if ! grep 'no-alias-map' /tmp/"$root"_settings.txt 
then
if grep 'alias-map' /tmp/"$root"_settings.txt 
then 
ali=$(echo "$bold""$green"X"$normal")
fi
fi
if grep 'fps' /tmp/"$root"_settings.txt 
then 
fpz=$(echo "$bold""$green"X"$normal")
fps=$(grep 'fps' /tmp/"$root"_settings.txt | cut -d "=" -f2)
else
fps=
fi
if ls /tmp/SCALETAG
then
TAG=$(echo "$bold""$green"X"$normal")
fi

if grep 'AE_template' /tmp/FFmpeg_settings 
then
AE=$(echo "$bold""$green"added!"$normal")
fi
if grep 'AE_temp_HDR' /tmp/FFmpeg_settings 
then
AE_HDR=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    ==============
    ${bold}$(tput setaf 1)MLVFS workflow$(tput sgr0)             (Install MLVFS or this menu won,t work)
    --------------
    ${bold}Start off by selecting processing options. When done $(tput bold)$(tput setaf 1)Activate MLVFS$(tput sgr0) $(tput bold)then $(tput setaf 1)run Switch$(tput sgr0) 
    $(tput bold)note! Reenter selection to erase!

$(tput bold)input: $(tput setaf 4)$(cat /tmp/DUALISO/"path_1")/$(tput sgr0)

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)

${bold}- Processing options:$(tput sgr0)
   $cs2 $(tput bold)(01)--cs2x2$(tput sgr0)                2x2 chroma smoothing
   $cs3 $(tput bold)(02)--cs3x3$(tput sgr0)                3x3 chroma smoothing
   $cs5 $(tput bold)(03)--cs5x5$(tput sgr0)                5x5 chroma smoothing
   $bp $(tput bold)(04)--bad-pix$(tput sgr0)              Fix bad pixels (autodetected)
   $rbp $(tput bold)(05)--really-bad-pix$(tput sgr0)       Aggressive bad pixel fix
   $fpn $(tput bold)(06)--fix-pattern-noise$(tput sgr0)    Fix row/column noise in shadows (slow)
   $str $(tput bold)(07)--stripes$(tput sgr0)              Vertical stripe correction in highlights (nonuniform column gains)
   $def $(tput bold)(08)--deflicker=%d$(tput sgr0)         Per-frame exposure compensation for flicker-free video
                           (your raw processor must interpret the BaselineExposure DNG tag)

${bold}- Dual ISO options:$(tput sgr0)
   $pre $(tput bold)(09)--dual-iso-preview$(tput sgr0)     Preview Dual ISO files (fast)
   $dua $(tput bold)(10)--dual-iso$(tput sgr0)             Render Dual ISO files (high quality)
   $ama $(tput bold)(11)--amaze-edge$(tput sgr0)           Dual ISO: interpolation method (high quality)
   $mea $(tput bold)(12)--mean23$(tput sgr0)               Dual ISO: interpolation method (fast)
   $noa $(tput bold)(13)--no-alias-map$(tput sgr0)         Dual ISO: disable alias map
   $ali $(tput bold)(14)--alias-map$(tput sgr0)            Dual ISO: enable alias map 

${bold}- Web GUI options:$(tput sgr0)
   $fpz $(tput bold)(15)--fps=$red$fps$(tput sgr0)                 FPS used for playback in web GUI

${bold}- 5D mark III white level(more highlight data)$(tput sgr0)
    $(tput bold)(16) white level 16383$(tput sgr0)     Expands dynamic range from 15000 to 16383
    $(tput bold)(17) white level 15000$(tput sgr0)     Reverts whitelevel to 15000

${bold}- These settings only apply after activation of MLVFS $(tput setaf 1)(A)$(tput sgr0)
   $TAG $(tput bold)(18) reset scale tag$(tput sgr0)       Useful if footage looks skewed(e.g crop_rec) Needs restart$(tput setaf 1)$(tput bold)(A)$(tput sgr0)
    $(tput bold)(19) auto white balance$(tput sgr0)    Calculate and apply auto white balance to symlinked dng files(slow)
    $(tput bold)(20) camera model name$(tput sgr0)     Corrects camera model name tag to symlinked dng files. Adobe standard(slow)
    $(tput bold)(21) crop_rec pixel list$(tput sgr0)   Adds the crop_rec focus pixel list. Reselect $(tput bold)(21)$(tput sgr0) to revert to mv720 list 

-- AE template -- 
    $(tput bold)(22) Export footage through AE(aerender)$(tput sgr0) $AE
    $(tput bold)(23) Export HDR footage through AE(aerender)$(tput sgr0) $AE_HDR

    $(tput bold)$(tput setaf 1)(A)   activate MLVFS$(tput sgr0)       Moves MLV files to A_ORIGINALS and creates a MLVFS mount. Symlinked dngs
    $(tput bold)$(tput setaf 1)(mp)  MlRawViewer$(tput sgr0)          Opens up MlrawViewer media player
    $(tput bold)$(tput setaf 1)(p)   ProRes and previews$(tput sgr0)  Create previews or ProRes files
    $(tput bold)$(tput setaf 1)(EJ)  eject MLVFS$(tput sgr0)	       Ejects your MLVFS partition mount and erase symlinked dng folders
    $(tput bold)$(tput setaf 1)(S)   select new input$(tput sgr0)     Select a folder with MLV files	
    $(tput bold)$(tput setaf 1)(E)   erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ml)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)   exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)   run Switch$(tput sgr0)            Select settings and $(tput bold)$(tput setaf 1)(A) Activate MLVFS$(tput sgr0) before running Switch(last step)

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in


    "01")
if grep 'cs2x2' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --cs2x2//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--cs2x2//g' /tmp/"$root"_settings.txt
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs2x2" >> /tmp/"$root"_settings.txt
cs2=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --cs3x3//g' /tmp/"$root"_settings.txt 
perl -pi -e 's/ --cs5x5//g' /tmp/"$root"_settings.txt
cs3=
cs5=
fi
;;

    "02")
if grep 'cs3x3' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --cs3x3//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--cs3x3//g' /tmp/"$root"_settings.txt
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs3x3" >> /tmp/"$root"_settings.txt
cs3=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --cs2x2//g' /tmp/"$root"_settings.txt 
perl -pi -e 's/ --cs5x5//g' /tmp/"$root"_settings.txt
cs2=
cs5=
fi
;;

    "03")
if grep 'cs5x5' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --cs5x5//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--cs5x5//g' /tmp/"$root"_settings.txt
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs5x5" >> /tmp/"$root"_settings.txt
cs5=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --cs2x2//g' /tmp/"$root"_settings.txt 
perl -pi -e 's/ --cs3x3//g' /tmp/"$root"_settings.txt
perl -pi -e 's/ --no-cs//g' /tmp/"$root"_settings.txt
nocs=
cs2=
cs3=
fi
;;

    "04")
if ! grep 'really' /tmp/"$root"_settings.txt 
then
if grep 'bad-pix' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --bad-pix//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--bad-pix//g' /tmp/"$root"_settings.txt
bp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --bad-pix" >> /tmp/"$root"_settings.txt
bp=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --really-bad-pix//g' /tmp/"$root"_settings.txt 
rbp=
fi
else
echo -n " --bad-pix" >> /tmp/"$root"_settings.txt
bp=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --really-bad-pix//g' /tmp/"$root"_settings.txt 
rbp=
fi 
;;

    "05")
if grep 'really' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --really-bad-pix//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--really-bad-pix//g' /tmp/"$root"_settings.txt
rbp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --really-bad-pix" >> /tmp/"$root"_settings.txt
rbp=$(echo "$bold""$green"X"$normal")
perl -pi -e 's/ --bad-pix//g' /tmp/"$root"_settings.txt 
bp=
fi
;;

    "06")
if grep 'fix-pattern-noise' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --fix-pattern-noise//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--fix-pattern-noise//g' /tmp/"$root"_settings.txt
fpn=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --fix-pattern-noise" >> /tmp/"$root"_settings.txt
fpn=$(echo "$bold""$green"X"$normal") 
fi
;;

    "07")
if grep 'stripes' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --stripes//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--stripes//g' /tmp/"$root"_settings.txt
str=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --stripes" >> /tmp/"$root"_settings.txt
str=$(echo "$bold""$green"X"$normal") 
fi
;;



    "08")
if grep 'deflicker' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ '"$(grep 'deflicker' /tmp/"$root"_settings.txt | awk 'FNR == 1 {print $1}')"'//g' /tmp/"$root"_settings.txt
perl -pi -e 's/'"$(grep 'deflicker' /tmp/"$root"_settings.txt | awk 'FNR == 1 {print $1}')"'//g' /tmp/"$root"_settings.txt
def=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else  
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify deflicker output:$(tput sgr0)($(tput bold)e.g$(tput sgr0) between 1000-5000)"
read input_variable
echo "Your deflicker output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo -n " --deflicker"=$input_variable >> /tmp/"$root"_settings.txt
def=$(echo "$bold""$green"X"$normal") 
fi
sleep 1 
printf '\e[8;59;110t'
printf '\e[3;410;0t'
;;


    "09")
if grep 'preview' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --dual-iso-preview//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--dual-iso-preview//g' /tmp/"$root"_settings.txt
pre=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
perl -pi -e 's/ --dual-iso-preview//g' /tmp/"$root"_settings.txt
echo -n " --dual-iso-preview" >> /tmp/"$root"_settings.txt
pre=$(echo "$bold""$green"X"$normal") 
fi 
;;

    "10")
if ! grep 'preview' /tmp/"$root"_settings.txt 
then 
if grep 'dual-iso' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --dual-iso//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--dual-iso//g' /tmp/"$root"_settings.txt
dua=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --dual-iso" >> /tmp/"$root"_settings.txt
dua=$(echo "$bold""$green"X"$normal") 
fi
else
perl -pi -e 's/ --dual-iso-preview//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--dual-iso-preview//g' /tmp/"$root"_settings.txt
if grep 'dual-iso' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --dual-iso//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--dual-iso//g' /tmp/"$root"_settings.txt
echo -n " --dual-iso-preview" >> /tmp/"$root"_settings.txt
dua=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ;
else 
echo -n " --dual-iso" >> /tmp/"$root"_settings.txt
echo -n " --dual-iso-preview" >> /tmp/"$root"_settings.txt
dua=$(echo "$bold""$green"X"$normal")
fi
fi
;;

    "11")
if grep 'amaze-edge' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --amaze-edge//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--amaze-edge//g' /tmp/"$root"_settings.txt
ama=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --amaze-edge" >> /tmp/"$root"_settings.txt
ama=$(echo "$bold""$green"X"$normal") 
perl -pi -e 's/ --mean23//g' /tmp/"$root"_settings.txt
mea=
fi
;;

    "12")
if grep 'mean23' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --mean23//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--mean23//g' /tmp/"$root"_settings.txt
mea=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --mean23" >> /tmp/"$root"_settings.txt
mea=$(echo "$bold""$green"X"$normal") 
perl -pi -e 's/ --amaze-edge//g' /tmp/"$root"_settings.txt
ama=
fi
;;

    "13")
if grep 'no-alias-map' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --no-alias-map//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--no-alias-map//g' /tmp/"$root"_settings.txt
noa=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --no-alias-map" >> /tmp/"$root"_settings.txt
noa=$(echo "$bold""$green"X"$normal") 
perl -pi -e 's/ --alias-map//g' /tmp/"$root"_settings.txt
ali=
fi
;;

    "14")
if ! grep 'no-a' /tmp/"$root"_settings.txt 
then 
if grep 'alias-map' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ --alias-map//g' /tmp/"$root"_settings.txt
perl -pi -e 's/--alias-map//g' /tmp/"$root"_settings.txt
ali=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --alias-map" >> /tmp/"$root"_settings.txt
ali=$(echo "$bold""$green"X"$normal") 
perl -pi -e 's/ --no-alias-map//g' /tmp/"$root"_settings.txt
noa=
fi
else
echo -n " --alias-map" >> /tmp/"$root"_settings.txt
ali=$(echo "$bold""$green"X"$normal") 
perl -pi -e 's/ --no-alias-map//g' /tmp/"$root"_settings.txt
noa=
fi
;;


    "15")
if grep 'fps' /tmp/"$root"_settings.txt 
then 
perl -pi -e 's/ '"$(grep 'fps' /tmp/"$root"_settings.txt | awk 'FNR == 1 {print $1}')"'//g' /tmp/"$root"_settings.txt
perl -pi -e 's/'"$(grep 'fps' /tmp/"$root"_settings.txt | awk 'FNR == 1 {print $1}')"'//g' /tmp/"$root"_settings.txt
fpz=
fps=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else  
printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify frames per second:$(tput sgr0)($(tput bold)"
read input_variable
echo "Your fps output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo -n " --fps"=$input_variable >> /tmp/"$root"_settings.txt
fpz=$(echo "$bold""$green"X"$normal") 
fps=$(grep 'fps' /tmp/"$root"_settings.txt | cut -d "=" -f2)
fi
sleep 1 
printf '\e[8;59;110t'
printf '\e[3;410;0t'
;;


    "16")
    ls -A1 "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.MLV *.mlv > /tmp/DUALISO/WL_MLV_A
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command &>/dev/null &
;;


    "17")
    ls -A1 "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.MLV *.mlv > /tmp/DUALISO/WL_MLV_B
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command &>/dev/null &
;;



    "18")
    if ls /tmp/SCALETAG
    then 
    printf '\e[8;16;65t'
    printf '\e[3;410;100t' 
    clear 
    echo $(tput bold)"MLVFS Scale tag defaults. 
Please restart mlvfs $(tput setaf 1)(A)$(tput sgr0)"
    rm /tmp/SCALETAG
    rm /tmp//DUALISO/crop_rec
    TAG=
    sleep 2
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    else
    echo > /tmp/SCALETAG
    TAG=$(echo "$bold""$green"X"$normal")
    printf '\e[8;16;65t'
    printf '\e[3;410;100t'  
    clear 
    echo $(tput bold)"Reset all scale tags$(tput sgr0)" 
    sleep 1
    echo $(tput bold)"Please restart mlvfs $(tput setaf 1)(A)$(tput sgr0)" 
    sleep 2
    echo $(tput bold)"Reenter (18) for default settings$(tput sgr0)"
    sleep 1
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    fi
;;


    "19")
    if ls /tmp/DUALISO/AUTOB
    then 
    printf '\e[8;16;65t'
    printf '\e[3;410;100t' 
    clear 
    echo $(tput bold)"Auto wb processing being killed"$(tput sgr0)
    rm /tmp/DUALISO/AUTOB
    sleep 2
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    else
    ls "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount > /tmp/DUALISO/AUTOB
    printf '\e[8;16;53t'
    printf '\e[3;410;100t'  
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command &>/dev/null &
    clear 
    echo $(tput bold)"Auto white balance being added
$(tput sgr0)Reenter $(tput bold)(19)$(tput sgr0) to kill awb process"
    sleep 3
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    fi
;;


    "20")
    if ls /tmp/DUALISO/CAMMODEL
    then 
    printf '\e[8;16;65t'
    printf '\e[3;410;100t' 
    clear 
    echo $(tput bold)"Camera model tag processing being killed"$(tput sgr0)
    rm /tmp/DUALISO/CAMMODEL
    sleep 2
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    else
    ls "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount > /tmp/DUALISO/CAMMODEL
    printf '\e[8;16;53t'
    printf '\e[3;410;100t'  
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command &>/dev/null &
    clear 
    echo $(tput bold)"Camera model tags being added
$(tput sgr0)Reenter $(tput bold)(20)$(tput sgr0) to kill camera model tag processing"
    sleep 3
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
    fi
;;

    "21")
if [[ $(find "$(cat /tmp/DUALISO/"path_2")"mlvfs/80000331_1808x727.fpm -type f -size -300000c 2>/dev/null) ]]; 
then
    printf '\e[8;16;53t'
    printf '\e[3;410;100t'
    clear
cp -r "$(cat /tmp/DUALISO/"path_2")"mlvfs/crop_rec/crop80000331_1808x727.fpm "$(cat /tmp/DUALISO/"path_2")"mlvfs/80000331_1808x727.fpm
    echo $(tput bold)"Crop_rec pixel list added please reenter $(tput setaf 1)(A)$(tput sgr0)"
    sleep 2
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
else
    printf '\e[8;16;53t'
    printf '\e[3;410;100t'
    clear
cp -r "$(cat /tmp/DUALISO/"path_2")"mlvfs/crop_rec/80000331_1808x727.fpm "$(cat /tmp/DUALISO/"path_2")"mlvfs/80000331_1808x727.fpm
    echo $(tput bold)"mv720 pixel list added please reenter $(tput setaf 1)(A)$(tput sgr0)"
    sleep 2
    clear & 
    printf '\e[8;59;110t'
    printf '\e[3;410;0t'
fi
;;


    "22")
#AE_question
if ! grep 'AE_template' /tmp/FFmpeg_settings 
then
echo AE_template > /tmp/FFmpeg_settings
    mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
#Find aerender among multiple versions
    ls -td /Applications/Adobe\ After\ * > /tmp/DUALISO/AErenderPATH
    while ! ls "$(cat /tmp/DUALISO/AErenderPATH | head -1)"/aerender
    do
    echo "$(tail -n +2 /tmp/DUALISO/AErenderPATH)" > /tmp/DUALISO/AErenderPATH
    if ! grep 'Adobe' /tmp/DUALISO/AErenderPATH
    then
    rm /tmp/FFmpeg_settings
    clear
    echo $(tput bold)"

    $(tput sgr0)$(tput bold)$(tput setaf 1) 
aerender is missing, check your after effects version"$(tput sgr0) ; 
    sleep 2
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    fi
    done
#get the correct template
    if grep 'CC' <<< $(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)")
    then
    numb=$(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)" | awk 'FNR == 1 {print $5; }')
    if (( $(echo "$numb > 2015.2" |bc -l) )); 
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_templateCC.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;20;95t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"


while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}$(tput setaf 1)AE project settings$(tput sgr0)
    ------------------------------
 
    $(tput bold)(c)$(tput sgr0) I want to change AE project settings template				 
    $(tput bold)(r)$(tput sgr0) Continue without changes  

    $(tput bold)$(tput setaf 1)(p) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) quit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n1
    case "$REPLY" in

    "c")  
#Reset file if needed
if ! grep 'any_X' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
then
perl -pi -e 's/'"$(LC_ALL=C cat -v "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep | tr ' ' '\n' | grep -o -m 1 '[^ ]*C0000')"'/any_X/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
fi

#list dng directories
    cd "$(cat /tmp/DUALISO/"path_1")"
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
    cd -
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
#creating a dummy audio file if not present
    if ! ls "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav 
    then
    ffmpeg -t 1 -f s16le -acodec pcm_s16le -ac 2 -i /dev/zero -acodec copy "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    fi
#Add correct filename
perl -pi -e 's/any_X/'"$name"'/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
open "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep &

echo > /tmp/DUALISO/AE_question
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
;;

    "r") 
rm /tmp/magic_l_prores/AE_question 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
rm /tmp/magic_l_prores/AE_question 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
else
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_white_level
rm /tmp/FFmpeg_settings
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; DEL_DNG=
fi
;;

    "23")
#AE_question
if ! grep 'AE_temp_HDR' /tmp/FFmpeg_settings 
then
echo AE_temp_HDR > /tmp/FFmpeg_settings
    mkdir -p "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
#Find aerender among multiple versions
    ls -td /Applications/Adobe\ After\ * > /tmp/DUALISO/AErenderPATH
    while ! ls "$(cat /tmp/DUALISO/AErenderPATH | head -1)"/aerender
    do
    echo "$(tail -n +2 /tmp/DUALISO/AErenderPATH)" > /tmp/DUALISO/AErenderPATH
    if ! grep 'Adobe' /tmp/DUALISO/AErenderPATH
    then
    rm /tmp/FFmpeg_settings
    clear
    echo $(tput bold)"

    $(tput sgr0)$(tput bold)$(tput setaf 1) 
aerender is missing, check your after effects version"$(tput sgr0) ; 
    sleep 2
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    fi
    done
#get the correct template
#but first check if HDR template was chosen
    if grep 'AE_temp_HDR' /tmp/FFmpeg_settings
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template_HDR.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep    
    else
    if grep 'CC' <<< $(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)")
    then
    numb=$(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)" | awk 'FNR == 1 {print $5; }')
    if (( $(echo "$numb > 2015.2" |bc -l) )); 
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_templateCC.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444
    fi
    fi
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;20;95t'
printf '\e[3;410;100t'
open -a Terminal
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"

underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"


while :
do 

    clear
    cat<<EOF
    ==============================
    ${bold}$(tput setaf 1)AE project settings$(tput sgr0)
    ------------------------------
 
    $(tput bold)(c)$(tput sgr0) I want to change AE project settings template				 
    $(tput bold)(r)$(tput sgr0) Continue without changes  

    $(tput bold)$(tput setaf 1)(p) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) quit Switch$(tput sgr0)   					        					

Please enter your selection number below:
EOF
    read -n1
    case "$REPLY" in

    "c")  
#Reset file if needed
if ! grep 'any_X' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
then
perl -pi -e 's/'"$(LC_ALL=C cat -v "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep | tr ' ' '\n' | grep -o -m 1 '[^ ]*C0000')"'/any_X/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
fi

#list dng directories
    cd "$(cat /tmp/DUALISO/"path_1")"
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
    cd -
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
#creating a dummy audio file if not present
    if ! ls "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav 
    then
    ffmpeg -t 1 -f s16le -acodec pcm_s16le -ac 2 -i /dev/zero -acodec copy "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    fi
#Add correct filename
perl -pi -e 's/any_X/'"$name"'/g' "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep
open "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_ProRes4444/AE_prores_template.aep &

echo > /tmp/DUALISO/AE_question
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
;;

    "r") 
rm /tmp/magic_l_prores/AE_question 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "q")   
rm /tmp/magic_l_prores/AE_question 
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
else
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_white_level
rm /tmp/FFmpeg_settings
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; AE_HDR= ; DEL_DNG=
fi
;;


    "A")
#root folder name
root=$(grep -o '[^/]*$' /tmp/DUALISO/"path_1")
kill $(cat /tmp/"$root"_pid | head -1) &>/dev/null
rm "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.IDX &>/dev/null
find "$(cat /tmp/DUALISO/"path_1")"/ -maxdepth 1 -type l -delete
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS 1> /dev/null 2>&1 &
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage 1> /dev/null 2>&1 &
mkdir -p "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount 1> /dev/null 2>&1 &
if ! ls "$(cat /tmp/DUALISO/"path_1")"/*.MLV &>/dev/null
then 
if ! ls "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.MLV &>/dev/null
then
echo > /tmp/no_files 
fi
fi

if ! ls /tmp/no_files
then
mv -i "$(cat /tmp/DUALISO/"path_1")"/*.M* "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage &>/dev/null
cd "$(cat /tmp/DUALISO/"path_2")"mlvfs

if ls /tmp/SCALETAG
then
./mlvfs_crop_rec "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount --mlv-dir="$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage -f -o local -o volname="$root"_mount -o allow_other --resolve-naming $(cat /tmp/"$root"_settings.txt | sed -e 's/^[ \t]*//') & sleep 0.5
echo $(ps aux | pgrep mlvfs_crop_rec) > /tmp/"$root"_pid
else
if ls /tmp/DUALISO/crop_rec
then
./mlvfs_crop_rec "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount --mlv-dir="$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage -f -o local -o volname="$root"_mount -o allow_other --resolve-naming $(cat /tmp/"$root"_settings.txt | sed -e 's/^[ \t]*//') & sleep 0.5
echo $(ps aux | pgrep mlvfs_crop_rec) > /tmp/"$root"_pid
else
./mlvfs "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount --mlv-dir="$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage -f -o local -o volname="$root"_mount -o allow_other --resolve-naming $(cat /tmp/"$root"_settings.txt | sed -e 's/^[ \t]*//') & sleep 0.5
echo $(ps aux | pgrep mlvfs) > /tmp/"$root"_pid
fi
fi

echo "$(cat /tmp/DUALISO/"path_1")"/ >> /tmp/"$root"_pid
cd "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/
check=$(ls -r *.MLV | head -1 | cut -d "." -f1) &>/dev/null
cd "$(cat /tmp/DUALISO/"path_1")"/
while ! ls -d "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount/"$check"_1_* &>/dev/null
do sleep 1
done
ln -s "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount/* "$(cat /tmp/DUALISO/"path_1")"/ 1> /dev/null 2>&1 &
open "$(cat /tmp/DUALISO/"path_1")"/
else 
rm /tmp/no_files 1> /dev/null 2>&1 &
fi
;;

    "mp")
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer1.app/Contents/MacOS/mlrawviewer "$(cat /tmp/DUALISO/"path_1")" & sleep 2
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
while [ -n "$(pgrep mlrawviewer </dev/null)" ]; 
do sleep 1
done 
rm "$(cat /tmp/DUALISO/"path_1")"/*.WAV
rm "$(cat /tmp/DUALISO/"path_1")"/*.MRX
;;

    "EJ")
root=$(grep -o '[^/]*$' /tmp/DUALISO/"path_1")
kill $(cat /tmp/"$root"_pid | head -1) &>/dev/null 
rm /tmp/"$root"_pid &>/dev/null
find "$(cat /tmp/DUALISO/"path_1")"/ -maxdepth 1 -type l -delete
rm "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.IDX 
rm -r "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/*.MLD
mv -i "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage/* "$(cat /tmp/DUALISO/"path_1")"/
#check if created root folder is empty and erase if so 
    if [ x"$(ls $(cat /tmp/DUALISO/"path_1")/A_ORIGINALS/"$root"_storage/*)" = x ]
    then
    rm -r "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_storage
    fi
    if [ x"$(ls $(cat /tmp/DUALISO/"path_1")/A_ORIGINALS/"$root"_mount/*)" = x ]
    then
    rm -r "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount
    fi
;;

    "S")
echo > /tmp/DUALISO/mlvfs_path
open "$(cat /tmp/DUALISO/path_2)"new_output.app
printf '\e[8;10;50t'
printf '\e[3;410;0t'
clear
echo "


$(tput bold)Select new input folder"
sleep 2

#trap
    while ls /tmp/DUALISO/mlvfs_path &>/dev/null
    do
    sleep 0.3
    done
clear &
echo "


$(tput bold)$(tput setaf 2)New input selected"$(tput sgr0)
sleep 1
clear &
    printf '\e[8;56;110t'
    printf '\e[3;410;0t' 
;;

#tif spit raw to tif
    "p")
echo > /tmp/DUALISO/tif_back
. "$(cat /tmp/DUALISO/path_2)"tif_spit.command 
;;


    "E")
root=$(grep -o '[^/]*$' /tmp/DUALISO/"path_1")
cs2= ; cs3= ; cs5= ; bp= ; rbp= ; fpn= ; str= ; def= ; pre= ; dua= ; ama= ; mea=  ; noa= ; ali= ; fpz= ; fps= ; HL= ; NOH= TAG=
rm /tmp/"$root"_settings.txt 1> /dev/null 2>&1 &
rm /tmp/SCALETAG 1> /dev/null 2>&1 &
;;

    "ml")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")  
root=$(grep -o '[^/]*$' /tmp/DUALISO/"path_1")
perl -pi -e 's/^[\ \t]+|[\ \t]+$//g' /tmp/"$root"_settings.txt
rm "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/"path_1")"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;


    "C")
rm /tmp/DUALISO/OUT_path 1> /dev/null 2>&1 &
rm /tmp/DUALISO/O_trap 1> /dev/null 2>&1 &
if ls /tmp/output
then
rm /tmp/output
out=
else
echo > /tmp/DUALISO/OUT_path
open "$(cat /tmp/DUALISO/path_2)"new_output.app
clear
echo "


A selection window will now open"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
fi
;;

    "CP")
if [ -f /tmp/THREADS ]
then
rm /tmp/THREADS
THREADS=
else

printf '\e[8;16;53t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"set thread amount:$(tput sgr0)($(tput bold)e.g$(tput sgr0) 2 and hit enter)"
read input_variable
echo "thread amount is set to: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo -n "Threads" $input_variable > /tmp/THREADS
THREADS=$(cat /tmp/THREADS)
fi
sleep 1 
printf '\e[8;37;60t'
printf '\e[3;450;0t'
    ;;

    "O")
open /tmp/folder_paths.txt
    ;;

    "R")
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy= ; out= ; THREADS= ; b24= ; b32= ; na= ; nc= ; gap= ; blur= ; HDR= ; HDROUT= ; CR2OUT= ; force=
rm /tmp/HDRCR2output
rm /tmp/HDRCR2_settings
rm /tmp/HDRCR2
rm /tmp/THREADS
rm /tmp/DUALISO/crop_rec?
rm /tmp/DUALISO/crop_rec
rm /tmp/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm /tmp/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm /tmp/cpuboost 1> /dev/null 2>&1 &
rm /tmp/"$root"_settings.txt 1> /dev/null 2>&1 &
rm /tmp/output 1> /dev/null 2>&1 &
#set your output folder
    if [ x"$out" = x ]
    then
out=$(cat /tmp/DUALISO/"path_1")/$(tput sgr0)
    fi
rm /tmp/DUALISO/O_trap 1> /dev/null 2>&1 &

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; dual= ; c= ; cc= ; p= ; ccc= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
rm /tmp/PROXYONLY
rm /tmp/mlv_dump_UNC
rm /tmp/mlv_dump_on_steroids_UNC
rm /tmp/mlv_dump_settings 1> /dev/null 2>&1 &
rm /tmp/mlv_dump_on_steroids_settings 
echo > /tmp/mlv_dump_on_steroids_settings 
rm /tmp/dualisodisable 1> /dev/null 2>&1 &

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; auto= ; AE= ; HDRa= ; halfhdra= ; wle= ; AE_HDR= ; DEL_DNG=
rm /tmp/DUALISO/DEL_DNG
rm /tmp/FFmpeg_white_level
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_settings 1> /dev/null 2>&1 &
rm /tmp/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm /tmp/_X_pres_SCALE 1> /dev/null 2>&1 &
rm /tmp/prox_SCALE 1> /dev/null 2>&1 &
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &

copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale= ; aspect= ; PRscale= ; PRaspect= ; denoise= ; sharpen= ; auto= ; DARK= ; FLAT= ; darkfr_storage= ; TAG= ; cr2hdr_a= ; mlv_dump_a= ; X_pro_a= ; pro_a= 
rm /tmp/_X_ProRes4444 1> /dev/null 2>&1 &
rm /tmp/_X_Proxy 1> /dev/null 2>&1 &
rm /tmp/_X_HDR 1> /dev/null 2>&1 &
rm /tmp/_X_HDR 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_02 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_03 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_04 1> /dev/null 2>&1 &
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &
rm /tmp/DARK 1> /dev/null 2>&1 &
rm /tmp/DARK_FOLDER 1> /dev/null 2>&1 &
rm /tmp/NO_DNG 1> /dev/null 2>&1 &
rm /tmp/only_DNG
rm /tmp/full_DARK
rm /tmp/DARK
rm /tmp/only_DARK
rm /tmp/DUALISO/DEAD_P 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FLAT 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FLATFRAMES 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FLATFRAME_A 1> /dev/null 2>&1 &
rm /tmp/SCALETAG 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FULL_AUTO 1> /dev/null 2>&1 &
;; 


#darkframe processing
    "A")

#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;22;95t'
printf '\e[3;410;100t'

open -a Terminal

bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"

NO_DNG= ; DP= ; only_DNG= ; full_DARK= ; DARK_FOLDER= ; only_DARK=

if ls /tmp/full_DARK
then 
full_DARK=$(echo "$bold""$green"added!"$normal")
fi

if ls /tmp/NO_DNG
then 
NO_DNG=$(echo "$bold""$green"added!"$normal")
fi

if ls /tmp/only_DNG
then 
only_DNG=$(echo "$bold""$green"added!"$normal")
fi

if ls /tmp/DARK_FOLDER
then 
DARK_FOLDER=$(echo "$bold""$green"added!"$normal")
fi

if ls /tmp/only_DARK
then 
only_DARK=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    ====================
    ${bold}$(tput setaf 1)Darkframe automation$(tput sgr0)
    --------------------
    Always include filmed unprocessed or processed darkframes next 
    to your MLV footage or select a storage with darkframes(last step).

    Output options
    $(tput bold)(1) dng processing$(tput sgr0)(process straight to darkframed dng files) $only_DNG
    $(tput bold)(2) MLV processing$(tput sgr0)(creates only darkframe MLV files) $NO_DNG
    $(tput bold)(3) full output$(tput sgr0)(creates both darkframe MLV and dng files) $full_DARK				 
    $(tput bold)(4) create only processed darkframes$(tput sgr0) $only_DARK
    $(tput bold)(5) select darkframe storage$(tput sgr0)(MLV+dng processing default) $DARK_FOLDER

    $(tput bold)$(tput setaf 1)(R) reset all settings$(tput sgr0) 
    $(tput bold)$(tput setaf 1)(m) back to main menu$(tput sgr0)  
    $(tput bold)$(tput setaf 1)(q) exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) run Switch$(tput sgr0) 					        					

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in


    "1")  
if ls /tmp/only_DNG
then 
rm /tmp/only_DNG &>/dev/null &
rm /tmp/DARK
only_DNG=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > /tmp/only_DNG
echo > /tmp/DARK
only_DNG=$(echo "$bold""$green"added!"$normal")
rm /tmp/NO_DNG &>/dev/null &
NO_DNG=
rm /tmp/full_DARK
full_DARK=
rm /tmp/only_DARK
only_DARK=
fi
if [ -f /tmp/DARK_FOLDER ]
then 
rm /tmp/DARK
fi
;;


    "2")  
if ls /tmp/NO_DNG
then 
rm /tmp/NO_DNG &>/dev/null &
rm /tmp/DARK
NO_DNG=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > /tmp/NO_DNG
echo > /tmp/DARK
NO_DNG=$(echo "$bold""$green"added!"$normal")
rm /tmp/only_DNG &>/dev/null &
only_DNG=
rm /tmp/full_DARK
full_DARK=
rm /tmp/only_DARK
only_DARK=
fi
if [ -f /tmp/DARK_FOLDER ]
then 
rm /tmp/DARK
fi
;;


    "3")  
if ! ls /tmp/full_DARK
then 
rm /tmp/NO_DNG &>/dev/null &
NO_DNG=
rm /tmp/only_DNG &>/dev/null &
only_DNG=
rm /tmp/only_DARK
only_DARK=
echo > /tmp/full_DARK
echo > /tmp/DARK
full_DARK=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/full_DARK
rm /tmp/DARK
full_DARK=
fi
if [ -f /tmp/DARK_FOLDER ]
then 
rm /tmp/DARK
fi
;;

    "4")  
if ! ls /tmp/only_DARK
then 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER=
rm /tmp/DARK
rm /tmp/NO_DNG
rm /tmp/full_DARK
rm /tmp/DARK_FOLDER
rm /tmp/only_DNG
echo > /tmp/only_DARK
echo > /tmp/DARK
only_DARK=$(echo "$bold""$green"added!"$normal")
else
rm /tmp/only_DARK
rm /tmp/DARK
only_DARK=
fi
;;

    "5") 
if [ -f /tmp/DARK_FOLDER ]
then 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER=
rm /tmp/DARK
rm /tmp/NO_DNG
rm /tmp/full_DARK
rm /tmp/DARK_FOLDER
rm /tmp/only_DNG
rm /tmp/only_DARK
clear
echo "

${bold}$(tput setaf 1)Storage path removed!$(tput sgr0)"
sleep 1
DARK_FOLDER=
else
rm /tmp/DARK &>/dev/null &
rm /tmp/only_DARK
only_DARK=
echo > /tmp/DARK_FOLDER
echo > /tmp/DARK_FOLDER_path
open "$(cat /tmp/DUALISO/path_2)"new_output.app
printf '\e[8;10;50t'
printf '\e[3;410;0t'
clear
echo "


${bold}$(tput setaf 2)Select storage path$(tput sgr0)"
sleep 1

#trap
    while ls /tmp/DARK_FOLDER_path &>/dev/null
    do
    sleep 0.3
    done
clear
echo "


${bold}$(tput setaf 2)added Path:$(tput setaf 4)"$(cat /tmp/DARK_FOLDER)"$(tput sgr0)"
sleep 2

clear &

. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
;;

    "R") 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER= ; only_DARK=
rm /tmp/DARK
rm /tmp/NO_DNG
rm /tmp/full_DARK
rm /tmp/DARK_FOLDER
rm /tmp/only_DNG
rm /tmp/only_DARK
;;


    "m") 
clear
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r") 
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;


    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;




#flatframe processing
    "F")
rm /tmp/DUALISO/FLAT_select 1> /dev/null 2>&1 &
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
if ls /tmp/DUALISO/FLATFRAME_A
then
rm /tmp/DUALISO/FLATFRAME_A 1> /dev/null 2>&1 &
FLAT=
else
FLAT=$(echo "$bold""$green"added!"$normal")
echo > /tmp/DUALISO/FLATFRAME_A
printf '\e[8;16;63t'
printf '\e[3;410;100t'
clear
read -p $(tput bold)"Would you rather select flatframe and darkflat manually?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
#add file so automator know what to choose in script
echo > /tmp/DUALISO/FLAT_select
rm /tmp/DUALISO/FLATFRAME_A 1> /dev/null 2>&1 &
open "$(cat /tmp/DUALISO/path_2)"file_select.app
FLAT=$(echo "$bold""$green"added!"$normal")
echo > /tmp/DUALISO/FLAT
clear
echo "


$(tput bold) 
Select your flatframe and additional 
flat dark if you like when prompt window opens"
sleep 2
osascript -e 'tell application "Terminal" to close first window' & exit
else
clear
echo "Done!"
printf '\e[8;37;60t'
printf '\e[3;450;0t'
fi
fi
;;


    "a") 
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy= ; THREADS= ; b24= ; b32= ; na= ; nc= ; gap= ; blur= ; HDR= ; HDROUT= ; CR2OUT= ; force=
rm /tmp/HDRCR2output
rm /tmp/HDRCR2_settings
rm /tmp/HDRCR2
rm /tmp/THREADS
rm /tmp/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm /tmp/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm /tmp/cpuboost 1> /dev/null 2>&1 &
rm /tmp/"$root"_settings.txt 1> /dev/null 2>&1 &
rm /tmp/DUALISO/O_trap 1> /dev/null 2>&1 &
sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixfp= ; fixcp= ; nostripes= ; dafr= ; dual= ; c= ; cc= ; p= ; ccc= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm= ; proxy=
rm /tmp/PROXYONLY
rm /tmp/mlv_dump_UNC
rm /tmp/mlv_dump_on_steroids_UNC
rm /tmp/mlv_dump_settings 1> /dev/null 2>&1 &
rm /tmp/mlv_dump_on_steroids_settings 1> /dev/null 2>&1 &
echo > /tmp/mlv_dump_on_steroids_settings &
rm /tmp/dualisodisable 1> /dev/null 2>&1 &

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; AE_HDR= ; DEL_DNG=
rm /tmp/DUALISO/DEL_DNG
rm /tmp/FFmpeg_white_level
rm /tmp/pr4444_HDR
rm /tmp/FFmpeg_settings 1> /dev/null 2>&1 &
rm /tmp/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm /tmp/_X_pres_SCALE 1> /dev/null 2>&1 &
rm /tmp/prox_SCALE 1> /dev/null 2>&1 &
rm /tmp/denoise 1> /dev/null 2>&1 &
rm /tmp/sharpen 1> /dev/null 2>&1 &

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &

copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale= ; aspect= ; PRscale= ; PRaspect= ; denoise= ; sharpen= ; auto= ; DARK= ; FLAT= ; darkfr_storage= ; TAG= AE=
rm /tmp/_X_ProRes4444 1> /dev/null 2>&1 &
rm /tmp/_X_Proxy 1> /dev/null 2>&1 &
rm /tmp/_X_HDR 1> /dev/null 2>&1 &
rm /tmp/_X_HDR 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_02 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_03 1> /dev/null 2>&1 &
rm /tmp/_X_HDR_04 1> /dev/null 2>&1 &
rm /tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
rm /tmp/_X_denoise 1> /dev/null 2>&1 &
rm /tmp/_X_sharpen 1> /dev/null 2>&1 &
rm /tmp/DARK 1> /dev/null 2>&1 &
rm /tmp/DARK_FOLDER 1> /dev/null 2>&1 &
rm /tmp/NO_DNG 1> /dev/null 2>&1 &
rm /tmp/only_DNG
rm /tmp/full_DARK
rm /tmp/DARK
rm /tmp/only_DARK
rm /tmp/DUALISO/FLAT 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FLATFRAMES 1> /dev/null 2>&1 &
rm /tmp/DUALISO/FLATFRAME_A 1> /dev/null 2>&1 &
rm /tmp/SCALETAG 1> /dev/null 2>&1 &

#auto settings 
echo "lincineon" >> /tmp/FFmpeg_settings
echo "lincineonpr" >> /tmp/FFmpeg_settingsPR
echo "HL" >> /tmp/FFmpeg_settings

echo "copy" >> /tmp/_X_ProRes4444
echo "copypr" >> /tmp/_X_Proxy
echo -n " --compress" >> /tmp/A_cr2hdr_cmpr.txt
echo > /tmp/DARK
echo > /tmp/DUALISO/DEAD_P
echo > /tmp/DUALISO/FULL_AUTO

DARK=$(echo "$bold""$green"auto mode!"$normal")
auto=$(echo "$bold""$green"auto mode!"$normal")
cr2hdr_a=$(echo "$bold""$green"auto mode!"$normal")
mlv_dump_a=$(echo "$bold""$green"auto mode!"$normal")
X_pro_a=$(echo "$bold""$green"auto mode!"$normal")
pro_a=$(echo "$bold""$green"auto mode!"$normal")
;;


    "pl") 
if ! ls /tmp/afplay_path
then
echo > /tmp/afplay
open "$(cat /tmp/DUALISO/path_2)"new_output.app
printf '\e[8;10;50t'
printf '\e[3;410;0t'
clear
echo "


${bold}$(tput setaf 2)Select afplay path$(tput sgr0)"
sleep 1

#trap
    while ls /tmp/afplay &>/dev/null
    do
    sleep 0.3
    done
clear
echo "


${bold}$(tput setaf 2)added Path:$(tput setaf 4)"$(cat /tmp/afplay_path)"$(tput sgr0)"
afplay=$(echo "$bold""$green"added!"$normal")
sleep 2  
rm "$(cat /tmp/afplay_path)"/playlist
killall afplay &
clear &
open "$(cat /tmp/DUALISO/path_2)"afplayer.command &
echo > /tmp/DUALISO/afplayON
. "$(cat /tmp/DUALISO/path_2)"Menu.command
else
rm /tmp/afplay_path
rm /tmp/DUALISO/afplayON
clear &
shuf=
afplay=
echo "


${bold}$(tput setaf 1)removed path:$(tput setaf 4)$(tput sgr0)"
sleep 1
clear &
. "$(cat /tmp/DUALISO/path_2)"Menu.command
fi
;;


    "DB")
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 
rm /tmp/DUALISO/DUALISO
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
clear
printf '\e[8;10;60t'
printf '\e[3;0;0t'
. "$(cat /tmp/DUALISO/"path_2")"Switch_MAIN_DBG.command 
open "$(cat /tmp/DUALISO/path_1)"/LOG.txt
printf '\e[8;37;60t'
printf '\e[3;450;0t'
;;

    "to")
chmod u=rwx "$(cat /tmp/DUALISO/"path_2")"tool_box/*
open "$(cat /tmp/DUALISO/"path_2")"tool_box
;;

    "r") 
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_Proxy/*.tif
rm "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_X_ProRes4444/*.tif
rm /tmp/DUALISO/tif_spit
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q")   
echo > /tmp/DUALISO/DUALISO_exit 1> /dev/null 2>&1 &
rm /tmp/DUALISO/DUALISO 1> /dev/null 2>&1 &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
exit 0
fi

#Copyright Danne