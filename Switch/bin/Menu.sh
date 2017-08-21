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


#Check if filmed crop_rec
#menu RAW_demolish settings
#new output folder
#Main menu
#DUALISO_CR2
#mlv_dump
#mlv_dump_on_steroids
#ProRes output

#!/bin/bash

#export path
    export PATH=$PATH:~/Switch/bin

#Check if filmed crop_rec
if [ -f ~/Switch/config/tmp/crop_rec? ]
then
#!/bin/bash
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;16;95t'
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
rm ~/Switch/config/tmp/crop_rec?
echo > ~/Switch/config/tmp/crop_rec
sleep 1
. Menu.sh
;;

    "02")  
rm ~/Switch/config/tmp/crop_rec?
sleep 1
. Menu.sh
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
fi

#Main menu
if [ -f ~/Switch/config/tmp/MENU ]
then
#!/bin/bash

#new output folder
if ! [ -f ~/Switch/config/tmp/O_trap ]
then
if [ -f ~/Switch/config/output ]
then
echo > ~/Switch/config/tmp/O_trap
mkdir -p "$(cat ~/Switch/config/output)"
out=$(cat ~/Switch/config/output)
bold="$(tput bold)"
normal="$(tput sgr0)"
blue="$(tput setaf 4)"
green="$(tput setaf 2)"
clear
printf '\e[8;16;95t'
printf '\e[3;410;100t'
echo "

"$(tput bold)"your current output folder is "$(tput setaf 4)"$(cat ~/Switch/config/output)""$(tput sgr0)"
sleep 2
else
out=
fi
fi

#output
if [ -f ~/Switch/config/output ]
then
out=$(cat ~/Switch/config/output)
fi

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;23;55t'
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

FLAT= ; DARK= ; darkfr_storage= ; cr2hdr_a= ; mlv_dump_a= ; X_pro_a= ; pro_a=

if [ -f ~/Switch/config/tmp/FLATFRAMES ]
then
FLAT=$(echo "$bold""$green"added!"$normal")
fi
if [ -f ~/Switch/config/DARK ]
then
DARK=$(echo "$bold""$green"added!"$normal")
fi
if [ -f ~/Switch/config/DARK_FOLDER ]
then
if [ -d "$(cat ~/Switch/config/DARK_FOLDER)" ]
then
DARK=$(echo "$bold""$green"Storage_added!"$normal")
darkfr_storage=$(cat ~/Switch/config/"DARK_FOLDER")
else
rm ~/Switch/config/DARK_FOLDER
DARK=
darkfr_storage=
fi
fi
if [ -f ~/Switch/config/tmp/FLATFRAME_A ]
then
FLAT=$(echo "$bold""$green"added!"$normal")
fi

if [ -f ~/Switch/config/FULL_AUTO ]
then
auto=$(echo "$bold""$green"auto mode!"$normal")
if [ -f ~/Switch/config/A_cr2hdr_settings.txt ]
then
cr2hdr_a=$(echo "$bold""$green"auto mode!"$normal")
fi
mlv_dump_a=$(echo "$bold""$green"auto mode!"$normal")
if [ -f ~/Switch/config/FFmpeg_settings* ]
then
pro_a=$(echo "$bold""$green"auto mode!"$normal")
fi
if [ -f ~/Switch/config/_X_Pro* ]
then
X_pro_a=$(echo "$bold""$green"auto mode!"$normal")
fi
if [ -f ~/Switch/config/DARK ]
then
DARK=$(echo "$bold""$green"auto mode!"$normal")
fi
fi

while :
do 

    clear
    cat<<EOF
    =========
    ${bold}Main menu$(tput sgr0)
    ---------

$(tput bold)output: $(tput setaf 4)$out$(tput sgr0)
$(tput bold)darkframe storage:$(tput setaf 4)$darkfr_storage$(tput setaf 4)$(tput sgr0)
$(tput bold)afplayer: $(tput setaf 4)$shuf$(tput sgr0)

    $(tput bold)$(tput setaf 1)(m)  mlv_dump settings$(tput sgr0)$(tput bold)(MLV)$(tput sgr0) $mlv_dump_a
    $(tput bold)$(tput setaf 1)(ms) mlv_dump_on_steroids settings$(tput sgr0)$(tput bold)(MLV)$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p)  ProRes output$(tput sgr0)$(tput bold)(MLV,RAW,dng)$(tput sgr0) $pro_a
    $(tput bold)$(tput setaf 1)(d)  cr2hdr dualiso processing$(tput sgr0)$(tput bold)(CR2)$(tput sgr0) $cr2hdr_a

    $(tput bold)$(tput setaf 1)(C)  select new output folder$(tput sgr0)$(tput bold)(MLV,RAW,dng,mov)$(tput sgr0)
    $(tput bold)$(tput setaf 1)(R)  reset Switch to defaults$(tput sgr0)
    $(tput bold)$(tput setaf 1)(A)  darkframe average automation$(tput sgr0)$(tput bold)$(tput sgr0) $DARK
    $(tput bold)$(tput setaf 1)(F)  flatframe average automation$(tput sgr0)$(tput bold)$(tput sgr0) $FLAT
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r)  run Switch$(tput sgr0)   

Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in



    "d")
#DUALISO_CR2

#Erase full auto setting

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;33;50t'
printf '\e[3;410;0t'

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

