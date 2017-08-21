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

printf '\e[8;55;65t'
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
if ls ~/Switch/config/output
then
mkdir -p "$(cat ~/Switch/config/output)"/$(date +%F)_Proxy
mkdir -p "$(cat ~/Switch/config/output)"/$(date +%F)_ProRes4444
else
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
fi

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; HDRa= ; halfhdra= ; wle= 

if grep 'lincineon' ~/Switch/config/FFmpeg_settings 
then
lincin=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linlogC' ~/Switch/config/FFmpeg_settings 
then
linlogC=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linear' ~/Switch/config/FFmpeg_settings 
then
linear=$(echo "$bold""$green"added!"$normal")
fi
if grep 'rec709' ~/Switch/config/FFmpeg_settings 
then
rec709=$(echo "$bold""$green"added!"$normal")
fi
if grep 'xyz' ~/Switch/config/FFmpeg_settings 
then
xyz=$(echo "$bold""$green"added!"$normal")
fi
if grep 'aces' ~/Switch/config/FFmpeg_settings 
then
aces=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat ~/Switch/config/_X_pres_SCALE) = x ] 
then
Pscale=$(echo "$bold""$green"added!"$normal")
Paspect=$(cat ~/Switch/config/_X_pres_SCALE)
else
Pscale=
Paspect=
fi
if grep 'lincineonpr' ~/Switch/config/FFmpeg_settingsPR 
then
lincinpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linlogCpr' ~/Switch/config/FFmpeg_settingsPR 
then
linlogCpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'linearpr' ~/Switch/config/FFmpeg_settingsPR 
then
linearpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'rec709pr' ~/Switch/config/FFmpeg_settingsPR 
then
rec709pr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'xyzpr' ~/Switch/config/FFmpeg_settingsPR 
then
xyzpr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'acespr' ~/Switch/config/FFmpeg_settingsPR 
then
acespr=$(echo "$bold""$green"added!"$normal")
fi
if grep 'Pcodec_lt' ~/Switch/config/FFmpeg_settingsPR 
then
Pcodec_lt=$(echo "$bold""$green"added!"$normal")
fi
if ! [ x$(cat ~/Switch/config/prox_SCALE) = x ] 
then
Xscale=$(echo "$bold""$green"added!"$normal")
Xaspect=$(cat ~/Switch/config/prox_SCALE)
else
Xscale=
Xaspect=
fi

if ! [ x$(cat ~/Switch/config/denoise) = x ] 
then
denoise=$(echo "$bold""$green"denoise!"$normal")
else
denoise=
fi
if ! [ x$(cat ~/Switch/config/sharpen) = x ] 
then
sharpen=$(echo "$bold""$green"sharpen!"$normal")
else
sharpen=
fi

if grep 'AWB' ~/Switch/config/FFmpeg_settings 
then
AWB=$(echo "$bold""$green"added!"$normal")
fi
if grep 'dcrawA' ~/Switch/config/FFmpeg_settings 
then
dcrawA=$(echo "$bold""$green"added!"$normal")
fi

if grep 'HDR' ~/Switch/config/pr4444_HDR
then
HDRa=$(echo "$bold""$green"added!"$normal")
fi
if grep 'halfhdr' ~/Switch/config/pr4444_HDR
then
halfhdra=$(echo "$bold""$green"added!"$normal")
fi

if [ -f ~/Switch/config/FFmpeg_white_level ]
then
wle=$(cat ~/Switch/config/FFmpeg_white_level)
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
    $(tput bold)(01) linear to cineon$(tput sgr0)(recommended)   $lincin
    $(tput bold)(02) linear to logC$(tput sgr0)(recommended)  $linlogC	
    $(tput bold)(03) linear$(tput sgr0)  $linear
    $(tput bold)(04) rec709$(tput sgr0)  $rec709 
    $(tput bold)(05) xyz$(tput sgr0)  $xyz
    $(tput bold)(06) aces$(tput sgr0)  $aces
-- other settings(ProRes4444)
    $(tput bold)(07) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$Paspect$(tput sgr0) $Pscale

