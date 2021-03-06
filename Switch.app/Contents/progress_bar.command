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


printf '\e[8;10;20t'
printf '\e[3;955;0t'
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

#X to ProRes PROCESSING
#PROXY CLEANING
#MLV PROCESSING
#RAW PROCESSING
#PRORES PROCESSING
#CR2 PROCESSING
#Sample file PROCESSING
#HDRCR2_grouping
#HDRCR2 brackets
#HDR_MOV bash
#HDR_CR2


#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi

rm /tmp/DUALISO/MLVprogress_bar_key


#X to ProRes PROCESSING
    if ! [ x"$(cat /tmp/DUALISO/FFmpeg_ALL)" = x ]
    then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
-------------------
$(tput setaf 0)$(tput bold)X to ProRes counter$(tput sgr0)
-------------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg_ALL"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0) 
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
cat<<EOF
-------------------
$(tput setaf 0)$(tput bold)X to ProRes counter$(tput sgr0)
-------------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg_ALL"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 3; 
do
cat<<EOF
-------------------
$(tput setaf 0)$(tput bold)X to ProRes counter$(tput sgr0)
-------------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg_ALL"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
#trap
    if ! grep -q 'trap' /tmp/DUALISO/X_prores_TRAP
    then
    echo -n -e "\033]0;XPRORESwindow\007"
    kill $(echo $$)
    osascript -e 'tell application "Terminal" to close (every window whose name contains "XPRORESwindow")' & exit 
    fi
    done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
cat<<EOF
-------------------
$(tput setaf 0)$(tput bold)X to ProRes counter$(tput sgr0)
-------------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg_ALL"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall ffmpeg
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi

#PROXY CLEANING
    if [ -f /tmp/PROXYONLY ]
    then
if grep -q 'MLV\|mlv' /tmp/DUALISO/MLVprogress_bar
then

printf '\e[8;08;20t'
printf '\e[3;955;0t'

clear
cat<<EOF
--------------
$(tput setaf 0)$(tput bold)Proxy creation $NUM$(tput sgr0)
--------------

$(tput bold)Cleaning proxys.....

$(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
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
--------------
$(tput setaf 0)$(tput bold)Proxy creation $NUM$(tput sgr0)
--------------

$(tput bold)Cleaning proxys$dot1$dot2$dot3$dot4$dot5

$(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
if ! grep -q 'MLV\|mlv' /tmp/DUALISO/MLVprogress_bar
then
echo -n -e "\033]0;MLVwindow\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "MLVwindow")' & exit 
fi
done &

    read -n1
    case "$REPLY" in

    "K") 
killall sleep
killall exiv2
killall exiftool
killall $mlv_dump
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
fi 
    fi


#MLV PROCESSING
if grep -q 'MLV\|mlv' /tmp/DUALISO/MLVprogress_bar
then

NUM=$(cat /tmp/DUALISO/"MLVprogress_bar"|wc -l | perl -p -e 's/^[ \t]*//')
#percentage start
percent=$(echo 0)
printf '\e[8;09;20t'
printf '\e[3;955;0t'
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV queue $NUM$(tput sgr0)
    -----------

    $(tput bold)starting soon!

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV queue $NUM$(tput sgr0)
    -----------

    $(tput bold)starting soon!

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV queue $NUM$(tput sgr0)
    -----------
    $(tput bold)starting soon!
   $(tput bold)$(tput setaf 0) 
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLVprogress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)

EOF
else

