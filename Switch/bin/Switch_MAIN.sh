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

#Processing order(if files included in root folder)
#Export to ProRes4444 and/or ProRes proxy(MOV, mts etc, includes HDR mov) 
#Manually selected FLATFRAMES processing
#Fully automated flatframe processing
#Automated darkframe processing
#extra round to check if darkframe or flatframe still are present in root folder
#Create darkframe MLV files from storage folder
#Processing of MLV files
#cr2hdr processing(MLV files)
#Processing of RAW files
#cr2hdr processing(RAW files)
#Export to ProRes4444 and/or ProRes proxy
#run cr2hdr 4 processes in parallel(CR2,DNG,dng files)


#!/bin/bash
#Dependency YAD(yet another dialogue, fork of zenithy)
if ! [ -f /usr/bin/yad ]
then
clear
printf '\e[8;10;95t'
printf '\e[3;410;100t'
read -p $(tput bold)"Switch absolutely needs YAD installed. 
Will you let Switch do it for you?$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
#installs YAD
sudo add-apt-repository ppa:webupd8team/y-ppa-manager
sudo apt-get update
sudo apt-get install yad
else
clear
echo "Switch will not work without YAD, sorry"
sleep 2
echo > ~/Switch/config/tmp/MENU_exit 1> /dev/null 2>&1 &
exit 0
fi
fi
#remove tmp folder
    rm -r ~/Switch/config/tmp 1> /dev/null 2>&1 &
#build folder structure
    mkdir -p ~/Switch/config
    mkdir -p ~/Switch/config/tmp
#select folder path
    printf '\e[8;2;30t'
    printf '\e[3;150;0t'
    echo Select your input folder
    cd $(yad --center --file-selection --directory --title "Switch") 
#print path to working directory
    echo $PWD > ~/Switch/config/tmp/path_1
#print bin path
    echo ~/Switch/bin/ > ~/Switch/config/tmp/path_2
#log file
    rm "$(cat ~/Switch/config/tmp/path_1)"/LOG.txt
    exec &> >(tee -a "$(cat ~/Switch/config/tmp/path_1)"/LOG.txt >&2 )
#Storage folder
    mkdir -p A_ORIGINALS
#export path
    export PATH=$PATH:~/Switch/bin
#check if filmed crop_rec eosm 
    if grep 'M' <<< $(mlv_dump -v -m "$(ls -A1 *.MLV *.mlv | head -1)" | awk '/Camera Name/ { print $5;}')
    then 
    echo > ~/Switch/config/tmp/crop_rec? 
    fi
#check if filmed crop_rec 700D
    if grep '700D\|T5i\|X7i' <<< $(mlv_dump -v -m "$(ls -A1 *.MLV *.mlv | head -1)" | awk '/Camera Name/ { print $4,$5,$6,$7;}')
    then 
    echo > ~/Switch/config/tmp/crop_rec? 
    fi
#Call menu selector
    echo > ~/Switch/config/tmp/MENU
    ~/Switch/bin/Menu.sh
    sleep 0.3
#exit
    if [ -f ~/Switch/config/tmp/MENU_exit ]
    then 
    exit 0
    fi
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
###############################################################
#Manually selected FLATFRAMES processing
    if [ -f ~/Switch/config/tmp/FLATFRAMES ]
    then
    mkdir -p ~/Switch/config/tmp/
    mkdir -p A_ORIGINALS