if grep 'amaze' ~/Switch/config/A_cr2hdr_settings.txt 
then 
amaze=$(echo "$bold""$green"added!"$normal")
fi
if grep 'mean' ~/Switch/config/A_cr2hdr_settings.txt 
then 
mean=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2x2' ~/Switch/config/A_cr2hdr_settings.txt 
then 
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3x3' ~/Switch/config/A_cr2hdr_settings.txt 
then 
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5x5' ~/Switch/config/A_cr2hdr_settings.txt 
then 
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-cs' ~/Switch/config/A_cr2hdr_settings.txt 
then 
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'levels' ~/Switch/config/A_cr2hdr_settings.txt 
then 
salev=$(echo "$bold""$green"added!"$normal")
fi
if grep 'compress' ~/Switch/config/A_cr2hdr_cmpr.txt 
then 
lole=$(echo "$bold""$green"added!"$normal")
fi
if grep 'compress-lossy' ~/Switch/config/A_cr2hdr_cmpr.txt 
then 
lossy=$(echo "$bold""$green"added!"$normal")
lole=
fi
if ls ~/Switch/config/cpuboost
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

${bold}Chroma smoothing$(tput sgr0)
    $(tput bold)(2)$(tput sgr0) apply 2x2(default) $cs2				 
    $(tput bold)(3)$(tput sgr0) apply 3x3 $cs3
    $(tput bold)(5)$(tput sgr0) apply 5x5 $cs5				 
    $(tput bold)(di)$(tput sgr0) disable chroma smoothing $nocs

${bold}Flicker handling$(tput sgr0)
    $(tput bold)(s)$(tput sgr0) same-levels(avoid flicker) $salev  

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
if grep 'amaze' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --amaze-edge//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--amaze-edge//g'
amaze=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --amaze-edge" >> ~/Switch/config/A_cr2hdr_settings.txt
amaze=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --mean23//g' 
mean=
fi
;;

    "m")
if grep 'mean' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --mean23//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--mean23//g'
mean=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --mean23" >> ~/Switch/config/A_cr2hdr_settings.txt
mean=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --amaze-edge//g' 
amaze=
fi
;;

    "2")
if grep 'cs2x2' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs2x2//g'
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs2x2" >> ~/Switch/config/A_cr2hdr_settings.txt
cs2=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g' 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs3=
cs5=
fi
;;

    "3")
if grep 'cs3x3' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs3x3//g'
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs3x3" >> ~/Switch/config/A_cr2hdr_settings.txt
cs3=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs2=
cs5=
fi
;;

    "5")
if grep 'cs5x5' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--cs5x5//g'
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --cs5x5" >> ~/Switch/config/A_cr2hdr_settings.txt
cs5=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
nocs=
cs2=
cs3=
fi
;;

    "di")
if grep 'no-cs' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--no-cs//g'
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --no-cs" >> ~/Switch/config/A_cr2hdr_settings.txt
nocs=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs3x3//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "s")
if grep 'levels' ~/Switch/config/A_cr2hdr_settings.txt 
then 
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/ --same-levels//g'
find ~/Switch/config/A_cr2hdr_settings.txt | xargs perl -pi -e 's/--same-levels//g'
salev=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo -n " --same-levels" >> ~/Switch/config/A_cr2hdr_settings.txt
salev=$(echo "$bold""$green"added!"$normal")
fi
;;
   
    "B")
if ls ~/Switch/config/cpuboost 
then 
rm ~/Switch/config/cpuboost
cpu=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > ~/Switch/config/cpuboost
cpu=$(echo "$bold""$green"added!"$normal")
fi
;;

    "E")
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy= ; out=
rm ~/Switch/config/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm ~/Switch/config/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm ~/Switch/config/cpuboost 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/O_trap 1> /dev/null 2>&1 &
;;

    "d")  
. Menu.sh
;;

    "r")  
perl -pi -e 's/^[\ \t]+|[\ \t]+$//g' ~/Switch/config/A_cr2hdr_settings.txt
if [ -f ~/Switch/config/tmp/tif_spit ]
then
rm ~/Switch/config/tmp/tif_spit
fi
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
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
;;



#mlv_dump
    "m") 
#erase mlv_dump_on_steroids settings
rm ~/Switch/config/mlv_dump_on_steroids_UNC
rm ~/Switch/config/mlv_dump_on_steroids_settings

#output
if [ -f ~/Switch/config/output ]
then
out=$(cat ~/Switch/config/output)
fi

printf '\e[8;36;67t'
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
    echo > ~/Switch/config/dualisodisable

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; dual= ; c= ; cc= ; ccc= ; ato=
if grep 'no-cs' ~/Switch/config/mlv_dump_settings 
then
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2' ~/Switch/config/mlv_dump_settings 
then
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3' ~/Switch/config/mlv_dump_settings 
then
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5' ~/Switch/config/mlv_dump_settings 
then
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixcp' ~/Switch/config/mlv_dump_settings 
then
fixcp=$(echo "$bold""$green"added!"$normal")
fi
if grep ' --fixcp2' ~/Switch/config/mlv_dump_settings 
then
fixcp=
fixcp2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-stripes' ~/Switch/config/mlv_dump_settings 
then
nostripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'black-fix' ~/Switch/config/mlv_dump_settings 
then
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' ~/Switch/config/mlv_dump_settings)
fi
if grep 'white-fix' ~/Switch/config/mlv_dump_settings 
then
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' ~/Switch/config/mlv_dump_settings)
fi
if ls ~/Switch/config/dualisodisable
then
dual=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-c' ~/Switch/config/mlv_dump_settings 
then
c=$(echo "$bold""$green"added!"$normal")
fi
if [ -f ~/Switch/config/mlv_dump_UNC ] 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc= ; ato=
rm ~/Switch/config/mlv_dump_settings
ccc=$(echo "$bold""$green"added!"$normal")
cc=
fi
if grep 'd' ~/Switch/config/mlv_dump_UNC 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato=
rm ~/Switch/config/mlv_dump_settings
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
if grep 'relaxed\|skip-xref' ~/Switch/config/mlv_dump_settings 
then
ato=$(echo "$bold""$green"added!"$normal")
else
ato=
fi
if grep 'relaxed' ~/Switch/config/mlv_dump_UNC
then
ato=$(echo "$bold""$green"added!"$normal")
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
    $(tput bold)(16) create a sample files package$(tput sgr0)$(tput sgr0) 

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(m)  Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch$(tput sgr0)
			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'no-cs' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-cs" >> ~/Switch/config/mlv_dump_settings
