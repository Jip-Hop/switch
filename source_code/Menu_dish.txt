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

export PATH="$(cat /tmp/DUALISO/"path_2")":$PATH

#(16) Alter whitelevel (16383)
#(17) Alter whitelevel (15000)
#(19) auto white balance
#(20) Camera model name correction
#(20) AE_question
#(13) white balance picker(mlv_dump menu)
#(11) MLV_COMPRESS


#(16) Alter whitelevel (16383)
    if ls /tmp/DUALISO/WL_MLV_A
    then
    while grep 'MLV\|mlv' /tmp/DUALISO/WL_MLV_A
    do
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/WL_MLV_A | head -1)" | grep 'white_level' | awk 'FNR == 1 {print $2}')" = 15000 ] 
    then
    echo "0000068: FF 3F" | xxd -r - "$(cat /tmp/DUALISO/WL_MLV_A | head -1)"
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_A)" > /tmp/DUALISO/WL_MLV_A 
    else
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_A)" > /tmp/DUALISO/WL_MLV_A 
    fi
    done

    ls -A1 "$(cat /tmp/DUALISO/"path_1")"/*.MLV *.mlv > /tmp/DUALISO/WL_MLV_A
    while grep 'MLV\|mlv' /tmp/DUALISO/WL_MLV_A
    do
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/WL_MLV_A | head -1)" | grep 'white_level' | awk 'FNR == 1 {print $2}')" = 15000 ] 
    then
    echo "0000068: FF 3F" | xxd -r - "$(cat /tmp/DUALISO/WL_MLV_A | head -1)"
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_A)" > /tmp/DUALISO/WL_MLV_A 
    else
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_A)" > /tmp/DUALISO/WL_MLV_A 
    fi
    done
    rm /tmp/DUALISO/WL_MLV_A
    fi


#(17) Alter whitelevel (15000)
    if ls /tmp/DUALISO/WL_MLV_B
    then
    while grep 'MLV\|mlv' /tmp/DUALISO/WL_MLV_B
    do
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/WL_MLV_B | head -1)" | grep 'white_level' | awk 'FNR == 1 {print $2}')" = 16383 ] 
    then
    echo "0000068: 98 3A" | xxd -r - "$(cat /tmp/DUALISO/WL_MLV_B | head -1)" 
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_B)" > /tmp/DUALISO/WL_MLV_B 
    else
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_B)" > /tmp/DUALISO/WL_MLV_B 
    fi
    done

    ls -A1 "$(cat /tmp/DUALISO/"path_1")"/*.MLV *.mlv > /tmp/DUALISO/WL_MLV_B
    while grep 'MLV\|mlv' /tmp/DUALISO/WL_MLV_B
    do
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/WL_MLV_B | head -1)" | grep 'white_level' | awk 'FNR == 1 {print $2}')" = 16383 ] 
    then
    echo "0000068: 98 3A" | xxd -r - "$(cat /tmp/DUALISO/WL_MLV_B | head -1)"
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_B)" > /tmp/DUALISO/WL_MLV_B  
    else
    echo "$(tail -n +2 /tmp/DUALISO/WL_MLV_B)" > /tmp/DUALISO/WL_MLV_B 
    fi
    done
    rm /tmp/DUALISO/WL_MLV_B
    fi


#(19) auto white balance
    if ls /tmp/DUALISO/AUTOB
    then
    while grep 'C0000' /tmp/DUALISO/AUTOB
    do
    cd "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount/"$(cat /tmp/DUALISO/AUTOB | head -1)"
    . "$(cat /tmp/DUALISO/"path_2")"awb_mlvfs.command
    echo "$(tail -n +2 /tmp/DUALISO/AUTOB)" > /tmp/DUALISO/AUTOB
    cd ..
    done
    rm /tmp/DUALISO/AUTOB
    say auto white balance applied
    fi

#(20) Camera model name correction
    if ls /tmp/DUALISO/CAMMODEL
    then
    while grep 'C0000' /tmp/DUALISO/CAMMODEL
    do
    cd "$(cat /tmp/DUALISO/"path_1")"/A_ORIGINALS/"$root"_mount/"$(cat /tmp/DUALISO/CAMMODEL | head -1)"
    if grep 'SL1\|X7' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 100D"
    elif grep 'T5i\|X7i' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 700D"
    elif grep 'T3i\|X5' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 600D" 
    elif grep 'F\|XS' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 1000D"
    elif grep 'T2i\|X4' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 550D" 
    elif grep 'T3\|X50' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 1100D"
    elif grep 'T4i\|X6i' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 650D"
    elif grep 'T1i\|X3' <<< $(exiftool *000000.dng | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9; }')
    then
    find . -iname '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.UniqueCameraModel Ascii Canon EOS 500D"
    fi
    echo "$(tail -n +2 /tmp/DUALISO/CAMMODEL)" > /tmp/DUALISO/CAMMODEL
    cd ..
    done
    rm /tmp/DUALISO/CAMMODEL
    say camera model tags corrected
    fi


#(20) AE_question
    if ls /tmp/DUALISO/AE_question
    then
    #Will move terminal window to the left corner
    #printf '\e[3;0;0t'
    printf '\e[8;45;110t'
    printf '\e[3;20;40t'
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

rsln="$(exiftool "$(cat /tmp/DUALISO/"path_1")/$(cat /tmp/DUALISO/"FFmpeg" | head -1)"/*_000000.dng | awk '/Image Size/ { print $4; }')"
frme="$(exiftool "$(cat /tmp/DUALISO/"path_1")/$(cat /tmp/DUALISO/"FFmpeg" | head -1)"/*_000000.dng | awk '/Frame Rate/ { print $4; }')"
cmnm="$(exiftool "$(cat /tmp/DUALISO/"path_1")/$(cat /tmp/DUALISO/"FFmpeg" | head -1)"/*_000000.dng | awk '/Unique Camera Model/ { print $5,$6,$7,$8;}')"

    clear
    echo $(tput bold)"

Project file info:"
echo $(tput sgr0)Resolution: $(tput bold)$rsln
echo $(tput sgr0)Frame rate: $(tput bold)$frme
echo $(tput sgr0)Camera name:$(tput bold)$cmnm

echo $(tput bold)"
AE template instructions"$(tput sgr0)
echo "
Please change batch aep project settings from this very template(AE_ProRes_template.aep) and hit save in AE
when ready."
echo "
1 - Change framerate and aspect ratio inside composition settings"
echo "
2 - Choose ProRes render settings. Default is ProRes4444. Do NOT hit render"
echo "
3 - When done save your aep project settings template to your ProRes4444 folder and close AE. The template 
    can be reused or altered when required. Rerun cr2hdr.app"
echo "
4 - Change acr settings by applying changes to the first file in every dng sequence. This step
    is done OUTSIDE after effects"
echo "
5 - Run cr2hdr.app"
echo $(tput bold)$(tput setaf 1)"

Important$(tput sgr0)"
echo "You create the batch project settings from only ONE composition and One render output 
setting(Default is ProRes4444). Any acr modifications are done directly to the dng file 
itself and it,s recommended that you open your dng files from outside of AE. 
You can modify all dng folders individually. Store changes to the first file in every sequence."
echo $(tput bold)"
Good to know$(tput sgr0)"
echo "By including a xmp(acr settings file) file in your ProRes4444 folder together with your
aep template all sequences processed will include the xmp settings saved from acr"

echo "

$(tput bold)$(tput setaf 1)${bold}$(tput setaf 1)Hit any key to return to main menu$(tput sgr0)"
    read -n1
    case "$REPLY" in
    * )  
rm /tmp/DUALISO/AE_question
. "$(cat /tmp/DUALISO/path_2)"Menu.command 
    esac
fi



#(13) white balance picker
    if ls /tmp/DUALISO/WB_PICK_MLV
    then
    rm /tmp/DUALISO/WB_PICK_MLV
#enter parent folder
    cd "$(cat /tmp/DUALISO/path_1)"
    OLDIFS=$IFS
#list all MLV files
    ls *.MLV > /tmp/DUALISO/WB_MLV_list
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
#check for existing coordinates
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext ]
    then
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB 2>/dev/null
    ext=WB
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    fi
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    fi
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
    else
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    fi
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif & 
    fi
#file counter
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"

    #Will move terminal window to the right corner
    printf '\e[8;18;40t'
    printf '\e[3;10;10t'

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

sleep 2 && open -a Terminal &
sleep 4 && open -a Terminal &

while : 
do 
    clear
cat<<EOF
       --------------------
       $(tput setaf 0)$(tput bold)White balance picker$(tput sgr0)
       --------------------

   $(tput bold)$black$count

       $(tput bold)$(tput setaf 1)(a) dcraw auto wb$(tput sgr0)
       $(tput bold)$(tput setaf 1)(c) camera wb$(tput sgr0)
       $(tput bold)$(tput setaf 1)(s) preview selection point wb$(tput sgr0)
       $(tput bold)$(tput setaf 1)(l) copy last wb setting$(tput sgr0)
       $(tput bold)$(tput setaf 1)(n) next MLV file$(tput sgr0)
       $(tput bold)$(tput setaf 1)(R) restart$(tput sgr0)
       $(tput bold)$(tput setaf 1)(E) erase selected wb points$(tput sgr0)
       $(tput bold)$(tput setaf 1)(M) move MLV to trash$(tput sgr0)
       $(tput bold)$(tput setaf 1)(q) main menu$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "a") 
    osascript -e 'quit app "Imagej"' &
    rm /tmp/DUALISO/*.tif
    dcraw +M -a -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif &
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;


    "c") 
    osascript -e 'quit app "Imagej"' &
    rm /tmp/DUALISO/*.tif
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif &
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;


    "s") 
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
    if ! ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    clear
    echo "No white balance points, 
please create them before selecting (s)!"
    sleep 2
    else
    osascript -e 'quit app "Imagej"' 
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB
    ext=WB
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    fi
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
    fi
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;

    "l")
#rename if needed
    for old in M*.txt; do mv $old `basename $old .txt`.WB; done 2>/dev/null 
    ext=WB
    ls *.MLV > /tmp/DUALISO/WB_MLV_list_tmp
    grep -B1 "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)" /tmp/DUALISO/WB_MLV_list_tmp | awk 'FNR == 1' > /tmp/DUALISO/WB_MLV_list2_tmp
    rm /tmp/DUALISO/WB_MLV_list_tmp 2>/dev/null
    if ! ls "$(cat /tmp/DUALISO/WB_MLV_list2_tmp | head -1 | cut -d "." -f1)".$ext
    then
    clear
    echo "No white balance points, 
please create them before selecting (s)!"
    sleep 2
    else
    osascript -e 'quit app "Imagej"' 
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif 2>/dev/null
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext    
    fi
    cp "$(cat /tmp/DUALISO/WB_MLV_list2_tmp | head -1 | cut -d "." -f1)".$ext "$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1)".$ext
    rm /tmp/DUALISO/WB_MLV_list2_tmp 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;

    "n") 
#rename if needed
    for old in M*.txt; do mv $old `basename $old .txt`.WB; done 2>/dev/null
    echo "$(tail -n +2 /tmp/DUALISO/WB_MLV_list)" > /tmp/DUALISO/WB_MLV_list
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1)"
    then
    osascript -e 'quit app "Imagej"' 
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif 2>/dev/null
    fi
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext ]
    then
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB
    ext=WB
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav 2>/dev/null
    IFS=$OLDIFS 
    fi
    osascript -e 'quit app "Imagej"' 
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif 2>/dev/null
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    fi
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
    else
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1)"
    then
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"
    OLDIFS=$IFS
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    fi
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm /tmp/DUALISO/*.wav 2>/dev/null
    IFS=$OLDIFS 
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif & 
    else
    count=
    clear
    echo No more files to work with! 
    sleep 1
    fi
    fi
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;

    "R") 
    osascript -e 'quit app "Imagej"'
    rm /tmp/DUALISO/*.tif 2>/dev/null
#enter parent folder
    cd "$(cat /tmp/DUALISO/path_1)"
    OLDIFS=$IFS
#list all MLV files
    ls *.MLV > /tmp/DUALISO/WB_MLV_list
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
#check for existing coordinates
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext ]
    then
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB 2>/dev/null
    ext=WB
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    fi
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    fi
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
    else
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    fi
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif & 
    fi
#file counter
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"
    ;;

    "E") 
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
    if ! [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext ]
    then
    clear
    echo "No wb points to erase!"
    sleep 1.5
    else
    osascript -e 'quit app "Imagej"' &
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB 2>/dev/null
    ext=WB
    rm /tmp/DUALISO/*.tif
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif &
    fi
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;


    "M") 
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
    osascript -e 'quit app "Imagej"' 
    mkdir -p A_TRASH
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" A_TRASH
    rm "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    echo "$(tail -n +2 /tmp/DUALISO/WB_MLV_list)" > /tmp/DUALISO/WB_MLV_list
#check extension
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB ]
    then
    ext=WB
    else
    ext=txt
    fi
#check for existing coordinates
    if [ -f "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext ]
    then
#rename to WB
    mv "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".txt "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".WB 2>/dev/null
    ext=WB
    if ! [ -f /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng ]
    then
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    fi
    rm /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    then
    echo "
    whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".$ext
    fi
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"
    . "$(cat /tmp/DUALISO/path_2)"awb2.command
    fi
    else
    if ls "$(cat /tmp/DUALISO/WB_MLV_list | head -1)"
    then
    count="$(cat /tmp/DUALISO/"WB_MLV_list"|wc -l) MLV to go"
    OLDIFS=$IFS
    mlv_dump --no-fixcp --no-stripes --dng -f 1-1 -o /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_ "$(cat /tmp/DUALISO/WB_MLV_list | head -1)" & sleep 1
    killall mlv_dump
    mv /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)"_000001.dng /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng
    dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif
    rm rm /tmp/DUALISO/*.wav
    IFS=$OLDIFS 
    open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | head -1 | cut -d "." -f1)".tif & 
    else
    count=
    clear
    echo No more files to work with! 
    sleep 1
    fi
    fi
sleep 2 && open -a Terminal &
sleep 3 && open -a Terminal &
    ;;


    "q") 
#rename if needed
    for old in M*.txt; do mv $old `basename $old .txt`.WB; done 2>/dev/null
    ext=WB
    osascript -e 'quit app "Imagej"' &
    rm /tmp/DUALISO/*.tif
    rm /tmp/DUALISO/*.dng
    rm /tmp/DUALISO/WB_MLV_list
    ls M*.$ext > /tmp/DUALISO/WB_MLV_txt 
    while ! [ "x$(cat /tmp/DUALISO/WB_MLV_txt | head -1 | cut -d "." -f1)" = x ]
    do
    if ! grep 'whitebalance' "$(cat /tmp/DUALISO/WB_MLV_txt | head -1 | cut -d "." -f1)".$ext
    then
    echo "
whitebalance" >> "$(cat /tmp/DUALISO/WB_MLV_txt | head -1 | cut -d "." -f1)".$ext 
    perl -pi -e 's/.0000//g' "$(cat /tmp/DUALISO/WB_MLV_txt | head -1 | cut -d "." -f1)".$ext    
    fi
    echo "$(tail -n +2 /tmp/DUALISO/WB_MLV_txt)" > /tmp/DUALISO/WB_MLV_txt 
    done
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    ;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
    fi




#(11) MLV_COMPRESS
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi

    rm /tmp/DUALISO/MLV_cprs_del
    if [ -f /tmp/DUALISO/MLV_cprs ]
    then
#enter parent folder
    cd "$(cat /tmp/DUALISO/path_1)"
    OLDIFS=$IFS
#list all MLV files
    ls *.MLV > /tmp/DUALISO/MLV_cprs
#file counter
    count="$(cat /tmp/DUALISO/"MLV_cprs"|wc -l) MLV to go"

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

if ls /tmp/DUALISO/MLV_dcmrs
then
dcmrs=$(echo "$bold""$green"added!"$normal")
else
dcmrs=
fi


while : 
do 
    if [ -f /tmp/DUALISO/MLV_cprs_output ]
    then
    printf '\e[8;18;60t'
    printf '\e[3;450;75t'
    clear
cat<<EOF
       		 -------------------
       		 $(tput setaf 0)$(tput bold)MLV compressor(lj92)$(tput sgr0) A.Baldwin
       		 -------------------

   	     $(tput bold)$black$count

Output:$(tput setaf 4)$(cat /tmp/DUALISO/"MLV_cprs_output")$(tput setaf 0)
$(tput sgr0)reselect$(tput bold)$(tput setaf 1)(O)$(tput sgr0)to erase path

$(tput bold)$(tput setaf 1)(O) select output folder$(tput sgr0)(leave it for same folder)
$(tput bold)$(tput setaf 1)(r) run compressor(lj92)$(tput sgr0)(keep orig MLV files. Recommended)
$(tput bold)$(tput setaf 1)(L) run compressor(lj92)$(tput setaf 0)$(tput sgr0)(delete orig MLV when done!) 
$(tput bold)$(tput setaf 1)(d) decompress MLV(lj92)$(tput setaf 0)$(tput sgr0)(compress is default) $dcmrs

$(tput bold)$(tput setaf 1)(q) cancel MLV compressing$(tput sgr0)$(tput setaf 0)(Main menu)
EOF
    else
    clear
cat<<EOF
       		 -------------------
       		 $(tput setaf 0)$(tput bold)MLV compressor(lj92)$(tput sgr0) A.Baldwin
       		 -------------------

   	     $(tput bold)$black$count

$(tput bold)$(tput setaf 1)(O) select output folder$(tput sgr0)(leave it for same folder)
$(tput bold)$(tput setaf 1)(r) run compressor(lj92)$(tput sgr0)(keep orig MLV files.Recommended)
$(tput bold)$(tput setaf 1)(L) run compressor(lj92)$(tput setaf 0)$(tput sgr0)(delete orig MLV when done!) 
$(tput bold)$(tput setaf 1)(d) decompress MLV(lj92)$(tput setaf 0)$(tput sgr0)(compress is default) $dcmrs

$(tput bold)$(tput setaf 1)(q) cancel MLV compressing$(tput sgr0)$(tput setaf 0)(Main menu)
EOF
    fi
    read -n1
    case "$REPLY" in

    "O") 
    if ! [ -f /tmp/DUALISO/MLV_cprs_output ]
    then
    echo > /tmp/DUALISO/MLV_cprs_out
    open "$(cat /tmp/DUALISO/path_2)"new_output.app
    printf '\e[8;10;50t'
    printf '\e[3;410;0t'
    clear
    echo "


    ${bold}$(tput setaf 2)Select compressed MLV output$(tput sgr0)"
    sleep 1

    #trap
    while ls /tmp/DUALISO/MLV_cprs_out &>/dev/null
    do
    sleep 0.3
    done
    clear
    echo "


    ${bold}$(tput setaf 2)added Path:$(tput setaf 4)"$(cat /tmp/DUALISO/MLV_cprs_output)"$(tput sgr0)"
    path=$(echo "$bold""$green"added!"$normal")
    sleep 2  
    clear &
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command
    else
    rm /tmp/DUALISO/MLV_cprs_output
    clear &
    path=
    echo "


    ${bold}$(tput setaf 1)path removed$(tput setaf 4)$(tput sgr0)"
    sleep 1
    clear &
    . "$(cat /tmp/DUALISO/path_2)"Menu_dish.command
    fi
    ;;


    "r") 
    rm /tmp/DUALISO/MLV_cprs_del
#list all MLV files
    ls *.MLV > /tmp/DUALISO/MLV_cprs
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/MLV_cprs ) / 4 + 1 )) /tmp/DUALISO/MLV_cprs /tmp/DUALISO/MLV_cprs
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_01.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_02.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_03.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_04.command & sleep 0.5 2>/dev/null

printf '\e[8;8;20t'
printf '\e[3;955;0t'
rm /tmp/DUALISO/MLVprogress_bar_key
#MLV PROCESSING
if grep -q 'MLV\|mlv' /tmp/DUALISO/MLV_cprs
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
while sleep 2; 
do
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF

if ! grep -q 'MLV\|mlv' /tmp/DUALISO/MLV_cprs
then
while [ "$(pgrep $mlv_dump </dev/null)" ];
do
sleep 1
done
open "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
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
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
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

    ;;

    "L") 
#list all MLV files
    ls *.MLV > /tmp/DUALISO/MLV_cprs
printf '\e[8;16;63t'
printf '\e[3;410;100t'
clear
read -p $(tput bold)"Are you sure about deleting originals?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Nn]$ ]]
then
. "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
fi
echo > /tmp/DUALISO/MLV_cprs_del
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/MLV_cprs ) / 4 + 1 )) /tmp/DUALISO/MLV_cprs /tmp/DUALISO/MLV_cprs
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_01.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_02.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_03.command & sleep 0.5 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"MLV_cprs_04.command & sleep 0.5 2>/dev/null

printf '\e[8;8;20t'
printf '\e[3;955;0t'
rm /tmp/DUALISO/MLVprogress_bar_key
#MLV PROCESSING
if grep -q 'MLV\|mlv' /tmp/DUALISO/MLV_cprs
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF

if ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF
else

if ! ls 2>/dev/null /tmp/DUALISO/MLVprogress_bar_key
then
while sleep 2; 
do
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF

if ! grep -q 'MLV\|mlv' /tmp/DUALISO/MLV_cprs
then
while [ "$(pgrep $mlv_dump </dev/null)" ];
do
sleep 1
done
open "$(cat /tmp/DUALISO/path_2)"Menu_dish.command 
rm /tmp/DUALISO/MLV_cprs_del
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
    clear
cat<<EOF
    -----------
    $(tput setaf 0)$(tput bold)MLV counter$(tput sgr0)
    -----------

  $(tput bold)$black$(cat /tmp/DUALISO/"MLV_cprs"|wc -l)

 $(tput bold)$(tput setaf 1)(q) Quit counting$(tput sgr0)
EOF
    read -n1
    case "$REPLY" in

    "q") 
echo > /tmp/DUALISO/NOCOUNT
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
    ;;

    "d")
    if ls /tmp/DUALISO/MLV_dcmrs
    then
    rm /tmp/DUALISO/MLV_dcmrs
    dcmrs=
    else
    echo > /tmp/DUALISO/MLV_dcmrs
    dcmrs=$(echo "$bold""$green"added!"$normal")
    fi
;;


    "q") 
    rm /tmp/DUALISO/MLV_dcmrs
    rm /tmp/DUALISO/MLV_cprs_del
    rm /tmp/DUALISO/MLV_cprs 2>/dev/null
    . "$(cat /tmp/DUALISO/path_2)"Menu.command
    ;;


    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac 
done 
    fi



#Copyright Danne