#Start investigating if selected both flatdark and FLATFRAMES
    if ! [ x"$(cat ~/Switch/config/tmp/FLATFRAMES | awk 'FNR == 2 {print $1}')" = x ]
    then
    OLDIFS=$IFS
    IFS=$'\n'
    for FILE in `echo "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_flat=$!
#wait for jobs to finish   
    sleep 2
#kill $mlv_dump
    kill $pid_flat
    rm *_.wav
    ls *_000001.dng > ~/Switch/config/tmp/FLAT
    done 
    IFS=$OLDIFS 
#Inspect exposure of rgb pixel. If totally dark below 1 should do otherwise some sort of light is passing through to the sensor
    dcraw -d -W -c "$(cat ~/Switch/config/tmp/FLAT | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -pix_fmt yuvj444p "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".jpeg
#use imagemagick to read pixel brightness
    convert $(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1).jpeg -colorspace hsb -resize 1x1 $(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1).txt
    numb=$(echo $(grep '%' $(cat ~/Switch/config/tmp/FLAT| head -1 | cut -d "." -f1).txt | cut -d "%" -f3 | tr -d ',')) 
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)" | awk '/Res/ { print $2; exit }')
    if (( $(echo "$numb < 1.3" |bc -l) )); then
#remove unwanted files
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".txt
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".jpeg
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1)"
#create the flat-dark, head -1 is the darkflat, head -2 is the FLATFRAMES
    $mlv_dump -s "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)" -o F_lat_D_ark.MLV "$(cat ~/Switch/config/tmp/FLATFRAMES | tail -1)"
    $mlv_dump F_lat_D_ark.MLV -a -o ft_"$fres"_"$(cat ~/Switch/config/tmp/FLATFRAMES | head -1 | grep -o '[^/]*$')"
    rm F_lat_D_ark.MLV
    rm F_lat_D*.wav
    rm ft*.wav
#move original files
    mv -i "$(cat ~/Switch/config/tmp/FLATFRAMES | tail -1)" A_ORIGINALS
    mv -i "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)" A_ORIGINALS
    else
#remove unwanted files
    rm "$(cat ~/Switch/config/tmp/FLAT| head -1 | cut -d "." -f1)".txt
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".jpeg
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1)"
    $mlv_dump -s "$(cat ~/Switch/config/tmp/FLATFRAMES | tail -1)" -o F_lat_D_ark.MLV "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)"
    $mlv_dump F_lat_D_ark.MLV -a -o ft_"$fres"_"$(cat ~/Switch/config/tmp/FLATFRAMES | tail -1 | grep -o '[^/]*$')"
    rm F_lat_D_ark.MLV
    rm F_lat_D*.wav
    rm ft*.wav
#move original files
    mv -i "$(cat ~/Switch/config/tmp/FLATFRAMES | tail -1)" A_ORIGINALS
    mv -i "$(cat ~/Switch/config/tmp/FLATFRAMES | head -1)" A_ORIGINALS
    fi 
    fi
    fi
#If only selected flatframe without darkflat
    if [ x"$(cat ~/Switch/config/tmp/FLATFRAMES | awk 'FNR == 2 {print $1}')" = x ]
    then
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/FLATFRAMES)" | awk '/Res/ { print $2; exit }')
    OLDIFS=$IFS
    IFS=$'\n'
    $mlv_dump "$(cat ~/Switch/config/tmp/FLATFRAMES)" -a -o ft_"$fres"_"$(cat ~/Switch/config/tmp/FLATFRAMES | grep -o '[^/]*$')"
    IFS=$OLDIFS 
#move original file
    mv -i "$(cat ~/Switch/config/tmp/FLATFRAMES)" A_ORIGINALS
    rm ft*.wav
    fi
###############################################################
#Fully automated flatframe processing(if not manual flatframe processing selected)
#Will take white space
    if [ -f ~/Switch/config/tmp/FLATFRAME_A ]
    then
    mkdir -p ~/Switch/config/tmp/
    mkdir -p A_ORIGINALS
#Creation of flatframes. Check for amount of frames, size of file
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    if (( $(echo "$($mlv_dump -v -m "$FILE" | awk '/Processed/ { print $2;}') < 400" |bc -l) )) && (( $(echo "$(wc -c < "$FILE") < 1000000000" |bc -l) ))
    then 
    echo "$FILE" >> ~/Switch/config/tmp/FLAT
    fi
    done
#List files according to search criteria above
    for FILE in `echo "$(cat ~/Switch/config/tmp/FLAT)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_flat=$!
#wait for jobs to finish   
    sleep 3
#kill $mlv_dump
    kill $pid_flat
    rm *_.wav
    ls *_000001.dng > ~/Switch/config/tmp/FLAT
    done 
    IFS=$OLDIFS  