-- ProRes Proxy output —
    $(tput bold)(08) linear to cineon$(tput sgr0)   $lincinpr
    $(tput bold)(09) linear to logC$(tput sgr0)  $linlogCpr
    $(tput bold)(10) linear$(tput sgr0)  $linearpr
    $(tput bold)(11) rec709$(tput sgr0)  $rec709pr 
    $(tput bold)(12) xyz$(tput sgr0)  $xyzpr
    $(tput bold)(13) aces$(tput sgr0)  $acespr
    $(tput bold)(14) Switch to ProRes LT codec$(tput sgr0)  $Pcodec_lt
-- other settings(proxy)
    $(tput bold)(15) scale output$(tput sgr0)  $(tput bold)$(tput setaf 4)$Xaspect$(tput sgr0) $Xscale

-- Denoise and sharpen filters --
    $(tput bold)(16) set denoise and sharpening$(tput sgr0)  $denoise $sharpen

-- misc settings --
    $(tput bold)(17) auto white balance$(tput sgr0)(median of 6 dng files)$(tput sgr0) $AWB
    $(tput bold)(18) dcraw auto white balance$(tput sgr0)$(tput sgr0) $dcrawA
    $(tput bold)(19) set white level  $(tput setaf 4)$wle$(tput sgr0)

-- HDR output(affects both prores4444 and proxy) --
    $(tput bold)(20) HDR footage$(tput sgr0)(e.g 100/1600iso) $HDRa
    $(tput bold)(21) drop frames$(tput sgr0)(50fps to 25fps etc) $halfhdra

    $(tput bold)$(tput setaf 1)(mp) MlRawViewer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ho) HOWTO$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'lincineon' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g' 
lincin=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "lincineon" >> ~/Switch/config/FFmpeg_settings
lincin=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
linlogC=
linear=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "02")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'linlogC' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
linlogC=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linlogC" >> ~/Switch/config/FFmpeg_settings
linlogC=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linear=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "03")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'linear' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g' 
linear=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linear" >> ~/Switch/config/FFmpeg_settings
linear=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
rec709=
sRGB=
xyz=
aces=
fi
;;

    "04")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'rec709' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g' 
rec709=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "rec709" >> ~/Switch/config/FFmpeg_settings
rec709=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
linear=
sRGB=
xyz=
aces=
fi
;;

    "05")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'xyz' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g' 
xyz=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "xyz" >> ~/Switch/config/FFmpeg_settings
xyz=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g'
lincin=
linlogC=
linear=
rec709=
sRGB=
aces=
fi
;;

    "06")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_ProRes4444
if grep 'aces' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/aces//g' 
aces=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "aces" >> ~/Switch/config/FFmpeg_settings
aces=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/lincineon//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linlogC//g' 
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/linear//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/rec709//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/sRGB//g'
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/xyz//g'
lincin=
linlogC=
linear=
rec709=
sRGB=
xyz=
fi
;;

     "07")
if ! [ x$(cat ~/Switch/config/_X_pres_SCALE) = x ]
then
rm ~/Switch/config/_X_pres_SCALE 1> /dev/null 2>&1 &
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
echo $input_variable:-1 > ~/Switch/config/_X_pres_SCALE
if ! [ x$(cat ~/Switch/config/_X_pres_SCALE) = x ]
then
Pscale=$(echo "$bold""$green"added!"$normal")
Paspect=$(cat ~/Switch/config/_X_pres_SCALE)
else
Pscale=
Paspect=
fi
fi
sleep 1 
printf '\e[8;55;65t'
printf '\e[3;450;0t'
;;

    "08")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'lincineonpr' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g' 
lincinpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "lincineonpr" >> ~/Switch/config/FFmpeg_settingsPR
lincinpr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
linlogCpr=
linearpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "09")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'linlogCpr' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
linlogCpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linlogCpr" >> ~/Switch/config/FFmpeg_settingsPR
linlogCpr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linearpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "10")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'linearpr' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g' 
linearpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "linearpr" >> ~/Switch/config/FFmpeg_settingsPR
linearpr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
rec709pr=
xyzpr=
acespr=
fi
;;

    "11")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'rec709pr' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g' 
