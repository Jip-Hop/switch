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
printf '\e[8;40;50t'
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

    $(tput bold)$(tput setaf 1)(ml) mlv_dump settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) run dualiso processing$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q) exit cr2hdr$(tput sgr0) 
 					        					

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

    "ml") 
printf '\e[8;30;60t'
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