#Inspect exposure of rgb pixel. If too dark below 75 it,s not conisdered a flatframe
    while grep -q 'dng' ~/Switch/config/tmp/FLAT
    do 
    dcraw -d -W -c "$(cat ~/Switch/config/tmp/FLAT | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -pix_fmt yuvj444p "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".jpeg
#use imagemagick to read pixel brightness
    convert $(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1).jpeg -colorspace hsb -resize 1x1 $(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1).txt
    numb=$(echo $(grep '%' $(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1).txt | cut -d "%" -f3 | tr -d ',')) 
    if (( $(echo "$numb < 45" |bc -l) )); then
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".txt
    else
#Send flatframe MLV to a list which met the last criteria of exposure above 45
    echo "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "_" -f1)".MLV >> My_flatfr
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".txt
    fi
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1)"
    rm "$(cat ~/Switch/config/tmp/FLAT | head -1 | cut -d "." -f1)".jpeg
    echo "$(tail -n +2 ~/Switch/config/tmp/FLAT)" > ~/Switch/config/tmp/FLAT
    done
    rm ~/Switch/config/tmp/FLAT
#Create the actual flatframes
    while grep 'MLV' My_flatfr
    do
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -m -v "$(cat My_flatfr | head -1)" | awk '/Res/ { print $2; exit }')
    OLDIFS=$IFS
    IFS=$'\n'
    $mlv_dump "$(cat My_flatfr | head -1)" -a -o ft_"$fres"_"$(cat My_flatfr | head -1 | grep -o '[^/]*$')"
    IFS=$OLDIFS 
    rm *_.wav
#move original file
    mv -i "$(cat My_flatfr | head -1)" A_ORIGINALS
    echo "$(tail -n +2 My_darkfr)" > My_flatfr
    done
    rm My_flatfr
    fi
###############################################################
#Automated darkframe processing
#Will take white space
    if [ -f ~/Switch/config/DARK ]
    then
    mkdir -p ~/Switch/config/tmp/
    mkdir -p A_ORIGINALS
#Creation of darkframes. Check for amount of frames, size of file
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    if (( $(echo "$($mlv_dump -v -m "$FILE" | awk '/Processed/ { print $2;}') < 400" |bc -l) )) && (( $(echo "$(wc -c < "$FILE") < 1000000000" |bc -l) ))
    then 
    echo "$FILE" >> ~/Switch/config/tmp/darkf.txt
    fi
    done