nocs=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g'
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "02")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'cs2' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs2x2" >> ~/Switch/config/mlv_dump_settings
cs2=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs3=
cs5=
fi
;;

    "03")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'cs3' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs3x3" >> ~/Switch/config/mlv_dump_settings
cs3=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs2=
cs5=
fi
;;

    "04")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'cs5' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs5x5" >> ~/Switch/config/mlv_dump_settings
cs5=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --cs3x3//g'
nocs=
cs2=
cs3=
fi
;;



    "05")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'no-fixcp' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixcp" >> ~/Switch/config/mlv_dump_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g'
fi
;;

    "06")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep ' --fixcp2' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-fixcp//g'
printf "%s\n" " --fixcp2" >> ~/Switch/config/mlv_dump_settings
fixcp2=$(echo "$bold""$green"added!"$normal")
fixcp=
fi
;;

    "07")
if grep 'no-stripes' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ --no-stripes//g' 
nostripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-stripes" >> ~/Switch/config/mlv_dump_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;



    "08")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'black-fix' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}black-fix.{0,6}' ~/Switch/config/mlv_dump_settings)"'//g'
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
printf "%s\n" " --black-fix"=$input_variable >> ~/Switch/config/mlv_dump_settings
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' ~/Switch/config/mlv_dump_settings)
fi
sleep 1 
printf '\e[8;36;67t'
printf '\e[3;450;0t'
;;

    "09")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep 'white-fix' ~/Switch/config/mlv_dump_settings 
then
find ~/Switch/config/mlv_dump_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}white-fix.{0,6}' ~/Switch/config/mlv_dump_settings)"'//g'
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
printf "%s\n" " --white-fix"=$input_variable >> ~/Switch/config/mlv_dump_settings
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' ~/Switch/config/mlv_dump_settings)
fi
sleep 1 
printf '\e[8;36;67t'
printf '\e[3;450;0t'
;;


    "10")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep ' \-c' ~/Switch/config/mlv_dump_settings 
then
perl -pi -e 's/ -c//g' ~/Switch/config/mlv_dump_settings
c=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -c" >> ~/Switch/config/mlv_dump_settings
c=$(echo "$bold""$green"added!"$normal")
fi
;;

    "11")
rm ~/Switch/config/mlv_dump_UNC
cc=
echo > ~/Switch/config/tmp/MLV_cprs
. Menu_dish.sh
;;


    "12")
if [ x"$ccc" = x ]
then
if [ -f ~/Switch/config/mlv_dump_UNC ]
then
rm ~/Switch/config/mlv_dump_UNC
cc=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato=
rm ~/Switch/config/mlv_dump_settings
printf "%s\n" "-c -c -d" > ~/Switch/config/mlv_dump_UNC
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
else
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; ccc= ; ato=
rm ~/Switch/config/mlv_dump_settings
printf "%s\n" "-c -c -d" > ~/Switch/config/mlv_dump_UNC
cc=$(echo "$bold""$green"added!"$normal")
ccc=
fi
;;

    "13")
if [ x"$cc" = x ]
then
if [ -f ~/Switch/config/mlv_dump_UNC ]
then
rm ~/Switch/config/mlv_dump_UNC
ccc=
ato=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc=
printf "%s\n" "-c -c" > ~/Switch/config/mlv_dump_UNC
if grep 'relaxed' ~/Switch/config/mlv_dump_settings 
then
printf "%s\n" " --relaxed" >> ~/Switch/config/mlv_dump_UNC
rm ~/Switch/config/mlv_dump_settings
fi
ccc=$(echo "$bold""$green"added!"$normal")
cc=
fi
else
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc=
rm ~/Switch/config/mlv_dump_settings
printf "%s\n" "-c -c" > ~/Switch/config/mlv_dump_UNC
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

if grep 'relaxed' ~/Switch/config/mlv_dump_settings 
then
rel=$(echo "$bold""$green"added!"$normal")
fi
if grep 'skip-xref' ~/Switch/config/mlv_dump_settings 
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
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep ' \--relaxed' ~/Switch/config/mlv_dump_settings 
then
perl -pi -e 's/ --relaxed//g' ~/Switch/config/mlv_dump_settings
rel=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --relaxed" >> ~/Switch/config/mlv_dump_settings
rel=$(echo "$bold""$green"added!"$normal")
fi
;;

    "2")
rm ~/Switch/config/mlv_dump_UNC
cc=
if grep ' \--skip-xref' ~/Switch/config/mlv_dump_settings 
then
perl -pi -e 's/ --skip-xref//g' ~/Switch/config/mlv_dump_settings
skip=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --skip-xref" >> ~/Switch/config/mlv_dump_settings
skip=$(echo "$bold""$green"added!"$normal")
fi
;;

    "m")  
. Menu.sh
;;

    "q") 
echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &

exit 0
;;

    "r")  
if [ -f ~/Switch/config/tmp/tif_spit ]
then
rm ~/Switch/config/tmp/tif_spit
fi
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;



    "15")