rec709pr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "rec709pr" >> ~/Switch/config/FFmpeg_settingsPR
rec709pr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
linearpr=
xyzpr=
acespr=
fi
;;


    "12")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'xyzpr' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g' 
xyzpr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "xyzpr" >> ~/Switch/config/FFmpeg_settingsPR
xyzpr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g'
lincinpr=
linlogCpr=
linearpr=
rec709pr=
acespr=
fi
;;

    "13")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'acespr' ~/Switch/config/tmp/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/acespr//g' 
acespr=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "acespr" >> ~/Switch/config/FFmpeg_settingsPR
acespr=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/lincineonpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linlogCpr//g' 
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/linearpr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/rec709pr//g'
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/xyzpr//g'
lincinpr=
linlogCpr=
linearpr=
rec709pr=
xyzpr=
fi
;;

    "14")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
if grep 'Pcodec_lt' ~/Switch/config/FFmpeg_settingsPR 
then
find ~/Switch/config/FFmpeg_settingsPR | xargs perl -pi -e 's/Pcodec_lt//g' 
Pcodec_lt=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "Pcodec_lt" >> ~/Switch/config/FFmpeg_settingsPR
Pcodec_lt=$(echo "$bold""$green"added!"$normal")
fi
;;

     "15")
if ! [ x$(cat ~/Switch/config/prox_SCALE) = x ]
then
rm ~/Switch/config/prox_SCALE 1> /dev/null 2>&1 &
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
echo $input_variable:-1 > ~/Switch/config/prox_SCALE
if ! [ x$(cat ~/Switch/config/prox_SCALE) = x ]
then
Xscale=$(echo "$bold""$green"added!"$normal")
Xaspect=$(cat ~/Switch/config/prox_SCALE)
else
Xscale=
Xaspect=
fi
fi
sleep 1 
printf '\e[8;55;65t'
printf '\e[3;450;0t'
;;

    "16")
mkdir -p "$(cat ~/Switch/config/tmp/path_1)"/$(date +%F)_Proxy
printf '\e[8;25;60t'
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

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=

if grep 'hqdn3d=0:0:2:2' ~/Switch/config/denoise
then
sl_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:4:4' ~/Switch/config/denoise 
then
me_h=$(echo "$bold""$green"added!"$normal")
fi
if grep 'hqdn3d=0:0:6:6' ~/Switch/config/denoise 
then
st_h=$(echo "$bold""$green"added!"$normal")
fi

if grep 'unsharp=5:5:1.0:5:5:0.0' ~/Switch/config/sharpen 
then
sl_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=7:7:0.8:7:7:0' ~/Switch/config/sharpen 
then
me_s=$(echo "$bold""$green"added!"$normal")
fi
if grep 'unsharp=9:9:1.0:9:9:0' ~/Switch/config/sharpen 
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
if grep 'hqdn3d=0:0:2:2' ~/Switch/config/denoise 
then
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:2:2" >> ~/Switch/config/denoise
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight denoising"$(tput sgr0) ; 
fi
;;

    "2")
if grep 'hqdn3d=0:0:4:4' ~/Switch/config/denoise 
then
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:4:4" >> ~/Switch/config/denoise
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium denoising"$(tput sgr0) ; 
fi
;;

    "3")
if grep 'hqdn3d=0:0:6:6' ~/Switch/config/denoise 
then
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:6:6//g' 
st_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_h=$(echo "$bold""$green"added!"$normal")
echo -n "hqdn3d=0:0:6:6" >> ~/Switch/config/denoise
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:2:2//g' 
sl_h=
find ~/Switch/config/denoise | xargs perl -pi -e 's/hqdn3d=0:0:4:4//g' 
me_h=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong denoising"$(tput sgr0) ; 
fi
;;

    "4")
if grep 'unsharp=5:5:1.0:5:5:0.0' ~/Switch/config/sharpen 
then
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
sl_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=5:5:1.0:5:5:0.0" >> ~/Switch/config/sharpen
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g'
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Slight sharpening"$(tput sgr0) ; 
fi
;;

    "5")
if grep 'unsharp=7:7:0.8:7:7:0' ~/Switch/config/sharpen 
then
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
me_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=7:7:0.8:7:7:0" >> ~/Switch/config/sharpen
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Medium sharpening"$(tput sgr0) ; 
fi
;;

    "6")