#List files according to search criteria above
    for FILE in `echo "$(cat ~/Switch/config/tmp/darkf.txt)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_dark=$!
#wait for jobs to finish   
    sleep 3
#kill $mlv_dump
    kill $pid_dark
    rm *_.wav
    ls *_000001.dng > ~/Switch/config/tmp/darkf.txt
    done 
    IFS=$OLDIFS  
#Inspect exposure of rgb pixel. If totally dark below 1 should do otherwise some sort of light is passing through to the sensor
    while grep -q 'dng' ~/Switch/config/tmp/darkf.txt
    do 
    dcraw -d -W -c "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -pix_fmt yuvj444p "$(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1)".jpeg
#use imagemagick to read pixel brightness
    convert $(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1).jpeg -colorspace hsb -resize 1x1 $(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1).txt
    numb=$(echo $(grep '%' $(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1).txt | cut -d "%" -f3 | tr -d ',')) 
    if (( $(echo "$numb > 1.3" |bc -l) )); then
    rm "$(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1)".txt
    else
#Send darkframe MLV to a list which met the last criteria of exposure below 1.3
    echo "$(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "_" -f1)".MLV >> My_darkfr
    rm "$(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1)".txt
    fi
    rm "$(cat ~/Switch/config/tmp/darkf.txt | head -1)"
    rm "$(cat ~/Switch/config/tmp/darkf.txt | head -1 | cut -d "." -f1)".jpeg
    echo "$(tail -n +2 ~/Switch/config/tmp/darkf.txt)" > ~/Switch/config/tmp/darkf.txt
    done
    rm ~/Switch/config/tmp/darkf.txt
#Create the actual darkframes
    while grep 'MLV' My_darkfr
    do
    $mlv_dump -o avg_"$(cat My_darkfr | head -1)" -a "$(cat My_darkfr | head -1)"
    rm *MLV.wav
    rm avg.wav
    bit=$($mlv_dump -m -v "$(cat My_darkfr | head -1)" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -m -v "$(cat My_darkfr | head -1)" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -m -v "$(cat My_darkfr | head -1)" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -m -v "$(cat My_darkfr | head -1)" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -m -v "$(cat My_darkfr | head -1)" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    mv avg_"$(cat My_darkfr | head -1)" avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    mkdir -p A_ORIGINALS/darkframe_originals
    mv "$(cat My_darkfr | head -1)" A_ORIGINALS/darkframe_originals
    echo "$(tail -n +2 My_darkfr)" > My_darkfr
    done
    rm My_darkfr
#stop if selected only_DARK
    if [ -f ~/Switch/config/only_DARK ]
    then 
    exit 0
    fi
#when going for dng files only
    if ! [ -f ~/Switch/config/only_DNG ]
    then
#Create darkframe MLV files
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    bit=$($mlv_dump -m -v "$FILE" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -m -v "$FILE" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -m -v "$FILE" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -m -v "$FILE" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -m -v "$FILE" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    if [ -f avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
#Check for flatframe
    if ! ls ft_*.MLV
    then
#list mlv files and send them for processing
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > ~/Switch/config/tmp/DF_storage
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/DF_storage ) / 4 + 1 )) ~/Switch/config/tmp/DF_storage ~/Switch/config/tmp/DF_storage
    rm ~/Switch/config/tmp/DF_storage
#create a new folder path file
    cat ~/Switch/config/tmp/path_1 > ~/Switch/config/DARK_FOLDER
    DF_storage_01.sh & 
    DF_storage_02.sh & 
    DF_storage_03.sh & 
    DF_storage_04.sh & 
#trap
    while [ `ls -1 ~/Switch/config/tmp/DF_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    rm ~/Switch/config/DARK_FOLDER
    else
#Do frame size match?
    if [ "$res" = "$fres" ]
    then
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV -t ft_*.MLV "$FILE"
    rm *MLV.wav
    rm a_*.wav
    else
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV "$FILE"
    rm *MLV.wav
    rm a_*.wav
    fi
    fi
    mv -i "$FILE" A_ORIGINALS
    mv -i  "$(echo "$FILE" | cut -d "." -f1)".M* A_ORIGINALS
#if no darkframes suitable check for flatframes
    else
    if [ -f ft_*.MLV ]
    then
#Do frame size match?
    if [ "$res" = "$fres" ]
    then
    $mlv_dump -o a_"$FILE" -t ft_*.MLV "$FILE"
    rm *MLV.wav
    rm a_*.wav
    fi
    mv -i "$FILE" A_ORIGINALS
    mv -i  "$(echo "$FILE" | cut -d "." -f1)".M*  A_ORIGINALS
    fi
    fi
    done
    mv -i avg_*.MLV A_ORIGINALS
    mv -i ft_*.MLV A_ORIGINALS
    IFS=$OLDIFS
    fi
#if skipping dng processing
    if [ -f ~/Switch/config/NO_DNG ]
    then
    rm -f ~/Switch/config/NO_DNG
    exit 0
    fi
    fi
###############################################################
#Create darkframe MLV files from storage folder 
    if [ -f ~/Switch/config/DARK_FOLDER ]
    then
#Create the actual darkframes if needed
    OLDIFS=$IFS
    IFS=$'\n'    
    cd "$(cat ~/Switch/config/DARK_FOLDER)"
    ls *.MLV *.mlv | grep -v 'avg_' > ~/Switch/config/tmp/darkf.txt
    while grep 'MLV' ~/Switch/config/tmp/darkf.txt
    do
    mkdir -p darkfr_ORIGINALS
    $mlv_dump -o avg_"$(cat ~/Switch/config/tmp/darkf.txt | head -1)" -a "$(cat ~/Switch/config/tmp/darkf.txt | head -1)"
    rm *MLV.wav
    bit=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -m -v "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    mv avg_"$(cat ~/Switch/config/tmp/darkf.txt | head -1)" avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    mv "$(cat ~/Switch/config/tmp/darkf.txt | head -1)" darkfr_ORIGINALS
    echo "$(tail -n +2 ~/Switch/config/tmp/darkf.txt)" > ~/Switch/config/tmp/darkf.txt
    done
    rm ~/Switch/config/tmp/darkf.txt
    IFS=$OLDIFS