if ! ls ~/Switch/config/dualisodisable
then 
echo > ~/Switch/config/dualisodisable
dual=$(echo "$bold""$green"added!"$normal")
else
rm ~/Switch/config/dualisodisable
dual=
fi
;;


    "16")
#mlv_dump settings
    mlv=$(cat ~/Switch/config/mlv_dump_settings)
cd "$(cat ~/Switch/config/tmp/"path_1")"
#list all mlv files
    ls *.MLV > ~/Switch/config/tmp/samples
#menu
    rm ~/Switch/config/tmp/MLVprogress_bar_key
    open "$(cat ~/Switch/config/tmp/path_2)"progress_bar.sh &
    while grep 'MLV' ~/Switch/config/tmp/samples
    do
cd "$(cat ~/Switch/config/tmp/"path_1")"
mkdir -p "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples
#Debug log file
    rm "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exec &> >(tee -a "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt >&2 )
    OLDIFS=$IFS
    mlv_dump -f 4 -o "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)" "$(cat ~/Switch/config/tmp/samples | head -1)" &
    mlv_dump $mlv --dng -f 0 -o "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)" "$(cat ~/Switch/config/tmp/samples | head -1)" & sleep 2
    killall mlv_dump
    mv "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"000000.dng "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng
    mlv_dump -v "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)"
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exiftool "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    if ls "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    then
    rm "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".MLV.wav
    exiftool "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    fi
    zip "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)" "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    mv "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples.zip ./
    rm -r "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples 
    IFS=$OLDIFS 
    echo "$(tail -n +2 ~/Switch/config/tmp/samples)" > ~/Switch/config/tmp/samples
    done
cd ..
;;

    "E")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= dual= ; c= ; cc= ; ccc= ; ato=
rm ~/Switch/config/mlv_dump_UNC
rm ~/Switch/config/mlv_dump_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/dualisodisable 1> /dev/null 2>&1 &
;;

    "m")  
. Menu.sh
;;

    "r")  
if [ -f ~/Switch/config/tmp/tif_spit ]
then
rm ~/Switch/config/tmp/tif_spit
fi
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
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
;;


#mlv_dump_on_steroids
    "ms")
#erase mlv_dump settings 
if ! [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
then
echo > ~/Switch/config/mlv_dump_on_steroids_settings
fi
rm ~/Switch/config/mlv_dump_UNC
rm ~/Switch/config/mlv_dump_settings

#output
if [ -f ~/Switch/config/output ]
then
out=$(cat ~/Switch/config/output)
fi

printf '\e[8;41;67t'
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
    echo > ~/Switch/config/dualisodisable

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; dual= ; p= ; c= ; cc= ; ccc= ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm=
if grep 'no-cs' ~/Switch/config/mlv_dump_on_steroids_settings 
then
nocs=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs2' ~/Switch/config/mlv_dump_on_steroids_settings 
then
cs2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs3' ~/Switch/config/mlv_dump_on_steroids_settings 
then
cs3=$(echo "$bold""$green"added!"$normal")
fi
if grep 'cs5' ~/Switch/config/mlv_dump_on_steroids_settings 
then
cs5=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-fixcp' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fixcp=$(echo "$bold""$green"added!"$normal")
fi
if grep ' --fixcp2' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fixcp=
fixcp2=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-stripes' ~/Switch/config/mlv_dump_on_steroids_settings 
then
nostripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'black-fix' ~/Switch/config/mlv_dump_on_steroids_settings 
then
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
if grep 'white-fix' ~/Switch/config/mlv_dump_on_steroids_settings 
then
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
if ls ~/Switch/config/dualisodisable
then
dual=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \-c' ~/Switch/config/mlv_dump_on_steroids_settings 
then
c=$(echo "$bold""$green"added!"$normal")
fi
if [ -f ~/Switch/config/mlv_dump_on_steroids_UNC ] 
then
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; c= ; cc= ; ccc= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm=
rm ~/Switch/config/mlv_dump_on_steroids_settings
p=$(echo "$bold""$green"added!"$normal")
fi
if grep 'relaxed' ~/Switch/config/mlv_dump_on_steroids_settings 
then
ato=$(echo "$bold""$green"added!"$normal")
else
ato=
fi
if grep 'relaxed' ~/Switch/config/mlv_dump_on_steroids_UNC
then
ato=$(echo "$bold""$green"added!"$normal")
fi
if grep 'no-audio' ~/Switch/config/mlv_dump_on_steroids_settings 
then
w=$(echo "$bold""$green"added!"$normal")
fi
if grep 'force-stripes' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fstripes=$(echo "$bold""$green"added!"$normal")
fi
if grep 'fpn' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fpn=$(echo "$bold""$green"added!"$normal")
fi
if grep 'deflicker' ~/Switch/config/mlv_dump_on_steroids_settings 
then
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
if grep ' \-b' ~/Switch/config/mlv_dump_on_steroids_settings 
then
btp=$(grep -Eo '.{0,0}-b.{0,3}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
if grep 'no-bitpack' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fdepth=$(echo "$bold""$green"added!"$normal")
fi
if grep ' \--fpi' ~/Switch/config/mlv_dump_on_steroids_settings 
then
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
if grep ' \--bpi' ~/Switch/config/mlv_dump_on_steroids_settings 
then
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)
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
    $(tput bold)(01) no chroma smoothing$(tput sgr0)   $nocs
    $(tput bold)(02) 2x2 chroma smoothing$(tput sgr0)  $cs2	
    $(tput bold)(03) 3x3 chroma smoothing$(tput sgr0)  $cs3
    $(tput bold)(04) 5x5 chroma smoothing$(tput sgr0)  $cs5
    $(tput bold)(05) turn off cold pixels$(tput sgr0)  $fixcp 
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
    $(tput bold)(20) focus pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=1$(tput bold)$(tput setaf 4) $fcpm$(tput sgr0)
    $(tput bold)(21) bad pixel method: $(tput sgr0)(mlvfs=0),(raw2dng=1),default=0$(tput bold)$(tput setaf 4) $bpm$(tput sgr0)
    $(tput bold)(22) disable dualiso automation$(tput sgr0)  $dual
    $(tput bold)(23) create a sample files package$(tput sgr0)

    $(tput bold)$(tput setaf 1)(E)  erase all settings$(tput sgr0)
    $(tput bold)$(tput setaf 1)(ms) Main menu$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit Switch$(tput sgr0)
    $(tput bold)$(tput setaf 1)(r) ${bold}$(tput setaf 1) run Switch$(tput sgr0)
			 
  					        					
Please enter your selection number below and hit enter:
EOF
    read -n2
    case "$REPLY" in

    "01")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'no-cs' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g' 