if grep 'unsharp=9:9:1.0:9:9:0' ~/Switch/config/sharpen 
then
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=9:9:1.0:9:9:0//g' 
st_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
st_s=$(echo "$bold""$green"added!"$normal")
echo -n "unsharp=9:9:1.0:9:9:0" >> ~/Switch/config/sharpen
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=5:5:1.0:5:5:0.0//g' 
sl_s=
find ~/Switch/config/sharpen | xargs perl -pi -e 's/unsharp=7:7:0.8:7:7:0//g' 
me_s=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Strong sharpening"$(tput sgr0) ; 
fi
;;



#go back to prores menu

    "q") 
. tif_spit.sh
;;

    "E")
sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm ~/Switch/config/denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/sharpen 1> /dev/null 2>&1 &
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;

    "17")
if grep 'AWB' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/AWB//g' 
AWB=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "AWB" >> ~/Switch/config/FFmpeg_settings
AWB=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/dcrawA//g'
dcrawA=
fi
;;

    "18")
if grep 'dcrawA' ~/Switch/config/FFmpeg_settings 
then
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/dcrawA//g' 
dcrawA=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "dcrawA" >> ~/Switch/config/FFmpeg_settings
dcrawA=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/FFmpeg_settings | xargs perl -pi -e 's/AWB//g'
AWB=
fi
;;

    "19")
if [ -f ~/Switch/config/FFmpeg_white_level ]
then
rm ~/Switch/config/FFmpeg_white_level
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
printf "%s\n" "$input_variable" > ~/Switch/config/FFmpeg_white_level
wle=$(cat ~/Switch/config/FFmpeg_white_level)
fi
sleep 1 
printf '\e[8;55;65t'
printf '\e[3;450;0t'
;;

    "20")
mkdir -p "$(cat ~/Switch/config/tmp/"path_1")"/$(date +%F)_ProRes4444
if grep 'HDR' ~/Switch/config/tmp/pr4444_HDR
then
find ~/Switch/config/tmp/pr4444_HDR | xargs perl -pi -e 's/HDR//g'
HDRa=
find ~/Switch/config/tmp/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "HDR" >> ~/Switch/config/tmp/pr4444_HDR
HDRa=$(echo "$bold""$green"added!"$normal")
fi
;;

    "21")
mkdir -p "$(cat ~/Switch/config/tmp/"path_1")"/$(date +%F)_ProRes4444
if grep 'halfhdr' ~/Switch/config/tmp/pr4444_HDR 
then
find ~/Switch/config/tmp/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "halfhdr" >> ~/Switch/config/tmp/pr4444_HDR
halfhdra=$(echo "$bold""$green"added!"$normal")
if ! grep 'HDR' ~/Switch/config/tmp/pr4444_HDR
then
echo "HDR" >> ~/Switch/config/tmp/pr4444_HDR
HDRa=$(echo "$bold""$green"added!"$normal")
fi
fi
;;

    "p")  
. Menu.sh
;;

    "r")
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
;;

    "mp")
"$(cat ~/Switch/config/tmp/"path_2")"bin/MlRawViewer.app/Contents/MacOS/mlrawviewer "$(cat ~/Switch/config/tmp/"path_1")" & sleep 2
rm "$(cat ~/Switch/config/tmp/"path_1")"/*.WAV
rm "$(cat ~/Switch/config/tmp/"path_1")"/*.MRX
while [ -n "$(pgrep mlrawviewer </dev/null)" ];
do sleep 1
done
rm "$(cat ~/Switch/config/tmp/"path_1")"/*.WAV
rm "$(cat ~/Switch/config/tmp/"path_1")"/*.MRX
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
printf '\e[8;55;65t'
printf '\e[3;450;0t'
;;
    esac
;;

    "E")
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; AE= ; HDRa= ; halfhdra=
rm ~/Switch/config/pr4444_HDR
rm ~/Switch/config/FFmpeg_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm ~/Switch/config/_X_pres_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/prox_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/sharpen 1> /dev/null 2>&1 &
;;

    "q") 
echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &

exit 0
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