#Darkframe folder storage
#go back to root folder
    cd "$(cat ~/Switch/config/tmp/path_1)"
#when going for dng files only
    if ! [ -f ~/Switch/config/only_DNG ]
    then 
#list mlv files
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > ~/Switch/config/tmp/DF_storage
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/DF_storage ) / 4 + 1 )) ~/Switch/config/tmp/DF_storage ~/Switch/config/tmp/DF_storage
    rm ~/Switch/config/tmp/DF_storage
#do files exist or not
    if ! [ x"$(cat ~/Switch/config/tmp/DF_storageaa)" = x ]
    then
    DF_storage_01.sh & 
    DF_storage_02.sh & 
    DF_storage_03.sh & 
    DF_storage_04.sh & 
    fi
#trap
    while [ `ls -1 ~/Switch/config/tmp/DF_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    rm ~/Switch/config/tmp/DF_TRAP
    fi
#NO_DNG processing after creation of darkframe processing
    if [ -f ~/Switch/config/NO_DNG ]
    then
    rm ~/Switch/config/NO_DNG
    exit 0
    fi 
    fi
###############################################################
#Processing MLV files into folders with dng files
#Multithreading badpixel lists. Script from dfort   
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > ~/Switch/config/tmp/badpixelMLV
#do files exist or not
    if grep -q 'MLV\|mlv' ~/Switch/config/tmp/badpixelMLV
    then
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/badpixelMLV ) / 4 + 1 )) ~/Switch/config/tmp/badpixelMLV ~/Switch/config/tmp/badpixelMLV 
    rm ~/Switch/config/tmp/badpixelMLV
    badpixels_01.sh & 
    badpixels_02.sh & 
    badpixels_03.sh & 
    badpixels_04.sh & 
#trap
    while [ `ls -1 ~/Switch/config/tmp/BP_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    fi

#Will take white space
    OLDIFS=$IFS
    IFS=$'\n'
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > ~/Switch/config/tmp/MLVFILES
#reset IFS
    IFS=$OLDIFS
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/MLVFILES ) / 4 + 1 )) ~/Switch/config/tmp/MLVFILES ~/Switch/config/tmp/MLVFILES
    rm ~/Switch/config/tmp/MLVFILES
    mlv_dump_01.sh & pid1=$!
    mlv_dump_02.sh & pid2=$!
    mlv_dump_03.sh & pid3=$!
    mlv_dump_04.sh & pid4=$!
#wait for jobs to end
    wait < <(jobs -p)
###############################################################
#Processing RAW files
#Will take white space
    OLDIFS=$IFS
    IFS=$'\n'
    for FILE in `ls -A1 *.RAW *.raw 2>/dev/null`; do
    BASE=`echo "$FILE" | cut -d "." -f1`;
    mkdir "${BASE}";
    mv "${BASE}".RAW "${BASE}"
    mv "${BASE}".R* "${BASE}"
    mv "${BASE}" "${BASE}_1_$(date +%Y-%m-%d)_0001_C0000"
    cd "${BASE}_1_$(date +%Y-%m-%d)_0001_C0000"
#RAW processing
    raw2dng "$FILE" "${BASE}_1_$(date +%Y-%m-%d)_0001_C"