nocs=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-cs" >> ~/Switch/config/mlv_dump_on_steroids_settings
nocs=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g'
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
cs2=
cs3=
cs5=
fi
;;

    "02")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'cs2' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
cs2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs2x2" >> ~/Switch/config/mlv_dump_on_steroids_settings
cs2=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs3=
cs5=
fi
;;

    "03")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'cs3' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g' 
cs3=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs3x3" >> ~/Switch/config/mlv_dump_on_steroids_settings
cs3=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g'
nocs=
cs2=
cs5=
fi
;;

    "04")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'cs5' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs5x5//g' 
cs5=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --cs5x5" >> ~/Switch/config/mlv_dump_on_steroids_settings
cs5=$(echo "$bold""$green"added!"$normal")
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-cs//g'
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs2x2//g' 
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --cs3x3//g'
nocs=
cs2=
cs3=
fi
;;

    "05")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'no-fixcp' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixcp//g' 
fixcp=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-fixcp" >> ~/Switch/config/mlv_dump_on_steroids_settings
fixcp=$(echo "$bold""$green"added!"$normal")
fixcp2=
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --fixcp2//g'
fi
;;

    "06")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' --fixcp2' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --fixcp2//g' 
fixcp2=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-fixcp//g'
printf "%s\n" " --fixcp2" >> ~/Switch/config/mlv_dump_on_steroids_settings
fixcp2=$(echo "$bold""$green"added!"$normal")
fixcp=
fi
;;

    "07")
if grep 'no-stripes' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-stripes//g' 
nostripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-stripes" >> ~/Switch/config/mlv_dump_on_steroids_settings
nostripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "08")
if grep 'force-stripes' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --force-stripes//g' 
fstripes=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --force-stripes" >> ~/Switch/config/mlv_dump_on_steroids_settings
fstripes=$(echo "$bold""$green"added!"$normal")
fi
;;

    "09")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'black-fix' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}black-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " --black-fix"=$input_variable >> ~/Switch/config/mlv_dump_on_steroids_settings
bll=$(grep -Eo '.{0,0}black-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;

    "10")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'white-fix' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}white-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " --white-fix"=$input_variable >> ~/Switch/config/mlv_dump_on_steroids_settings
wll=$(grep -Eo '.{0,0}white-fix.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;


    "11")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' \-c' ~/Switch/config/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ -c//g' ~/Switch/config/mlv_dump_on_steroids_settings
c=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " -c" >> ~/Switch/config/mlv_dump_on_steroids_settings
c=$(echo "$bold""$green"added!"$normal")
fi
;;

    "12")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
echo > ~/Switch/config/tmp/MLV_cprs
if ! [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
then
echo > ~/Switch/config/mlv_dump_on_steroids_settings
fi
. Menu_dish.sh
;;


    "13")
if [ -f ~/Switch/config/mlv_dump_on_steroids_UNC ]
then
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm=
rm ~/Switch/config/mlv_dump_on_steroids_settings
printf "%s\n" "-p" > ~/Switch/config/mlv_dump_on_steroids_UNC
p=$(echo "$bold""$green"added!"$normal")
fi
;;

    "14")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'no-audio' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-audio//g' 
w=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-audio" >> ~/Switch/config/mlv_dump_on_steroids_settings
w=$(echo "$bold""$green"added!"$normal")
fi
;;

    "15")  
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' \--relaxed' ~/Switch/config/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ --relaxed//g' ~/Switch/config/mlv_dump_on_steroids_settings
ato=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --relaxed" >> ~/Switch/config/mlv_dump_on_steroids_settings
ato=$(echo "$bold""$green"added!"$normal")
fi
;;

    "16")  
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'fpn' ~/Switch/config/mlv_dump_on_steroids_settings 
then
perl -pi -e 's/ --fpn//g' ~/Switch/config/mlv_dump_on_steroids_settings
fpn=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --fpn" >> ~/Switch/config/mlv_dump_on_steroids_settings
fpn=$(echo "$bold""$green"added!"$normal")
fi
;;

    "17")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'deflicker' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,2}deflicker.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " --deflicker"=$input_variable >> ~/Switch/config/mlv_dump_on_steroids_settings
dfl=$(grep -Eo '.{0,0}deflicker.{0,6}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;

    "18")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' \-b' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}-b.{0,3}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " -b $input_variable" >> ~/Switch/config/mlv_dump_on_steroids_settings
btp=$(grep -Eo '.{0,0}-b.{0,3}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;

    "19")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep 'no-bitpack' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ --no-bitpack//g' 