#time estimation number, follow up in time approximator below
num=$(echo 30)

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
#now do percent
total=$(echo $(awk '{ sum += $1 } END { print sum }' /tmp/DUALISO/MLVprogress_bar3))
#percentage start
NUMB=$(echo 100)
printf '\e[8;10;23t'
printf '\e[3;955;0t'
if [ -f /tmp/output ]
then
OUT=$(cat /tmp/"output" | head -1)
fi
#only countdown newer files
DATE=`date +%Y-%m-%d`
TIME=`date +%H:%M:%S`
while sleep 1; 
do
NUM=$(cat /tmp/DUALISO/"MLVprogress_bar"|wc -l | perl -p -e 's/^[ \t]*//')
if [ x"$OUT" = x ]
then
cd "$(cat /tmp/DUALISO/path_1)"
deduct=$(find . -maxdepth 2 -iname '*.dng' -newermt "$DATE $TIME" |wc -l)
item=$(echo $total - $deduct | bc -l)
percent=`expr 200 \* $item / $total % 2 + $NUMB \* $item / $total`
else
cd "$OUT"
deduct=$(find . -maxdepth 2 -iname '*.dng' -newermt "$DATE $TIME" |wc -l)
item=$(echo $total - $deduct | bc -l)
percent=`expr 200 \* $item / $total % 2 + $NUMB \* $item / $total`
fi

#time approximator
amount=$(echo $(echo $(awk '{ sum += $1 } END { print sum }' /tmp/DUALISO/MLVprogress_bar3)) - $(find . -maxdepth 2 -iname '*.dng' -newermt "$DATE $TIME" |wc -l) | bc -l | cut -d "." -f1)
ded=$(find . -maxdepth 2 -iname '*.dng' -newermt "$DATE $TIME" |wc -l)
all=$(echo $amount / $ded | bc -l)
chunk=$(echo $ded / $num | bc -l)
#let´s strive for 1 second down counting
if [ "$(echo $secs - $(echo "$chunk * $all" | bc -l | cut -d "." -f1) | bc -l | cut -d "." -f1)" = "0" ]
    then
    num=$(echo $num - 2 | bc -l)
fi
if [ "$(echo $secs - $(echo "$chunk * $all" | bc -l | cut -d "." -f1) | bc -l | cut -d "." -f1)" = "2" ]
    then
    num=$(echo $num + 2 | bc -l)
fi
if [ "$(echo $secs - $(echo "$chunk * $all" | bc -l | cut -d "." -f1) | bc -l | cut -d "." -f1)" = "3" ]
    then
    num=$(echo $num + 3 | bc -l)
fi
#time estimation result in seconds
secs=$(echo "$chunk * $all" | bc -l | cut -d "." -f1)

#let´s count from zero to 100
percent=$(echo 100 - $percent | bc -l)
time=$(printf '%02d:%02d:%02d\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60)))
if (( $secs < 0 ))
then 
time=$(echo "00:00:00")
fi

cat<<EOF
      ------------
      $(tput setaf 0)$(tput bold)MLV queue $NUM
      ------------

  time left: $time
 percentage: $percent%

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF


if ! grep -q 'MLV\|mlv' /tmp/DUALISO/MLVprogress_bar
then
echo -n -e "\033]0;MLVwindow\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "MLVwindow")' & exit 
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 

printf '\e[8;10;23t'
printf '\e[3;955;0t'
cat<<EOF
      ------------
      $(tput setaf 0)$(tput bold)MLV queue $NUM
      ------------

  time left: 
 percentage: $percent%

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall exiv2
killall exiftool
killall $mlv_dump
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi


#RAW PROCESSING
if grep -q 'RAW' /tmp/DUALISO/RAWprogress_bar
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)RAW counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"RAWprogress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)RAW counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"RAWprogress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 2; 
do
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)RAW counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"RAWprogress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ! grep -q 'RAW' /tmp/DUALISO/RAWprogress_bar
then
echo -n -e "\033]0;RAWwindow\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "RAWwindow")' & exit 
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)RAW counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"RAWprogress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall bash
killall raw2dng
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi




#PRORES PROCESSING
if grep 'trap' /tmp/DUALISO/prores_TRAP
then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
   --------------
   $(tput setaf 0)$(tput bold)ProRes counter$(tput sgr0)
   --------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
cat<<EOF
   --------------
   $(tput setaf 0)$(tput bold)ProRes counter$(tput sgr0)
   --------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 5; 
do
cat<<EOF
   --------------
   $(tput setaf 0)$(tput bold)ProRes counter$(tput sgr0)
   --------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
#trap
    if ! grep -q 'trap' /tmp/DUALISO/prores_TRAP
    then
    echo -n -e "\033]0;PRORESwindow\007"
    kill $(echo $$)
    osascript -e 'tell application "Terminal" to close (every window whose name contains "PRORESwindow")' & exit 
    fi
    done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
cat<<EOF
   --------------
   $(tput setaf 0)$(tput bold)ProRes counter$(tput sgr0)
   --------------

  $(tput bold)$black$(cat /tmp/DUALISO/"FFmpeg"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall ffmpeg
killall aerender
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi





#CR2 PROCESSING
if grep -q 'CR2' /tmp/DUALISO/CR2progress_bar
then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)CR2 counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"CR2progress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)CR2 counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"CR2progress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 4; 
do
ls *.CR2 > /tmp/DUALISO/CR2progress_bar
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)CR2 counter$(tput sgr0)
    -----------

         $(tput bold)$black$(echo $(ls *.CR2 |wc -l) - $(ls *.DNG 2>/dev/null | grep -v "$(cat /tmp/DUALISO/NOT_list)" |wc -l) | bc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ! grep -q 'CR2' /tmp/DUALISO/CR2progress_bar
then
echo -n -e "\033]0;CR2window\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "CR2window")' & exit
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)CR2 counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"CR2progress_bar"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall cr2hdr
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi




#Sample file PROCESSING
if grep -q 'MLV' /tmp/DUALISO/samples
then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
    ------------
    $(tput setaf 0)$(tput bold)Sample count$(tput sgr0)
    ------------

  $(tput bold)$black$(cat /tmp/DUALISO/"samples"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit sampling$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
    ------------
    $(tput setaf 0)$(tput bold)Sample count$(tput sgr0)
    ------------

  $(tput bold)$black$(cat /tmp/DUALISO/"samples"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit sampling$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 4; 
do
cat<<EOF
    ------------
    $(tput setaf 0)$(tput bold)Sample count$(tput sgr0)
    ------------

  $(tput bold)$black$(cat /tmp/DUALISO/"samples"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit sampling$(tput sgr0)
EOF

if ! grep -q 'MLV' /tmp/DUALISO/samples
then
echo -n -e "\033]0;samplewindow\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "samplewindow")' & exit
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
    clear
cat<<EOF
    ------------
    $(tput setaf 0)$(tput bold)Sample count$(tput sgr0)
    ------------

  $(tput bold)$black$(cat /tmp/DUALISO/"samples"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit sampling$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
rm /tmp/DUALISO/samples
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall exiv2
killall exiftool
killall $mlv_dump 
killall ffmpeg
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi

#HDRCR2_grouping
if grep -q 'CR2' /tmp/DUALISO/CR2LIST
then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
  ----------------
  $(tput setaf 0)$(tput bold)HDR CR2 grouping$(tput sgr0)
  ----------------

  $(tput bold)$black$(cat /tmp/DUALISO/CR2LIST |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
  ----------------
  $(tput setaf 0)$(tput bold)HDR CR2 grouping$(tput sgr0)
  ----------------

  $(tput bold)$black$(cat /tmp/DUALISO/CR2LIST |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 1; 
do
cat<<EOF
  ----------------
  $(tput setaf 0)$(tput bold)HDR CR2 grouping$(tput sgr0)
  ----------------

  $(tput bold)$black$(cat /tmp/DUALISO/CR2LIST |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ! grep -q 'CR2' /tmp/DUALISO/CR2LIST
then
echo -n -e "\033]0;CR2window\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "CR2window")' & exit
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
    clear
cat<<EOF
  ----------------
  $(tput setaf 0)$(tput bold)HDR CR2 grouping$(tput sgr0)
  ----------------

  $(tput bold)$black$(cat /tmp/DUALISO/CR2LIST |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall hdrmerge
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi

#HDRCR2 brackets
if grep -q 'CR2' /tmp/DUALISO/LISTaa
then
cd "$(cat /tmp/DUALISO/path_1)"
    clear
cat<<EOF
  ----------
  $(tput setaf 0)$(tput bold)HDR brackets$(tput sgr0)
  ----------

 $(tput bold)$black$(cat $(ls /tmp/DUALISO/LISTa*) |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
  ------------
  $(tput setaf 0)$(tput bold)HDR brackets$(tput sgr0)
  ------------

 $(tput bold)$black$(cat $(ls /tmp/DUALISO/LISTa*) |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
printf '\e[8;09;20t'
printf '\e[3;955;0t'
while sleep 3; 
do
cat<<EOF
  ------------
  $(tput setaf 0)$(tput bold)HDR brackets$(tput sgr0)
  ------------

 $(tput bold)$black$(cat $(ls /tmp/DUALISO/LISTa*) |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF

if ! grep -q 'CR2' <<< "$(cat $(ls /tmp/DUALISO/LISTa*))" 
then
echo -n -e "\033]0;CR2window\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "CR2window")' & exit
fi
done & 

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
echo > /tmp/DUALISO/MLVprogress_bar_key
while : 
do 
    clear
cat<<EOF
  ------------
  $(tput setaf 0)$(tput bold)HDR brackets$(tput sgr0)
  ------------

 $(tput bold)$black$(cat $(ls /tmp/DUALISO/LISTa*) |wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
 $(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
killall sleep
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "K") 
killall sleep
killall hdrmerge
killall bash
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
fi
fi
fi
fi






#HDR_MOV bash
if ls /tmp/DUALISO/HDR_MOV 
then
printf '\e[8;9;24t'
printf '\e[3;955;0t'

while :
do 

clear
cat<<EOF
    ------------
    $(tput setaf 0)$(tput bold)HDR_MOV bash$(tput sgr0)
    ------------
 $(tput bold)$(tput setaf 1)(K) Kill HDR_MOV bash$(tput sgr0)
 $(tput bold)$(tput setaf 1)(q) Close this window$(tput sgr0)

Selection number:
EOF
    read -n1
    case "$REPLY" in
    "K") 
echo > /tmp/KILLMOV
killall sleep
killall align_image_stack
rm "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)"/*.tif
mv "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)"/*.{MOV,mov} "$(cat /tmp/DUALISO/path_1)"
if ! [ x"$(cat /tmp/HDRMOVaa | head -1)" = x ]
then
ln -s "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVaa | head -1)" "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)"
fi
rm "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)"/*.tif
mv "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)"/*.{MOV,mov} "$(cat /tmp/DUALISO/path_1)"
if ! [ x"$(cat /tmp/HDRMOVab | head -1)" = x ]
then
ln -s "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVab | head -1)" "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)"
fi
rm "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)"/*.tif
mv "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)"/*.{MOV,mov} "$(cat /tmp/DUALISO/path_1)"
if ! [ x"$(cat /tmp/HDRMOVac | head -1)" = x ]
then
ln -s "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVac | head -1)" "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)"
fi
rm "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)"/*.tif
mv "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)"/*.{MOV,mov} "$(cat /tmp/DUALISO/path_1)"
if ! [ x"$(cat /tmp/HDRMOVad | head -1)" = x ]
then
ln -s "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVad | head -1)" "$(cat /tmp/DUALISO/path_1)"/"$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)"
fi

sleep 2 && rm /tmp/HDR_script*.command &
rm /tmp/HDRMOV*
rm fps
rm dropframes
rm croprec
rm /tmp/HDR_script*.command
rm /tmp/KILLMOV

osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
;;


    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done
fi


#HDR_CR2
if ls /tmp/DUALISO/HDR_CR2 
then
if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" ]
then
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')"
else
cd "$(cat /tmp/DUALISO/path_1)"
fi
printf '\e[8;8;21t'
printf '\e[3;955;0t'

while sleep 2; 
do
if ! ls /tmp/HDR*.command >/dev/null 2>&1
then
afplay /System/Library/Sounds/Tink.aiff
sleep 0.5
afplay /System/Library/Sounds/Tink.aiff
sleep 0.5
afplay /System/Library/Sounds/Tink.aiff
sleep 0.5
echo -n -e "\033]0;CR2window\007"
kill $(echo $$)
osascript -e 'tell application "Terminal" to close (every window whose name contains "CR2window")' & exit
fi
done & 

cat<<EOF
       -------
       $(tput setaf 0)$(tput bold)HDR_CR2$(tput sgr0)
       -------

       $(tput bold)Working.....

$(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
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
dot6=
fi

if ! [ x"$dot5" = x ]
then
dot6=$(echo .)
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
       -------
       $(tput setaf 0)$(tput bold)HDR_CR2$(tput sgr0)
       -------

       $(tput bold)Working$dot1$dot2$dot3$dot4$dot5$dot6

$(tput bold)$(tput setaf 1)(K) Kill automator$(tput sgr0)
EOF
done &

    read -n1
    case "$REPLY" in
    "K") 
if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" ]
then
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')"
echo "$(head -n +1 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
else
cd "$(cat /tmp/DUALISO/path_1)"
fi
 rm /tmp/HDR*.command
 rm /tmp/list
 rm /tmp/match* 
 rm *preview3.jpg
 rm *.xmp
 rm /tmp/HDRmerge /tmp/enfuse /tmp/FFmpeg /tmp/all_in

killall hdrmerge
killall sleep
killall align_image_stack
killall enfuse
killall ffmpeg
killall exiv2
killall exiftool
#if AE project file included
 if ls *.aep >/dev/null 2>&1
 then
 killall aerender
 rm tmp1/$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 rm tmp2/$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 rm tmp3/$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 rm tmp4/$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 mv tmp1/*.CR2 *.cr2 *.xmp ./
 mv tmp2/*.CR2 *.cr2 ./
 mv tmp3/*.CR2 *.cr2 ./
 mv tmp4/*.CR2 *.cr2 ./
 mv tmp_$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev) $(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 rm AE_01.command
 rm AE_02.command
 rm AE_03.command
 rm AE_04.command
 rm -r tmp1 tmp2 tmp3 tmp4
 fi
killall bash 
sleep 0.3 && osascript -e 'tell application "Terminal" to close first window' & exit & osascript -e 'tell application "Terminal" to close first window' & exit & osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
;;


    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
fi

#disable due to catalina upgrade
#exec &> >(tee -a "$(cat /tmp/DUALISO/path_1)"/LOG.txt >&2 )

#The end
printf '\e[8;16;35t'
printf '\e[3;955;0t'
while :
do 
killall sleep
afplay /System/Library/Sounds/Tink.aiff 
clear
cat<<EOF
Total running time:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_time")$(tput sgr0)
X to FFmpeg ProRes:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_xprores" 2>/dev/null)$(tput sgr0)
mlv_dump:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_mlv_dump" 2>/dev/null)$(tput sgr0)
raw2dng:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_raw2dng" 2>/dev/null)$(tput sgr0)
dcraw_FFmpeg ProRes:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_prores" 2>/dev/null)$(tput sgr0)
cr2hdr(CR2 files):   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_cr2hdr" 2>/dev/null)$(tput sgr0)

$(tput bold)$(tput setaf 1)(q) Exit$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 

#disable due to catalina upgrade
#exec &> >(tee -a "$(cat /tmp/DUALISO/path_1)"/LOG.txt >&2 )

#The end
printf '\e[8;16;35t'
printf '\e[3;955;0t'
while :
do 
killall sleep
afplay /System/Library/Sounds/Tink.aiff 
clear
cat<<EOF
Total running time:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_time")$(tput sgr0)
X to FFmpeg ProRes:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_xprores" 2>/dev/null)$(tput sgr0)
mlv_dump:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_mlv_dump" 2>/dev/null)$(tput sgr0)
raw2dng:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_raw2dng" 2>/dev/null)$(tput sgr0)
dcraw_FFmpeg ProRes:   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_prores" 2>/dev/null)$(tput sgr0)
cr2hdr(CR2 files):   
$(tput bold)$black$(cat /tmp/DUALISO/"TOT_cr2hdr" 2>/dev/null)$(tput sgr0)

$(tput bold)$(tput setaf 1)(q) Exit$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
osascript -e 'tell application "Terminal" to close first window' & exit
;;
    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
