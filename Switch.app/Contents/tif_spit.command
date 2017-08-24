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

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra= ; wle= ; AE_HDR= ; codec_422= ; DEL_DNG=

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
if grep 'codec_422' /tmp/FFmpeg_settings
then
codec_422=$(echo "$bold""$green"added!"$normal")
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
    $(tput bold)(07) switch to ProRes 422 codec(faster)$(tput sgr0) $codec_422
-- other settings(ProRes4444)
    $(tput bold)(08) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$Paspect$(tput sgr0) $Pscale

-- ProRes Proxy output —
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

    $(tput bold)$(tput setaf 1)(X)  Delete dng folders after ProRes is created$(tput sgr0) $DEL_DNG
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
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444
if grep 'codec_422' /tmp/FFmpeg_settings
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/codec_422//g' 
codec_422=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "codec_422" >> /tmp/FFmpeg_settings
codec_422=$(echo "$bold""$green"added!"$normal")
fi
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
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; codec_422= ; DEL_DNG=
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
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=  ; wle= ; AE_HDR= ; codec_422= ; DEL_DNG=
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
"$(cat /tmp/DUALISO/"path_2")"bin/MlRawViewer.app/Contents/MacOS/mlrawviewer "$(cat /tmp/DUALISO/"path_1")" & sleep 2
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
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=
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
else
#restarts the tif spitting
echo > /tmp/DUALISO/tif_spit
cd "$(cat /tmp/DUALISO/path_1)"   
ls -d *C0000 > /tmp/DUALISO/FFmpeg 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_produce_01.command & sleep 1 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_produce_02.command & sleep 1
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_produce_03.command & sleep 1 
. "$(cat /tmp/DUALISO/path_2)"FFmpeg_produce_04.command & sleep 1
fi