fdepth=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
printf "%s\n" " --no-bitpack" >> ~/Switch/config/mlv_dump_on_steroids_settings
fdepth=$(echo "$bold""$green"added!"$normal")
fi
;;

    "20")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' \--fpi' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--fpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " --fpi $input_variable" >> ~/Switch/config/mlv_dump_on_steroids_settings
fcpm=$(grep -Eo '.{0,0}fpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;

    "21")
rm ~/Switch/config/mlv_dump_on_steroids_UNC
p=
if grep ' \--bpi' ~/Switch/config/mlv_dump_on_steroids_settings 
then
find ~/Switch/config/mlv_dump_on_steroids_settings | xargs perl -pi -e 's/ '"$(grep -Eo '.{0,0}--bpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)"'//g'
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
printf "%s\n" " --bpi $input_variable" >> ~/Switch/config/mlv_dump_on_steroids_settings
bpm=$(grep -Eo '.{0,0}bpi.{0,2}' ~/Switch/config/mlv_dump_on_steroids_settings)
fi
sleep 1 
printf '\e[8;41;67t'
printf '\e[3;450;0t'
;;

    "22")
if ! ls ~/Switch/config/dualisodisable
then 
echo > ~/Switch/config/dualisodisable
dual=$(echo "$bold""$green"added!"$normal")
else
rm ~/Switch/config/dualisodisable
dual=
fi
;;

    "23")
if ! [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
then
echo > ~/Switch/config/mlv_dump_on_steroids_settings
fi
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
#mlv_dump settings
    mlv=$(cat ~/Switch/config/mlv_dump_on_steroids_settings)
cd "$(cat ~/Switch/config/tmp/"path_1")"
#list all mlv files
    ls *.MLV > ~/Switch/config/tmp/samples
#menu
    rm ~/Switch/config/tmp/MLVprogress_bar_key
    open "$(cat ~/Switch/config/tmp/path_2)"progress_bar.sh &
    while grep 'MLV' ~/Switch/config/tmp/samples
    do
cd "$(cat ~/Switch/config/tmp/"path_1")"
mkdir -p "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples
#Debug log file
    rm "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exec &> >(tee -a "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt >&2 )
    OLDIFS=$IFS
    $mlv_dump -f 4 -o "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)" "$(cat ~/Switch/config/tmp/samples | head -1)" &
    $mlv_dump $mlv --dng -f 0 -o "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)" "$(cat ~/Switch/config/tmp/samples | head -1)" & sleep 2
    killall $mlv_dump
    mv "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"000000.dng "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng
    $mlv_dump -v "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)"
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    exiftool "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
echo ###################################################################################################################### > "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt
    if ls "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    then
    rm "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".MLV.wav
    exiftool "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    fi
    zip "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1)" "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".dng "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_LOG.txt "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)".wav
    mv "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples/"$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples.zip ./
    rm -r "$(cat ~/Switch/config/tmp/samples | head -1 | cut -d "." -f1)"_samples 
    IFS=$OLDIFS 
    echo "$(tail -n +2 ~/Switch/config/tmp/samples)" > ~/Switch/config/tmp/samples
    done
cd ..
;;

    "E")
nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; bll= ; wll= dual= ; p= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm=
rm ~/Switch/config/mlv_dump_on_steroids_UNC
rm ~/Switch/config/mlv_dump_on_steroids_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/dualisodisable 1> /dev/null 2>&1 &
;;

    "ms")  
. Menu.sh
;;

    "r")  
if [ -f ~/Switch/config/tmp/tif_spit ]
then
rm ~/Switch/config/tmp/tif_spit
fi
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
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
;;


#ProRes output
    "p") 

#Erase full auto setting
if ls ~/Switch/config/tmp/FULL_AUTO
then
if ls ~/Switch/config/FFmpeg_settings*
then
pro_a=
rm ~/Switch/config/FFmpeg_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/FFmpeg_settingsPR 1> /dev/null 2>&1 &
clear 
echo "$(tput setaf 1)""Erased ProRes auto settings"
sleep 1
. Menu.sh
fi
fi

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
if grep 'acespr' ~/Switch/config/FFmpeg_settingsPR 
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
if grep 'HDR' ~/Switch/config/pr4444_HDR
then
find ~/Switch/config/pr4444_HDR | xargs perl -pi -e 's/HDR//g'
HDRa=
find ~/Switch/config/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "HDR" >> ~/Switch/config/pr4444_HDR
HDRa=$(echo "$bold""$green"added!"$normal")
fi
;;

    "21")
mkdir -p "$(cat ~/Switch/config/tmp/"path_1")"/$(date +%F)_ProRes4444
if grep 'halfhdr' ~/Switch/config/pr4444_HDR 
then
find ~/Switch/config/pr4444_HDR | xargs perl -pi -e 's/halfhdr//g' 
halfhdra=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo "halfhdr" >> ~/Switch/config/pr4444_HDR
halfhdra=$(echo "$bold""$green"added!"$normal")
if ! grep 'HDR' ~/Switch/config/pr4444_HDR
then
echo "HDR" >> ~/Switch/config/pr4444_HDR
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
lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; HDRa= ; halfhdra=  ; wle= 
rm ~/Switch/config/FFmpeg_white_level
rm ~/Switch/config/pr4444_HDR
rm ~/Switch/config/FFmpeg_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm ~/Switch/config/_X_pres_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/prox_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/sharpen 1> /dev/null 2>&1 &
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
;;


    "C")
if [ -f ~/Switch/config/output ]
then
rm ~/Switch/config/output
rm ~/Switch/config/tmp/O_trap
out=
else
#select folder path
    printf '\e[8;2;30t'
    printf '\e[3;150;0t'
    echo Select your output folder
    cd $(yad --center --file-selection --directory --title "Switch output")
#print path to working directory
    echo $PWD > ~/Switch/config/output
#now cd back to input folder
    cd $(cat ~/Switch/config/tmp/path_1)
. Menu.sh
fi
;;

    "R")
amaze= ; mean= ; cs2= ; cs3= ; cs5= ; nocs= ; salev= ; lole= ; lossy= ; out=
rm ~/Switch/config/tmp/crop_rec?
rm ~/Switch/config/tmp/crop_rec
rm ~/Switch/config/A_cr2hdr_settings.txt 1> /dev/null 2>&1 &
rm ~/Switch/config/A_cr2hdr_cmpr.txt 1> /dev/null 2>&1 &
rm ~/Switch/config/cpuboost 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/"$root"_settings.txt 1> /dev/null 2>&1 &
rm ~/Switch/config/output 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/O_trap 1> /dev/null 2>&1 &

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm ~/Switch/config/tmp/denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/sharpen 1> /dev/null 2>&1 &

nocs= ; cs2= ; cs3= ; cs5= ; fixcp2= ; fixcp= ; nostripes= ; dafr= ; dual= ; c= ; cc= ; p= ; ccc= ; ato= ; w= ; fstripes= ; fpn= ; dfl= ; btp= ; fdepth= ; fcpm= ; bpm=
rm ~/Switch/config/mlv_dump_UNC
rm ~/Switch/config/mlv_dump_on_steroids_UNC
rm ~/Switch/config/mlv_dump_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/mlv_dump_on_steroids_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/dualisodisable 1> /dev/null 2>&1 &

lincin= ; linlogC= ; linear= ; rec709= ; xyz= ; aces= ; lincinpr= ; linlogCpr= ; linearpr= ; rec709pr= ; xyzpr= ; acespr= ; AWB= ; HL= ; dcrawA= ; Pcodec_lt= ; Pscale= ; Paspect= ; Xscale= ; Xaspect= ; denoise= ; sharpen= ; auto= ; HDRa= ; halfhdra= ; wle=
rm ~/Switch/config/FFmpeg_white_level
rm ~/Switch/config/pr4444_HDR
rm ~/Switch/config/FFmpeg_settings 1> /dev/null 2>&1 &
rm ~/Switch/config/FFmpeg_settingsPR 1> /dev/null 2>&1 &
rm ~/Switch/config/_X_pres_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/prox_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/sharpen 1> /dev/null 2>&1 &

sl_h= ; me_h= ; st_h= ; sl_s= ; me_s= ; st_s=
rm ~/Switch/config/tmp/_X_denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_sharpen 1> /dev/null 2>&1 &

copy= ; logN= ; login= ; Clog= ; logC= ; Xaces= ; copypr= ; logNpr= ; loginpr= ; Clogpr= ; logCpr= ; Xacespr= ; codec_lt= ; HDR= ; halfhdr= ; scale= ; aspect= ; PRscale= ; PRaspect= ; denoise= ; sharpen= ; auto= ; DARK= ; FLAT= ; darkfr_storage= ; TAG= ; cr2hdr_a= ; mlv_dump_a= ; X_pro_a= ; pro_a= 
rm ~/Switch/config/tmp/_X_ProRes4444 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_Proxy 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_HDR 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_HDR 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_HDR_02 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_HDR_03 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_HDR_04 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_proxy_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_prores_SCALE 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_denoise 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/_X_sharpen 1> /dev/null 2>&1 &
rm ~/Switch/config/DARK 1> /dev/null 2>&1 &
rm ~/Switch/config/DARK_FOLDER 1> /dev/null 2>&1 &
rm ~/Switch/config/NO_DNG 1> /dev/null 2>&1 &
rm ~/Switch/config/only_DNG
rm ~/Switch/config/full_DARK
rm ~/Switch/config/DARK
rm ~/Switch/config/only_DARK
rm ~/Switch/config/tmp/DEAD_P 1> /dev/null 2>&1 &
rm ~/Switch/config/FLAT 1> /dev/null 2>&1 &
rm ~/Switch/config/FLATFRAMES 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/FLATFRAME_A 1> /dev/null 2>&1 &
rm ~/Switch/config/tmp/SCALETAG 1> /dev/null 2>&1 &
;; 


#darkframe processing
    "A")
#!/bin/bash
#Dependency IMAGEMAGICK
if ! [ -f /usr/bin/convert ]
then
clear
printf '\e[8;10;95t'
printf '\e[3;410;100t'
read -p $(tput bold)"IMAGEMAGICK needs to be installed. 
Will you let Switch do it for you?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
#installs IMAGEMAGICK
sudo apt-get install imagemagick
else
clear
echo "Automated darkframe processing won work without IMAGEMAGICK, sorry"
sleep 2
echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &
exit 0
fi
fi
#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner
#printf '\e[3;0;0t'
printf '\e[8;22;95t'
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

NO_DNG= ; DP= ; only_DNG= ; full_DARK= ; DARK_FOLDER= ; only_DARK=

if ls ~/Switch/config/full_DARK
then 
full_DARK=$(echo "$bold""$green"added!"$normal")
fi

if ls ~/Switch/config/NO_DNG
then 
NO_DNG=$(echo "$bold""$green"added!"$normal")
fi

if ls ~/Switch/config/only_DNG
then 
only_DNG=$(echo "$bold""$green"added!"$normal")
fi

if ls ~/Switch/config/DARK_FOLDER
then 
DARK_FOLDER=$(echo "$bold""$green"added!"$normal")
fi

if ls ~/Switch/config/only_DARK
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
if ls ~/Switch/config/only_DNG
then 
rm ~/Switch/config/only_DNG &>/dev/null &
rm ~/Switch/config/DARK
only_DNG=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > ~/Switch/config/only_DNG
echo > ~/Switch/config/DARK
only_DNG=$(echo "$bold""$green"added!"$normal")
rm ~/Switch/config/NO_DNG &>/dev/null &
NO_DNG=
rm ~/Switch/config/full_DARK
full_DARK=
rm ~/Switch/config/only_DARK
only_DARK=
fi
if [ -f ~/Switch/config/DARK_FOLDER ]
then 
rm ~/Switch/config/DARK
fi
;;


    "2")  
if ls ~/Switch/config/NO_DNG
then 
rm ~/Switch/config/NO_DNG &>/dev/null &
rm ~/Switch/config/DARK
NO_DNG=
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
Removed"$(tput sgr0) ; 
else 
echo > ~/Switch/config/NO_DNG
echo > ~/Switch/config/DARK
NO_DNG=$(echo "$bold""$green"added!"$normal")
rm ~/Switch/config/only_DNG &>/dev/null &
only_DNG=
rm ~/Switch/config/full_DARK
full_DARK=
rm ~/Switch/config/only_DARK
only_DARK=
fi
if [ -f ~/Switch/config/DARK_FOLDER ]
then 
rm ~/Switch/config/DARK
fi
;;


    "3")  
if ! ls ~/Switch/config/full_DARK
then 
rm ~/Switch/config/NO_DNG &>/dev/null &
NO_DNG=
rm ~/Switch/config/only_DNG &>/dev/null &
only_DNG=
rm ~/Switch/config/only_DARK
only_DARK=
echo > ~/Switch/config/full_DARK
echo > ~/Switch/config/DARK
full_DARK=$(echo "$bold""$green"added!"$normal")
else
rm ~/Switch/config/full_DARK
rm ~/Switch/config/DARK
full_DARK=
fi
if [ -f ~/Switch/config/DARK_FOLDER ]
then 
rm ~/Switch/config/DARK
fi
;;

    "4")  
if ! ls ~/Switch/config/only_DARK
then 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER=
rm ~/Switch/config/DARK
rm ~/Switch/config/NO_DNG
rm ~/Switch/config/full_DARK
rm ~/Switch/config/DARK_FOLDER
rm ~/Switch/config/only_DNG
echo > ~/Switch/config/only_DARK
echo > ~/Switch/config/DARK
only_DARK=$(echo "$bold""$green"added!"$normal")
else
rm ~/Switch/config/only_DARK
rm ~/Switch/config/DARK
only_DARK=
fi
;;

    "5") 
if [ -f ~/Switch/config/DARK_FOLDER ]
then 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER=
rm ~/Switch/config/DARK
rm ~/Switch/config/NO_DNG
rm ~/Switch/config/full_DARK
rm ~/Switch/config/DARK_FOLDER
rm ~/Switch/config/only_DNG
rm ~/Switch/config/only_DARK
clear
echo "

${bold}$(tput setaf 1)Storage path removed!$(tput sgr0)"
sleep 1
DARK_FOLDER=
else
if [ -f ~/Switch/config/DARK ]
then
rm ~/Switch/config/DARK &>/dev/null &
fi
if [ -f ~/Switch/config/only_DARK ]
then
rm ~/Switch/config/only_DARK
only_DARK=
fi
#select folder path
clear
printf '\e[8;4;40t'
printf '\e[3;200;50t'
    echo Select darkframe storage folder
    cd $(yad --center --file-selection --directory --title "Darkframe storage")
#print path to working directory
    echo $PWD > ~/Switch/config/DARK_FOLDER
#now cd back to input folder
    cd $(cat ~/Switch/config/tmp/path_1)
. Menu.sh
fi
;;

    "R") 
NO_DNG= ; only_DNG= ; full_DARK= ; DARK_FOLDER= ; only_DARK=
rm ~/Switch/config/DARK
rm ~/Switch/config/NO_DNG
rm ~/Switch/config/full_DARK
rm ~/Switch/config/DARK_FOLDER
rm ~/Switch/config/only_DNG
rm ~/Switch/config/only_DARK
;;

    "m") 
clear
. Menu.sh
;;

    "q")   
echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &
exit 0
;;

    "r")
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
;;




#flatframe processing
    "F")
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
if ls ~/Switch/config/tmp/FLATFRAME_A
then
rm ~/Switch/config/tmp/FLATFRAME_A 1> /dev/null 2>&1 &
FLAT=
else
FLAT=$(echo "$bold""$green"added!"$normal")
echo > ~/Switch/config/tmp/FLATFRAME_A
printf '\e[8;16;63t'
printf '\e[3;410;100t'
clear
read -p $(tput bold)"Would you rather select flatframe and darkflat manually?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
#add file so automator know what to choose in script
rm ~/Switch/config/tmp/FLATFRAME_A 1> /dev/null 2>&1 &

#select folder path
clear
printf '\e[8;4;50t'
printf '\e[3;200;50t'
    echo Select your flatframe and a darkframe if needed
    yad --center --file-selection --multiple --separator="
" --title "My chosen flatframe" > ~/Switch/config/tmp/FLATFRAMES
#now cd back to input folder
    cd $(cat ~/Switch/config/tmp/path_1)
. Menu.sh
else
clear
printf '\e[8;4;40t'
printf '\e[3;200;50t'
echo "Good luck!"
sleep 1
. Menu.sh
fi
fi
;;

    "r")
printf '\e[8;16;95t'
printf '\e[3;410;100t'
exit 0
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
exit 0
fi

#Copyright Danne