#grabs the white balance tag and saves it for later  
    wib=$(exiv2 -pt "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    mv -i "${BASE}".RAW ../A_ORIGINALS ;
    if ls "${BASE}".R*
    then
    mv -i "$BASE".R* ../A_ORIGINALS ;
    fi
#reset IFS
    IFS=$OLDIFS
#M #650D #700D #100D check for pixel script
    exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng -X > ~/Switch/config/tmp/what_cam.txt -overwrite_original
    if grep 'ColorMatrix1>0.6602' ~/Switch/config/tmp/what_cam.txt 
    then
    fs=$(exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Image Size/ { print $4; }')
    this_cam=$(cat ~/Switch/config/tmp/"this_cam")
    fs=$(cat ~/Switch/config/tmp/"image_size")
    mode=$(cat ~/Switch/config/tmp/"mode")
    fpm.sh -c "$this_cam" -m "$mode" -s "$fs" -o "$(cat ~/Switch/config/tmp/path_1)"/"${BASE}"_1_$(date +%Y-%m-%d)_0001_C0000/pix_fix.txt hej.RAW &
#check if default scale tag needs to be added or else only camera name gets added 
    find . -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 "$(cat ~/Switch/config/tmp/def_scal)" -M"set Exif.Image.UniqueCameraModel Ascii $this_cam"
    fi
#check if footage is slowmotion. will add specific default scale tag
    if ! grep 'ColorMatrix1>0.6602' ~/Switch/config/tmp/what_cam.txt
    then 
    numbc=$(exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Frame Rate/ { print $4; }' | cut -f1 -d".")
    count=$numbc
    if [ $count -gt 47 ]
    then 
    find . -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 5/3"
    fi
    fi
#Stored cr2hdr settings
    set=$(cat ~/Switch/config/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
#Verify dualiso or else continue to next file
    cr2hdr $set "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | tee ~/Switch/config/tmp/dualiso.txt 
    if ! grep 'look like interlaced ISO' ~/Switch/config/tmp/dualiso.txt
    then
    rm ~/Switch/config/tmp/dualiso.txt
#grab fps before it,s too late
    fps=$(exiv2 -pt "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Exif.Image.FrameRate/ { print $4; }')
#cr2hdr processing
    find . -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P $(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l) -n 1 cr2hdr $set
#grabs white level
    wle=$(exiv2 -pt "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.DNG | awk '/Exif.SubImage1.WhiteLevel/ { print $4; }')
#adds back white balance tag, frames per second and same whitelevel to prevent flicker
    find . -maxdepth 1 -mindepth 1 -name '*.DNG' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wib" -M"set Exif.SubImage1.WhiteLevel $wle" -M"set Exif.Image.FrameRate $fps"
    fi
    cd ..
    done
#only wait for the last pixel script to be baked
while :
do
size_01=$(wc -c "${BASE}"_1_$(date +%Y-%m-%d)_0001_C0000/pix_fix.txt | awk '{print $1}')
sleep 0.5
size_02=$(wc -c "${BASE}"_1_$(date +%Y-%m-%d)_0001_C0000/pix_fix.txt | awk '{print $1}')
    if [ "$size_01" = "$size_02" ] 
    then
        break
    fi
done
###############################################################
#Export to ProRes4444 and/or ProRes proxy 
    if ! [ x"$(cat ~/Switch/config/FFmpeg_settingsPR)" = x ]
    then
    ls -d *C0000 > ~/Switch/config/tmp/FFmpeg
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/FFmpeg ) / 4 + 1 )) ~/Switch/config/tmp/FFmpeg ~/Switch/config/tmp/FFmpeg 
    rm ~/Switch/config/tmp/FFmpeg
    if ! [ x"$(cat ~/Switch/config/tmp/FFmpegaa)" = x ]
    then 
    FFmpeg_produce_01.sh & pid1=$!
    FFmpeg_produce_02.sh & pid2=$!
    FFmpeg_produce_03.sh & pid3=$!
    FFmpeg_produce_04.sh & pid4=$!
#wait for jobs to end
    wait < <(jobs -p)
    fi
    fi
#check for proxy ProRes first
    if [ x"$(cat ~/Switch/config/FFmpeg_settingsPR)" = x ]
    then
    if ! [ x"$(cat ~/Switch/config/FFmpeg_settings)" = x ]
    then
    ls -d *C0000 > ~/Switch/config/tmp/FFmpeg
#split into 4 chunks
    split -l $(( $( wc -l < ~/Switch/config/tmp/FFmpeg ) / 4 + 1 )) ~/Switch/config/tmp/FFmpeg ~/Switch/config/tmp/FFmpeg 
    rm ~/Switch/config/tmp/FFmpeg
    FFmpeg_produce_01.sh & pid1=$!
    FFmpeg_produce_02.sh & pid2=$!
    FFmpeg_produce_03.sh & pid3=$!
    FFmpeg_produce_04.sh & pid4=$!
#wait for jobs to end
    wait < <(jobs -p)
    fi
    fi
###############################################################
#dual iso processing(cr2 files)
    if grep 'CR2\|DNG\|dng' <<< "$(ls *.CR2 *.DNG *.dng)"
    then  
#Stored cr2hdr settings
    set=$(cat ~/Switch/config/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
    set=$(cat ~/Switch/config/"A_cr2hdr_cmpr.txt" | sed -e 's/^[ \t]*//')
#Count cpu´s
    cpu=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
#cpu boost
    if ls ~/Switch/config/cpuboost
    then
    cpu=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
    fi
#run cr2hdr 4 processes in parallel
    ls *.DNG *.dng > ~/Switch/config/tmp/NOT_list
    echo hej >> ~/Switch/config/tmp/NOT_list
    if grep 'DNG\|dng' <<< "$(ls *.CR2 *.DNG *.dng)"
    then
    find . -maxdepth 1 -mindepth 1 -iname '*.DNG' -print0 | xargs -0 -P $cpu -n 1 cr2hdr $set $cmpr 
    fi
    if grep 'CR2' <<< "$(ls *.CR2 *.DNG *.dng)"
    then
    find . -maxdepth 1 -mindepth 1 -name '*.CR2' -print0 | xargs -0 -P $cpu -n 1 cr2hdr $set $cmpr
    fi
#sort out the non dualiso CR2 files
    if [ x"$(ls *.DNG)" = x ] 
    then
    mkdir -p not_dualiso
    mv *.CR2 not_dualiso
    fi
    ls *.DNG  | cut -d "." -f1 > ~/Switch/config/tmp/not_dualiso
    while read line
    do
    echo "$line*"
    done < ~/Switch/config/tmp/not_dualiso > ~/Switch/config/tmp/not_dualiso1
    ls $(cat ~/Switch/config/tmp/not_dualiso1) > ~/Switch/config/tmp/not_dualiso
#if you find non dualiso files move them to folder
    if ! [ x"$(ls *.CR2 | grep -v "$(cat ~/Switch/config/tmp/not_dualiso)")" = x ] 
    then
    mkdir -p not_dualiso
    while IFS= read -r file; do mv "$file" not_dualiso; done <<< "$(ls *.CR2 | grep -v "$(cat ~/Switch/config/tmp/not_dualiso)")"
    fi   
#obtaining dcraw white balance multipliers and calculating them to AsShotNeutralvalues in the DNG file (thanks Chmee)
    ls *.CR2 > ~/Switch/config/tmp/d_iso_list
    cr2=$(ls *.CR2 | wc -l)
#if less than 4 files
    if ! [ $(ls *.CR2 | wc -l) -lt 4 ]; then 
#if working with 6 or 7 CR2 files
    if [[ "$(echo $cr2 | tr -d ' ')" == [67] ]]; then
    sed -n 1,$(($cr2/4))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*5+1)),$(($cr2/4*6))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_04
    sed -n $(($cr2/4*6+1)),$(($cr2/4*7))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
#Listing of DNG files
    ls *.DNG | grep -v "$(cat ~/Switch/config/tmp/NOT_list)" > ~/Switch/config/tmp/d_iso_list
    cr2=$(ls *.DNG | wc -l)
    sed -n 1,$(($cr2/4))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*5+1)),$(($cr2/4*6))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
    sed -n $(($cr2/4*6+1)),$(($cr2/4*7))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
