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

#export path
    export PATH=$PATH:~/Switch/bin

#(11) MLV_COMPRESS
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi

    rm ~/Switch/config/tmp/MLV_cprs_del
    if [ -f ~/Switch/config/tmp/MLV_cprs ]
    then
#enter parent folder
    cd "$(cat ~/Switch/config/tmp/path_1)"
    OLDIFS=$IFS
#list all MLV files
    ls *.MLV > ~/Switch/config/tmp/MLV_cprs

    #Will move terminal window to the right corner
    printf '\e[8;16;60t'
    printf '\e[3;450;75t'

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

    dcmrs=

if ls ~/Switch/config/tmp/MLV_dcmrs
then
dcmrs=$(echo "$bold""$green"added!"$normal")
else
dcmrs=
fi


while : 
do 
    if [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    printf '\e[8;18;60t'
    printf '\e[3;450;75t'
    clear
cat<<EOF
       		 -------------------
       		 $(tput setaf 0)$(tput bold)MLV compressor(lj92)$(tput sgr0) A.Baldwin
       		 -------------------

   	     $(tput bold)$black$count

Output:$(tput setaf 4)$(cat ~/Switch/config/tmp/"MLV_cprs_output")$(tput setaf 0)
$(tput sgr0)reselect$(tput bold)$(tput setaf 1)(O)$(tput sgr0)to erase path

$(tput bold)$(tput setaf 1)(O) select output folder$(tput sgr0)(leave it for same folder)
$(tput bold)$(tput setaf 1)(c) run compressor(lj92)$(tput sgr0)(keep orig MLV files. Recommended) 
$(tput bold)$(tput setaf 1)(d) decompress MLV(lj92)$(tput setaf 0)$(tput sgr0)(compress is default) $dcmrs

$(tput bold)$(tput setaf 1)(q) exit MLV compressing$(tput sgr0)$(tput setaf 0)
EOF
    else
    clear
cat<<EOF
       		 -------------------
       		 $(tput setaf 0)$(tput bold)MLV compressor(lj92)$(tput sgr0) A.Baldwin
       		 -------------------

   	     $(tput bold)$black$count

$(tput bold)$(tput setaf 1)(O) select output folder$(tput sgr0)(leave it for same folder)
$(tput bold)$(tput setaf 1)(c) run compressor(lj92)$(tput sgr0)(keep orig MLV files.Recommended)
$(tput bold)$(tput setaf 1)(d) decompress MLV(lj92)$(tput setaf 0)$(tput sgr0)(compress is default) $dcmrs

$(tput bold)$(tput setaf 1)(q) exit MLV compressing$(tput sgr0)$(tput setaf 0)
EOF
    fi
    read -n1
    case "$REPLY" in

    "O") 
    if ! [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    echo > ~/Switch/config/tmp/MLV_cprs_out
    open "$(cat ~/Switch/config/tmp/path_2)"new_output.app
    printf '\e[8;10;50t'
    printf '\e[3;410;0t'
    clear
    echo "


    ${bold}$(tput setaf 2)Select compressed MLV output$(tput sgr0)"
    sleep 1

    #trap
    while ls ~/Switch/config/tmp/MLV_cprs_out &>/dev/null
    do
    sleep 0.3
    done
    clear
    echo "


    ${bold}$(tput setaf 2)added Path:$(tput setaf 4)"$(cat ~/Switch/config/tmp/MLV_cprs_output)"$(tput sgr0)"
    path=$(echo "$bold""$green"added!"$normal")
    sleep 2  
    clear &
    Menu_dish.sh
    else
    rm ~/Switch/config/tmp/MLV_cprs_output
    clear &
    path=
    echo "


    ${bold}$(tput setaf 1)path removed$(tput setaf 4)$(tput sgr0)"
    sleep 1
    clear &
    Menu_dish.sh
    fi
    ;;


    "c") 
    rm ~/Switch/config/tmp/MLV_cprs_del
#list all MLV files
    ls *.MLV > ~/Switch/config/tmp/MLV_cprs
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/MLV_cprs ) / 4 + 1 )) ~/Switch/config/tmp/MLV_cprs ~/Switch/config/tmp/MLV_cprs
    MLV_cprs_01.sh & pid1=$!
    MLV_cprs_02.sh & pid2=$!
    MLV_cprs_03.sh & pid3=$!
    MLV_cprs_04.sh & pid4=$!
#wait for jobs to end
    wait < <(jobs -p)
rm *MLV.wav
rm tmp.wav
    ;;


    "d")
    echo > ~/Switch/config/tmp/MLV_dcmrs
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/MLV_cprs ) / 4 + 1 )) ~/Switch/config/tmp/MLV_cprs ~/Switch/config/tmp/MLV_cprs
    MLV_cprs_01.sh & pid1=$!
    MLV_cprs_02.sh & pid2=$!
    MLV_cprs_03.sh & pid3=$!
    MLV_cprs_04.sh & pid4=$!
#wait for jobs to end
    wait < <(jobs -p)
rm *MLV.wav
rm tmp.wav
;;


    "q") 
    rm ~/Switch/config/tmp/MLV_dcmrs
    rm ~/Switch/config/tmp/MLV_cprs_del
    rm ~/Switch/config/tmp/MLV_cprs 2>/dev/null
    echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &
    exit 0 
    ;;


    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
    fi



#Copyright Danne
