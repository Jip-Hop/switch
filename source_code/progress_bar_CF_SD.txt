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



#CF/SD copying(Check menu.command)
######(01) Copy all content from card(CF/SD) to selected folder(MLV,RAW,CR2,MOV,DNG,etc)
######(1X) Copy all content from CF/SD to selected folder then DELETE files from CF/SD card
######(02) Copy only MLV and RAW to selected folder
######(03) Copy only DNG to selected folder
######(04) Copy only MOV to selected folder
######(05) Copy only CR2 to selected folder
######
######
######
######



######(01) Copy all content from card(CF/SD) to selected folder(MLV,RAW,CR2,MOV,DNG,etc)
if ls /tmp/DUALISO/COPY1 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY1

#Let´s copy content to selected folder
     find /Volumes/EOS_*/DCIM/ -type f -exec cp {} "$(cat /tmp/DUALISO/"path_1")" \; && hdiutil eject /Volumes/EOS_* && killall sleep && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done & 

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi



######(1X) Copy all content from CF/SD to selected folder then DELETE files from CF/SD card
if ls /tmp/DUALISO/COPY2 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY2

#Let´s copy content to selected folder then delete the lot
find /Volumes/EOS_*/DCIM/ -type f -exec cp {} "$(cat /tmp/DUALISO/"path_1")" \; && find /Volumes/EOS_*/DCIM/ -type f -exec rm -f {} \; && hdiutil eject /Volumes/EOS_* && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi


######(02) Copy only MLV and RAW to selected folder
#CF/SD copying
if ls /tmp/DUALISO/COPY3 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY3

#Let´s copy MLV files to selected folder
cp /Volumes/EOS_*/DCIM/*/*.{MLV,M0*,M1*,M2*,M3*,M4*,M5*,RAW,R0*,R1*,R2*,R3*,R4*,R5*} "$(cat /tmp/DUALISO/"path_1")" || : && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi




######(03) Copy only DNG to selected folder
if ls /tmp/DUALISO/COPY4 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY4

#Let´s copy MLV files to selected folder
cp /Volumes/EOS_*/DCIM/*/*.DNG 1> /dev/null 2>&1 "$(cat /tmp/DUALISO/"path_1")" || : && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi



######(04) Copy only MOV to selected folder
if ls /tmp/DUALISO/COPY5 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY5

#Let´s copy MLV files to selected folder
cp /Volumes/EOS_*/DCIM/*/*.MOV 1> /dev/null 2>&1 "$(cat /tmp/DUALISO/"path_1")" || : && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi



######(05) Copy only CR2 to selected folder
if ls /tmp/DUALISO/COPY6 >/dev/null 2>&1;
then
rm /tmp/DUALISO/COPY6

#Let´s copy MLV files to selected folder
cp /Volumes/EOS_*/DCIM/*/*.CR2 1> /dev/null 2>&1 "$(cat /tmp/DUALISO/"path_1")" || : && echo -n -e "\033]0;COPYwindow\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "COPYwindow")' & exit &

printf '\e[8;08;20t'
printf '\e[3;25;0t'

cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying.....

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF

while sleep 1; 
do

if ! [ x"$dot5" = x ]
then
dot1=
dot2=
dot3=
dot4=
dot5=
fi

if ! [ x"$dot4" = x ]
then
dot5=$(echo .)
fi

if ! [ x"$dot3" = x ]
then
dot4=$(echo .)
fi

if ! [ x"$dot2" = x ]
then
dot3=$(echo .)
fi

if ! [ x"$dot1" = x ]
then
dot2=$(echo .)
fi

if [ x"$dot1" = x ]
then
dot1=$(echo .)
fi


cat<<EOF
    ----------
    $(tput setaf 0)$(tput bold)CF/SD copy$(tput sgr0)
    ----------

    $(tput bold)Copying$dot1$dot2$dot3$dot4$dot5

 $(tput bold)$(tput setaf 1)(K) Kill copying$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall find
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi


