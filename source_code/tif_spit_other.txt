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

#returns tif spit to raw to ProRes menu options
#!/bin/bash
if ls /tmp/DUALISO/tif_back
then
killall ffmpeg 
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
copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale ; aspect= ; PRscale ; PRaspect= ; denoise= ; sharpen= ; PRscale= ; PRaspect= ; scale= ; aspect=
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
else
#restarts the tif spitting
echo > /tmp/DUALISO/tif_spit
cd "$(cat /tmp/DUALISO/path_1)"   
for f in *; do [[ -f "$f" ]] && ls "$f" | grep -v 'RAW\|R00\|R01\|R02\|R03\|R04\|R05\|R06\|R07\|R08\|R09\|R10\|R11\|R12\|R13\|R14\|R15\|MLV\|M00\|M01\|M02\|M03\|M04\|M05\|M06\|M07\|M08\|M09\|\|M10\|M11\|M12\|M13\|M14\|M15\|CR2\|dng\|DNG\|txt\|TXT\|tif\|tiff\|TIF\|TIFF\|jpg\|JPG\|cube\|CUBE\|command' >> /tmp/DUALISO/FFmpeg_ALL; done 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_ALL_01.command & sleep 1 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_ALL_02.command & sleep 1
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_ALL_03.command & sleep 1 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_ALL_04.command & sleep 1
fi