#Sorting of CR2 and DNG files
    ls $(cat ~/Switch/config/tmp/list_01) > ~/Switch/config/tmp/list_01
    ls $(cat ~/Switch/config/tmp/list_02) > ~/Switch/config/tmp/list_02
    ls $(cat ~/Switch/config/tmp/list_03) > ~/Switch/config/tmp/list_03
    ls $(cat ~/Switch/config/tmp/list_04) > ~/Switch/config/tmp/list_04
    else
    sed -n 1,$(($cr2/4))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p ~/Switch/config/tmp/d_iso_list > ~/Switch/config/tmp/list_04
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
#Listing of DNG files
    ls *.DNG | grep -v "$(cat ~/Switch/config/tmp/NOT_list)" > ~/Switch/config/tmp/d_iso_list
    cr2=$(ls *.DNG | wc -l)
    sed -n 1,$(($cr2/4))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_03
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p ~/Switch/config/tmp/d_iso_list >> ~/Switch/config/tmp/list_04
#Sorting of CR2 and DNG files
    ls $(cat ~/Switch/config/tmp/list_01) > ~/Switch/config/tmp/list_01
    ls $(cat ~/Switch/config/tmp/list_02) > ~/Switch/config/tmp/list_02
    ls $(cat ~/Switch/config/tmp/list_03) > ~/Switch/config/tmp/list_03
    ls $(cat ~/Switch/config/tmp/list_04) > ~/Switch/config/tmp/list_04
    fi
