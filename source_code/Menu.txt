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


#DUALISO_CR2

if ls /tmp/DUALISO/DUALISO
then
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;33;50t'
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
if grep 'compress' /tmp/A_cr2hdr_settings.txt 
then 
lole=$(echo "$bold""$green"added!"$normal")
fi
if grep 'compress-lossy' /tmp/A_cr2hdr_settings.txt 
then 
lossy=$(echo "$bold""$green"added!"$normal")
lole=
fi

while :
do 

    clear
    cat<<EOF
    ===============
    ${bold}$(tput setaf 1)cr2hdr settings$(tput sgr0)
    ---------------
note! Reenter selection to erase.

${bold}Interpolation methods$(tput sgr0)
    $(tput bold)(a)$(tput sgr0) Amaze edge(default) $amaze			 
    $(tput bold)(m)$(tput sgr0) Mean23(faster) $mean  

${bold}Chroma smoothing$(tput sgr0)
    $(tput bold)(2)$(tput sgr0) apply 2x2(default) $cs2				 
    $(tput bold)(3)$(tput sgr0) apply 3x3 $cs3
    $(tput bold)(5)$(tput sgr0) apply 5x5 $cs5				 
    $(tput bold)(d)$(tput sgr0) disable chroma smoothing $nocs

${bold}Flicker handling$(tput sgr0)
    $(tput bold)(s)$(tput sgr0) same-levels(avoid flicker) $salev  

${bold}DNG compression$(tput sgr0)(requires Adobe DNG Converter) 
    $(tput bold)(l)$(tput sgr0) lossless $lole
    $(tput bold)(k)$(tput sgr0) lossy $lossy

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ml) mlv_dump settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p)  ProRes output$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run dualiso processing$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit cr2hdr$(tput sgr0)  					        					

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

    "d")
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
if grep 'compress-lossy' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --compress-lossy//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--compress-lossy//g'
fi
if grep 'compress' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --compress//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--compress//g'
lole=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --compress-lossy//g'
echo -n " --compress" >> /tmp/A_cr2hdr_settings.txt
lole=$(echo "$bold""$green"added!"$normal")
lossy=
fi
;;
 
    "k")
if grep 'compress-lossy' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --compress-lossy//g'
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--compress-lossy//g'
if grep 'lossy' /tmp/A_cr2hdr_settings.txt 
then 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/-lossy//g'
fi
lossy=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --compress//g'
echo -n " --compress-lossy" >> /tmp/A_cr2hdr_settings.txt
lossy=$(echo "$bold""$green"added!"$normal")
lole=
fi
;;

    "E")
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy=
rm /tmp/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
;;

    "ml") 
printf '\e[8;23;60t'
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

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr=

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
if grep ' --fixcp' /tmp/mlv_dump_settings 
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
if ls "$(cat /tmp/DUALISO/list_dng_look)"/A_lut_hold/MLV_RAW_my_darkframes.txt
then
dafr=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    --------
    $(tput bold)mlv_dump$(tput sgr0)
    --------
	
-- DNG output --
    $(tput bold)(01) no chroma smoothing$(tput sgr0)   $nocs
    $(tput bold)(02) 2x2 chroma smoothing$(tput sgr0)  $cs2	
    $(tput bold)(03) 3x3 chroma smoothing$(tput sgr0)  $cs3
    $(tput bold)(04) 5x5 chroma smoothing$(tput sgr0)  $cs5
    $(tput bold)(05) fix cold pixels$(tput sgr0)  $fixcp 
    $(tput bold)(06) fix non-static (moving) cold pixels (slow) $fixcp2
    $(tput bold)(07) disable vertical stripes in highlights  $nostripes

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  quit MLP$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ml) cr2hdr menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) Run cr2hdr$(tput sgr0)
			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
if grep 'no-cs' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --no-cs" >> /tmp/mlv_dump_settings
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
if grep 'cs2' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs2x2" >> /tmp/mlv_dump_settings
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
if grep 'cs3' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs3x3" >> /tmp/mlv_dump_settings
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
if grep 'cs5' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs5x5" >> /tmp/mlv_dump_settings
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
if grep ' --fixcp2' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
fi
if grep ' --fixcp' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
echo -n " --fixcp" >> /tmp/mlv_dump_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
fi
;;

    "06")
if grep ' --fixcp2' /tmp/mlv_dump_settings 
then
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find /tmp/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp//g'
echo -n " --fixcp2" >> /tmp/mlv_dump_settings
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
echo -n " --no-stripes" >> /tmp/mlv_dump_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "E")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr=
rm /tmp/mlv_dump_settings 1> /dev/null 2>&1 &
;;

    "ml")  
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

    "p") 
printf '\e[8;35;65t'
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
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_Proxy
mkdir -p "$(cat /tmp/DUALISO/path_1)"/$(date +%F)_ProRes4444

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= 

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

if grep 'AWB' /tmp/FFmpeg_settings 
then
AWB=$(echo "$bold""$green"added!"$normal")
fi
if grep 'HL' /tmp/FFmpeg_settings 
then
HL=$(echo "$bold""$green"added!"$normal")
fi

while :
do 

    clear
    cat<<EOF
    -------------
    $(tput bold)ProRes output$(tput sgr0)
    -------------
	
-- ProRes4444 output --
    $(tput bold)(01) linear to cineon$(tput sgr0)(recommended)   $lincin
    $(tput bold)(02) linear to logC$(tput sgr0)(recommended)  $linlogC	
    $(tput bold)(03) linear$(tput sgr0)  $linear
    $(tput bold)(04) rec709$(tput sgr0)  $rec709 
    $(tput bold)(05) xyz$(tput sgr0)  $xyz
    $(tput bold)(06) aces$(tput sgr0)  $aces

-- ProRes Proxy output —
    $(tput bold)(07) linear to cineon$(tput sgr0)   $lincinpr
    $(tput bold)(08) linear to logC$(tput sgr0)  $linlogCpr
    $(tput bold)(09) linear$(tput sgr0)  $linearpr
    $(tput bold)(10) rec709$(tput sgr0)  $rec709pr 
    $(tput bold)(11) xyz$(tput sgr0)  $xyzpr
    $(tput bold)(12) aces$(tput sgr0)  $acespr

-- Other settings --
    $(tput bold)(13) auto white balance$(tput sgr0)   $AWB

-- 5D mark III white level(more highlight data. Not dualiso!) -- 
    $(tput bold)(14) set white level to 16383$(tput sgr0)(default 15000)  $HL 

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  quit MLP$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p)  cr2hdr menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  Run cr2hdr$(tput sgr0)			 
  					        					
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

    "08")
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

    "09")
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

    "10")
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


    "11")
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

    "12")
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

    "13")
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
fi
;;

    "14")
if grep 'HL' /tmp/FFmpeg_settings 
then
find /tmp/FFmpeg_settings | xargs perl -pi -e 's/HL//g' 
HL=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "HL" >> /tmp/FFmpeg_settings
HL=$(echo "$bold""$green"added!"$normal")
fi
;;

    "p")  
. "$(cat /tmp/DUALISO/path_2)"Menu.command
;;

    "r")  
rm /tmp/DUALISO/DUALISO 
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "E")
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL=  
rm /tmp/FFmpeg_settings 1> /dev/null 2>&1 &
rm /tmp/FFmpeg_settingsPR 1> /dev/null 2>&1 &
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

    "r")  
perl -pi -e 's/^[\ \t]+|[\ \t]+$//g' /tmp/A_cr2hdr_settings.txt
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