#if less than 4 files
    else
    ls *.CR2 *.DNG | grep -v "$(cat ~/Switch/config/tmp/NOT_list)" > ~/Switch/config/tmp/list_01 
    fi
###############################################################
#multithread processing
    dualiso_to_DNG_A.sh & pid1=$! 
    dualiso_to_DNG_B.sh & pid2=$! 
    dualiso_to_DNG_C.sh & pid3=$! 
    while grep -q 'CR2' ~/Switch/config/tmp/list_01
    do
    CR2=$(grep 'CR2' ~/Switch/config/tmp/list_01 | awk 'FNR == 1 {print}')
    DNG=$(grep 'DNG' ~/Switch/config/tmp/list_01 | awk 'FNR == 1 {print}')
#Will add stored white balance settings to processed readymade dualiso DNG files
    echo "$(tail -n +3 ~/Switch/config/tmp/list_01)" > ~/Switch/config/tmp/list_01
#check if the camera is an eos 100D
    model_match=$(exiftool "$CR2" | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9,$10; exit }')
    echo "$model_match" > ~/Switch/config/tmp/model_match
    if grep 'Canon EOS 100D\|SL1\|Kiss X7\|X7' ~/Switch/config/tmp/model_match
    then
    exiftool "-ColorMatrix1=0.6985 -0.1611 -0.0397 -0.3596 1.0749 0.3295 -0.0349 0.1136 0.6512" "-ColorMatrix2=0.6602 -0.0841 -0.0939 -0.4472 1.2458 0.2247 -0.0975 0.2039 0.6148" "$(find "$CR2" | cut -f1 -d".")".DNG -overwrite_original ;
    fi 
    CR2_00=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $4; exit }')
    CR2_01=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $3; exit }') 
    CR2_01b=$(echo "$CR2_00"/"$CR2_01" | bc -l | awk 'FNR == 1 {print}')
    CR2_00b=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $6; exit }')
    CR2_02=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $5; exit }') 
    CR2_02b=$(echo "$CR2_00b"/"$CR2_02" | bc -l | awk 'FNR == 1 {print}')
#Add neccesssary tags for white balance with exiftool. Also rearrange illuminant tags
    exiftool "-AsShotNeutral=$CR2_01b 1 $CR2_02b" "-CalibrationIlluminant1=Standard Light A" "-CalibrationIlluminant2=D65" "$DNG" -overwrite_original
    mkdir -p A_ORIGINALS
    mv -i "$CR2" A_ORIGINALS
#wait for jobs to end
    wait < <(jobs -p)
    done
    fi

 
#Thanks to Bouncyball, A1ex(cr2hdr, raw2dng, mlv_dump) g3gg0(mlv_dump) Dave Coffin(dcraw) Fabrice Bellard(FFmpeg) Phil Harvey(Exiftool) Andreas Huggel(exiv2) BWF MetaEdit(FADGI) dfort(Focus pixel script).
#Copyright Danne
