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
#HDR_PROCESSING
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

rm "$(cat /tmp/DUALISO/path_1)"/LOG.txt
exec &> >(tee -a "$(cat /tmp/DUALISO/path_1)"/LOG.txt >&2 )

export PATH="$(cat /tmp/DUALISO/path_2)":$PATH
    cd "$(cat /tmp/DUALISO/path_1)"
    mkdir -p A_ORIGINALS
    path_2=$(cat /tmp/DUALISO/"DBG_path")
#check for new output folder
    if [ -f /tmp/output ]
    then
    mkdir -p "$(cat /tmp/output)"
    O=$(cat /tmp/"output")/
    fi
#Total time command starts here
    res1=$(date +%s)
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
###############################################################
#HDR_PROCESSING
    if [ -f /tmp/HDRCR2 ]
    then
    rm /tmp/DUALISO/CR2LIST
    rm /tmp/DUALISO/LIST
    ls *.CR2 > /tmp/DUALISO/CR2LIST
#Start HDRCR2_grouping counter
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    if grep -q 'CR2' /tmp/DUALISO/CR2LIST
    then
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command & 
    fi
    fi
    echo -n $(cat /tmp/DUALISO/CR2LIST | awk 'FNR == 1') >> /tmp/DUALISO/LIST
    while grep 'CR2' /tmp/DUALISO/CR2LIST >/dev/null 2>&1
    do
    num1=$(exiftool "$(cat /tmp/DUALISO/CR2LIST | awk 'FNR == 2')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }') 
    num2=$(exiftool "$(cat /tmp/DUALISO/CR2LIST | awk 'FNR == 1')" | awk '/Modify Date/ { print $5; exit}' | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    num=$(echo "$num1" - "$num2" | bc -l)
#group CR2 files accordingly
    if (( $(echo "$num < 10" |bc -l) ))
    then
    echo -n " $(cat /tmp/DUALISO/CR2LIST | awk 'FNR == 2')" >> /tmp/DUALISO/LIST
    echo -n "$(tail -n +2 /tmp/DUALISO/CR2LIST)" > /tmp/DUALISO/CR2LIST
    else
    echo "" >> /tmp/DUALISO/LIST
    echo -n "$(tail -n +2 /tmp/DUALISO/CR2LIST)" > /tmp/DUALISO/CR2LIST
    echo -n $(cat /tmp/DUALISO/CR2LIST | awk 'FNR == 1') >> /tmp/DUALISO/LIST
    fi
    done
#HDRCR2 settings
    if [ -f /tmp/HDRCR2_settings ]
    then
    HDR="$(cat /tmp/"HDRCR2_settings" | perl -p -e 's/^[ \t]*//')"
    fi
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/LIST ) / 4 + 1 )) /tmp/DUALISO/LIST /tmp/DUALISO/LIST
#Start HDRCR2 counter
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    if grep -q 'CR2' /tmp/DUALISO/LISTaa 
    then
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command & 
    fi
    fi
    . "$path_2"Contents/HDR2.command & pid2=$!
    . "$path_2"Contents/HDR3.command & pid3=$!
    . "$path_2"Contents/HDR4.command & pid4=$!
    while grep 'CR2' /tmp/DUALISO/LISTaa >/dev/null 2>&1
    do 
#check for alternate output
if ! [ -d "$(cat /tmp/HDRCR2output)" ]
    then
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -a $(cat /tmp/DUALISO/LISTaa | awk 'FNR == 1')
    mv $(cat /tmp/DUALISO/LISTaa | awk 'FNR == 1') A_ORIGINALS
    else
    /Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -o "$(cat /tmp/HDRCR2output)"/%iF[0]-%in[-1].dng $(cat /tmp/DUALISO/LISTaa | awk 'FNR == 1')
    fi
    echo "$(tail -n +2 /tmp/DUALISO/LISTaa)" > /tmp/DUALISO/LISTaa
    done
#wait for jobs to end
    wait < <(jobs -p)
    rm /tmp/DUALISO/LISTaa
    rm /tmp/DUALISO/LIST
    fi
###############################################################
#Export to ProRes4444 and/or ProRes proxy 
#listing files(non raw)
    if ! [ x"$(cat /tmp/_X_Proxy)" = x ]
    then
    for f in *; do [[ -f "$f" ]] && ls "$f" | grep -v 'RAW\|R00\|R01\|R02\|R03\|R04\|R05\|R06\|R07\|R08\|R09\|R10\|R11\|R12\|R13\|R14\|R15\|MLV\|M00\|M01\|M02\|M03\|M04\|M05\|M06\|M07\|M08\|M09\|\|M10\|M11\|M12\|M13\|M14\|M15\|CR2\|dng\|DNG\|txt\|TXT\|tif\|tiff\|TIF\|TIFF\|jpg\|JPG\|cube\|CUBE\|command' >> /tmp/DUALISO/FFmpeg_ALL; done 
    if ! [ x"$(cat /tmp/DUALISO/FFmpeg_ALL)" = x ]
    then
#Start X ProRes counter
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then 
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
#ProRes time command
    res15=$(date +%s)
sleep 1
    . "$path_2"Contents/FFmpeg_ALL_01.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_02.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_03.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_04.command & sleep 1
    fi
    fi
#check for proxy
    if [ x"$(cat /tmp/_X_Proxy)" = x ]
    then
    if ! [ x"$(cat /tmp/_X_ProRes4444)" = x ]
    then
     for f in *; do [[ -f "$f" ]] && ls "$f" | grep -v 'RAW\|R00\|R01\|R02\|R03\|R04\|R05\|R06\|R07\|R08\|R09\|R10\|R11\|R12\|R13\|R14\|R15\|MLV\|M00\|M01\|M02\|M03\|M04\|M05\|M06\|M07\|M08\|M09\|\|M10\|M11\|M12\|M13\|M14\|M15\|CR2\|dng\|DNG\|txt\|TXT\|tif\|tiff\|TIF\|TIFF\|jpg\|JPG\|cube\|CUBE\|command' >> /tmp/DUALISO/FFmpeg_ALL; done 
    if ! [ x"$(cat /tmp/DUALISO/FFmpeg_ALL)" = x ]
    then
#Start X ProRes counter
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then 
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
#ProRes time command
    res15=$(date +%s)
sleep 1
    . "$path_2"Contents/FFmpeg_ALL_01.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_02.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_03.command & sleep 1
    . "$path_2"Contents/FFmpeg_ALL_04.command & sleep 1
    fi
    fi
    fi
#trap
    while grep 'trap' /tmp/DUALISO/X_prores_TRAP 2>/dev/null
    do
    sleep 2
    done
#ProRes time command
    res25=$(date +%s)
    if ! [ x"$res15" = x ]
    then
    dt5=$(echo "$res25 - $res15" | bc)
    dd5=$(echo "$dt5/86400" | bc)
    dt25=$(echo "$dt5-86400*$dd5" | bc)
    dh5=$(echo "$dt25/3600" | bc)
    dt35=$(echo "$dt25-3600*$dh5" | bc)
    dm5=$(echo "$dt35/60" | bc)
    ds5=$(echo "$dt35-60*$dm5" | bc) 
    fi
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd5 $dh5 $dm5 $ds5 > /tmp/DUALISO/TOT_xprores 
###############################################################
#Manually selected FLATFRAMES processing
    if [ -f /tmp/DUALISO/FLATFRAMES ]
    then
    mkdir -p /tmp/DUALISO/
    mkdir -p A_ORIGINALS
#Start investigating if selected both flatdark and FLATFRAMES
    if ! [ x"$(cat /tmp/DUALISO/FLATFRAMES | awk 'FNR == 2 {print $1}')" = x ]
    then
    OLDIFS=$IFS
    IFS=$'\n'
    for FILE in `echo "$(cat /tmp/DUALISO/FLATFRAMES | head -1)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_flat=$!
#wait for jobs to finish   
    sleep 2
#kill $mlv_dump
    kill $pid_flat
    rm *_.wav
    ls *_000001.dng > /tmp/DUALISO/FLAT
    done 
    IFS=$OLDIFS 
#Inspect exposure of rgb pixel. If totally dark below 1 should do otherwise some sort of light is passing through to the sensor
    dcraw -d -W -c "$(cat /tmp/DUALISO/FLAT | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -pix_fmt yuvj444p "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".jpeg
#use imagemagick to read pixel brightness
    convert $(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1).jpeg -colorspace hsb -resize 1x1 $(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1).txt
    numb=$(echo $(grep '%' $(cat /tmp/DUALISO/FLAT| head -1 | cut -d "." -f1).txt | cut -d "%" -f3 | tr -d ',')) 
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -v "$(cat /tmp/DUALISO/FLATFRAMES | head -1)" | awk '/Res/ { print $2; exit }')
    if (( $(echo "$numb < 1.3" |bc -l) )); then
#remove unwanted files
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".txt
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".jpeg
    rm "$(cat /tmp/DUALISO/FLAT | head -1)"
#create the flat-dark, head -1 is the darkflat, head -2 is the FLATFRAMES
    $mlv_dump -s "$(cat /tmp/DUALISO/FLATFRAMES | head -1)" -o F_lat_D_ark.MLV "$(cat /tmp/DUALISO/FLATFRAMES | tail -1)"
    $mlv_dump F_lat_D_ark.MLV -a -o ft_"$fres"_"$(cat /tmp/DUALISO/FLATFRAMES | head -1 | grep -o '[^/]*$')"
    rm F_lat_D_ark.MLV
#move original files
    mv -i "$(cat /tmp/DUALISO/FLATFRAMES | tail -1)" A_ORIGINALS
    mv -i "$(cat /tmp/DUALISO/FLATFRAMES | head -1)" A_ORIGINALS
    else
#remove unwanted files
    rm "$(cat /tmp/DUALISO/FLAT| head -1 | cut -d "." -f1)".txt
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".jpeg
    rm "$(cat /tmp/DUALISO/FLAT | head -1)"
    $mlv_dump -s "$(cat /tmp/DUALISO/FLATFRAMES | tail -1)" -o F_lat_D_ark.MLV "$(cat /tmp/DUALISO/FLATFRAMES | head -1)"
    $mlv_dump F_lat_D_ark.MLV -a -o ft_"$fres"_"$(cat /tmp/DUALISO/FLATFRAMES | tail -1 | grep -o '[^/]*$')"
    rm F_lat_D_ark.MLV
#move original files
    mv -i "$(cat /tmp/DUALISO/FLATFRAMES | tail -1)" A_ORIGINALS
    mv -i "$(cat /tmp/DUALISO/FLATFRAMES | head -1)" A_ORIGINALS
    fi 
    fi
    fi
#If only selected flatframe without darkflat
    if [ x"$(cat /tmp/DUALISO/FLATFRAMES | awk 'FNR == 2 {print $1}')" = x ]
    then
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -v "$(cat /tmp/DUALISO/FLATFRAMES)" | awk '/Res/ { print $2; exit }')
    OLDIFS=$IFS
    IFS=$'\n'
    $mlv_dump "$(cat /tmp/DUALISO/FLATFRAMES)" -a -o ft_"$fres"_"$(cat /tmp/DUALISO/FLATFRAMES | grep -o '[^/]*$')"
    IFS=$OLDIFS 
    rm *_.wav
#move original file
    mv -i "$(cat /tmp/DUALISO/FLATFRAMES)" A_ORIGINALS
    fi
###############################################################
#Fully automated flatframe processing(if not manual flatframe processing selected)
#Will take white space
    if [ -f /tmp/DUALISO/FLATFRAME_A ]
    then
    mkdir -p /tmp/DUALISO/
    mkdir -p A_ORIGINALS
#Creation of flatframes. Check for amount of frames, size of file
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    if (( $(echo "$($mlv_dump -v "$FILE" | awk '/Processed/ { print $2;}') < 400" |bc -l) )) && (( $(echo "$(wc -c < "$FILE") < 1000000000" |bc -l) ))
    then 
    echo "$FILE" >> /tmp/DUALISO/FLAT
    fi
    done
#List files according to search criteria above
    for FILE in `echo "$(cat /tmp/DUALISO/FLAT)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_flat=$!
#wait for jobs to finish   
    sleep 2
#kill $mlv_dump
    kill $pid_flat
    rm *_.wav
    ls *_000001.dng > /tmp/DUALISO/FLAT
    done 
    IFS=$OLDIFS  
#Inspect exposure of rgb pixel. If too dark below 75 it,s not conisdered a flatframe
    while grep -q 'dng' /tmp/DUALISO/FLAT
    do 
    dcraw -d -W -c "$(cat /tmp/DUALISO/FLAT | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -pix_fmt yuvj444p "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".jpeg
#use imagemagick to read pixel brightness
    convert $(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1).jpeg -colorspace hsb -resize 1x1 $(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1).txt
    numb=$(echo $(grep '%' $(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1).txt | cut -d "%" -f3 | tr -d ',')) 
    if (( $(echo "$numb < 45" |bc -l) )); then
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".txt
    else
#Send flatframe MLV to a list which met the last criteria of exposure above 45
    echo "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "_" -f1)".MLV >> My_flatfr
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".txt
    fi
    rm "$(cat /tmp/DUALISO/FLAT | head -1)"
    rm "$(cat /tmp/DUALISO/FLAT | head -1 | cut -d "." -f1)".jpeg
    echo "$(tail -n +2 /tmp/DUALISO/FLAT)" > /tmp/DUALISO/FLAT
    done
    rm /tmp/DUALISO/FLAT
#Create the actual flatframes
    while grep 'MLV' My_flatfr
    do
#grab frame size and add info to the name of the file
    fres=$($mlv_dump -v "$(cat My_flatfr | head -1)" | awk '/Res/ { print $2; exit }')
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
    if [ -f /tmp/DARK ]
    then
#if full auto was chosen
    if [ -f /tmp/DUALISO/FULL_AUTO ]
    then
    if ls *.MLV
    then
    osascript -e 'display notification "darkframe automation in progress" with title "Auto mode"'
    afplay /System/Library/Sounds/Tink.aiff   
    fi
    fi
    mkdir -p /tmp/DUALISO/
    mkdir -p A_ORIGINALS
#Creation of darkframes. Check for amount of frames, size of file
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    if (( $(echo "$($mlv_dump -v "$FILE" | awk '/Processed/ { print $2;}') < 400" |bc -l) )) && (( $(echo "$(wc -c < "$FILE") < 1000000000" |bc -l) ))
    then 
    echo "$FILE" >> /tmp/DUALISO/darkf.txt
    fi
    done
#List files according to search criteria above
    for FILE in `echo "$(cat /tmp/DUALISO/darkf.txt)" 2>/dev/null`; do
    $mlv_dump --dng -f 1-1 "$FILE" & pid_dark=$!
#wait for jobs to finish   
    sleep 2
#kill $mlv_dump
    kill $pid_dark
    rm *.wav
    ls *_000001.dng > /tmp/DUALISO/darkf.txt
    done 
    IFS=$OLDIFS  
#Inspect exposure of rgb pixel. If totally dark below 1 should do otherwise some sort of light is passing through to the sensor
    while grep -q 'dng' /tmp/DUALISO/darkf.txt
    do 
    if grep -q 'pblack' <<< $(dcraw -d -W -c "$(cat /tmp/DUALISO/darkf.txt | head -1)" | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -vframes 1 -y -vf blackframe -f null /dev/null 2>&1 | grep -m1 'pblack')
    then 
#Send darkframe MLV to a list which met the last criteria of exposure below 1.3
    echo "$(cat /tmp/DUALISO/darkf.txt | head -1 | cut -d "_" -f1)".MLV >> My_darkfr
    else
    rm "$(cat /tmp/DUALISO/darkf.txt | head -1 | cut -d "." -f1)".txt
    rm "$(cat /tmp/DUALISO/darkf.txt | head -1 | cut -d "." -f1)".txt
    fi
    rm "$(cat /tmp/DUALISO/darkf.txt | head -1)"
    echo "$(tail -n +2 /tmp/DUALISO/darkf.txt)" > /tmp/DUALISO/darkf.txt
    done
    rm /tmp/DUALISO/darkf.txt
#Create the actual darkframes
    while grep 'MLV' My_darkfr
    do
    $mlv_dump -o avg_"$(cat My_darkfr | head -1)" -a "$(cat My_darkfr | head -1)"
    rm *.wav
    bit=$($mlv_dump -v "$(cat My_darkfr | head -1)" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -v "$(cat My_darkfr | head -1)" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -v "$(cat My_darkfr | head -1)" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -v "$(cat My_darkfr | head -1)" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -v "$(cat My_darkfr | head -1)" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    mv avg_"$(cat My_darkfr | head -1)" avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    mkdir -p A_ORIGINALS/darkframe_originals
    mv "$(cat My_darkfr | head -1)" A_ORIGINALS/darkframe_originals
    echo "$(tail -n +2 My_darkfr)" > My_darkfr
    done
    rm My_darkfr
#stop if selected only_DARK
    if [ -f /tmp/only_DARK ]
    then 
    exit 0
    fi
#when going for dng files only
    if ! [ -f /tmp/only_DNG ]
    then
#Create darkframe MLV files
    OLDIFS=$IFS
    IFS=$'\n'    
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    bit=$($mlv_dump -v "$FILE" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -v "$FILE" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -v "$FILE" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -v "$FILE" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -v "$FILE" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    if [ -f avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
#Check for flatframe
    if ! ls ft_*.MLV
    then
#list mlv files and send them for processing
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > /tmp/DUALISO/DF_storage
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/DF_storage ) / 4 + 1 )) /tmp/DUALISO/DF_storage /tmp/DUALISO/DF_storage
    rm /tmp/DUALISO/DF_storage
#create a new folder path file
    cat /tmp/DUALISO/path_1 > /tmp/DARK_FOLDER
    . "$path_2"Contents/DF_storage_01.command & 
    . "$path_2"Contents/DF_storage_02.command & 
    . "$path_2"Contents/DF_storage_03.command & 
    . "$path_2"Contents/DF_storage_04.command & 
#trap
    while [ `ls -1 /tmp/DUALISO/DF_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    rm /tmp/DARK_FOLDER
    else
#Do frame size match?
    if [ "$res" = "$fres" ]
    then
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV -t ft_*.MLV "$FILE"
    rm *.wav
    else
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV "$FILE"
    rm *.wav
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
    rm *.wav
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
    if [ -f /tmp/NO_DNG ]
    then
    rm /tmp/NO_DNG
    exit 0
    fi
    fi
###############################################################
#extra round to check if darkframe or flatframe still are present in root folder
#when going for dng files only
    if ! [ -f /tmp/only_DNG ]
    then
#Create darkframe MLV files
    OLDIFS=$IFS
    IFS=$'\n'
    for FILE in `ls -A1 *.MLV *.mlv | grep -v 'avg_\|ft_' 2>/dev/null`; do
    bit=$($mlv_dump -v "$FILE"| awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -v "$FILE" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -v "$FILE" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -v "$FILE" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -v "$FILE" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
#grab flatframe frame size 
    fres=$($mlv_dump -v ft_*.MLV | awk '/Res/ { print $2; exit }')
    if [ -f avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
#Check for flatframe
    if ! ls ft_*.MLV
    then
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV "$FILE"
    rm *MLV.wav
    else
#Do frame size match?
    if [ "$res" = "$fres" ]
    then
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV -t ft_*.MLV "$FILE"
    rm *MLV.wav
    rm *_.wav
    else
    $mlv_dump -o a_"$FILE" -s avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV "$FILE"
    rm *MLV.wav
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
    fi
    mv -i "$FILE" A_ORIGINALS
    mv -i $("$FILE" | cut -d "." -f1).M* A_ORIGINALS
    fi
    fi
    done
    mv -i avg_*.MLV A_ORIGINALS
    mv -i ft_*.MLV A_ORIGINALS
    IFS=$OLDIFS
    fi
###############################################################
#Create darkframe MLV files from storage folder 
    if [ -f /tmp/DARK_FOLDER ]
    then
#Create the actual darkframes if needed
    OLDIFS=$IFS
    IFS=$'\n'    
    cd "$(cat /tmp/DARK_FOLDER)"
    ls *.MLV *.mlv | grep -v 'avg_' > /tmp/DUALISO/darkf.txt
    while grep 'MLV' /tmp/DUALISO/darkf.txt
    do
    mkdir -p darkfr_ORIGINALS
    $mlv_dump -o avg_"$(cat /tmp/DUALISO/darkf.txt | head -1)" -a "$(cat /tmp/DUALISO/darkf.txt | head -1)"
    rm *MLV.wav
    bit=$($mlv_dump -v "$(cat /tmp/DUALISO/darkf.txt | head -1)" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -v "$(cat /tmp/DUALISO/darkf.txt | head -1)" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -v "$(cat /tmp/DUALISO/darkf.txt | head -1)" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -v "$(cat /tmp/DUALISO/darkf.txt | head -1)" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -v "$(cat /tmp/DUALISO/darkf.txt | head -1)" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    mv avg_"$(cat /tmp/DUALISO/darkf.txt | head -1)" avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    mv "$(cat /tmp/DUALISO/darkf.txt | head -1)" darkfr_ORIGINALS
    echo "$(tail -n +2 /tmp/DUALISO/darkf.txt)" > /tmp/DUALISO/darkf.txt
    done
    rm /tmp/DUALISO/darkf.txt
    IFS=$OLDIFS
#Darkframe folder storage
#go back to root folder
    cd "$(cat /tmp/DUALISO/path_1)"
#when going for dng files only
    if ! [ -f /tmp/only_DNG ]
    then 
#list mlv files
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > /tmp/DUALISO/DF_storage
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/DF_storage ) / 4 + 1 )) /tmp/DUALISO/DF_storage /tmp/DUALISO/DF_storage
    rm /tmp/DUALISO/DF_storage
#do files exist or not
    if ! [ x"$(cat /tmp/DUALISO/DF_storageaa)" = x ]
    then
    . "$path_2"Contents/DF_storage_01.command & 
    . "$path_2"Contents/DF_storage_02.command & 
    . "$path_2"Contents/DF_storage_03.command & 
    . "$path_2"Contents/DF_storage_04.command & 
    fi
#trap
    while [ `ls -1 /tmp/DUALISO/DF_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    rm /tmp/DUALISO/DF_TRAP
    fi
#NO_DNG processing after creation of darkframe processing
    if [ -f /tmp/NO_DNG ]
    then
    rm /tmp/NO_DNG
    exit 0
    fi 
    fi
###############################################################
#Processing MLV files into folders with dng files
#create the mlv time command list
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > /tmp/DUALISO/MLVprogress_bar
#if full auto was chosen
    if [ -f /tmp/DUALISO/FULL_AUTO ]
    then
    if ls *.MLV
    then
    osascript -e 'display notification "MLV to dng processing" with title "Auto mode"'
    afplay /System/Library/Sounds/Tink.aiff
    fi
    fi
#Multithreading badpixel lists. Script from dfort   
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > /tmp/DUALISO/badpixelMLV
#do files exist or not
    if ! [ x"$(cat /tmp/DUALISO/badpixelMLV)" = x ]
    then
#check for disabling of fpm files
    if ! grep 'no-fixfp' /tmp/mlv_dump_on_steroids_settings
    then
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/badpixelMLV ) / 4 + 1 )) /tmp/DUALISO/badpixelMLV /tmp/DUALISO/badpixelMLV
    rm /tmp/DUALISO/badpixelMLV
    . "$path_2"Contents/badpixels_01.command & 
    . "$path_2"Contents/badpixels_02.command & 
    . "$path_2"Contents/badpixels_03.command & 
    . "$path_2"Contents/badpixels_04.command & 
#trap
    while [ `ls -1 /tmp/DUALISO/BP_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    fi
    fi
#Start MLV counter
    if ls *.MLV
    then 
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    for FILE in `ls -A1 *.MLV *.mlv *.M0* *.M1* *.M2* *.M3* *.M4* *.M5* | grep -v 'avg_\|ft_' 2>/dev/null`; do
    $mlv_dump -v "$FILE" | awk '/Frames/ { print $3; exit}' >> /tmp/DUALISO/MLVprogress_bar3 
    done
    open "$path_2"Contents/progress_bar.command &
    fi
    fi
#mlv_dump time command
    if ! ls /tmp/DUALISO/mlv_dump_TIME
    then
    echo > /tmp/DUALISO/mlv_dump_TIME
    res11=$(date +%s)
    fi
#Will take white space
    OLDIFS=$IFS
    IFS=$'\n'
    ls *.MLV *.mlv | grep -v 'avg_\|ft_' > /tmp/DUALISO/MLVFILES
#reset IFS
    IFS=$OLDIFS
#specify THREADS if
    if [ -f /tmp/THREADS ]
    then
    THR=$(cat /tmp/THREADS | tr -d Threads)
    else
    THR=$(echo 4)
    fi
#safety check
    if (( $THR > 4 )); then
    THR=$(echo 4)
    fi
#split into 4 chunks
    split -l $(( $( wc -l < /tmp/DUALISO/MLVFILES ) / $THR + 1 )) /tmp/DUALISO/MLVFILES /tmp/DUALISO/MLVFILES
    rm /tmp/DUALISO/MLVFILES
#if processing PROXYONLY
    if ! [ -f /tmp/PROXYONLY ]
    then
    . "$path_2"Contents/mlv_dump_01.command & pid1=$!
    . "$path_2"Contents/mlv_dump_02.command & pid2=$!
    . "$path_2"Contents/mlv_dump_03.command & pid3=$!
    . "$path_2"Contents/mlv_dump_04.command & pid4=$!
    else
    . "$path_2"Contents/proxy_only_01.command & pid1=$!
    . "$path_2"Contents/proxy_only_02.command & pid2=$!
    . "$path_2"Contents/proxy_only_03.command & pid3=$!
    . "$path_2"Contents/proxy_only_04.command & pid4=$! 
    fi
#wait for jobs to end
    wait < <(jobs -p)
#mlv_dump time command
    res21=$(date +%s)
    if ! [ x"$res11" = x ]
    then
    dt1=$(echo "$res21 - $res11" | bc)
    dd1=$(echo "$dt1/86400" | bc)
    dt21=$(echo "$dt1-86400*$dd1" | bc)
    dh1=$(echo "$dt21/3600" | bc)
    dt31=$(echo "$dt21-3600*$dh1" | bc)
    dm1=$(echo "$dt31/60" | bc)
    ds1=$(echo "$dt31-60*$dm1" | bc)
    fi
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd1 $dh1 $dm1 $ds1 > /tmp/DUALISO/TOT_mlv_dump
###############################################################
#Processing RAW files
    if ls *.RAW 
    then
#raw2dng time command
    res12=$(date +%s)
    fi
#Start RAW counter
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    ls *.RAW | grep -v 'avg_\|ft_' > /tmp/DUALISO/RAWprogress_bar
    if grep -q 'RAW' /tmp/DUALISO/RAWprogress_bar
    then
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
    fi
#if full auto was chosen
    if ls /tmp/DUALISO/FULL_AUTO
    then
    if ls *.RAW 
    then
    osascript -e 'display notification "RAW to dng processing" with title "Auto mode"'
    afplay /System/Library/Sounds/Tink.aiff
    fi
    fi
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
#tail the RAWprogress_bar list
    echo "$(tail -n +2 /tmp/DUALISO/RAWprogress_bar)" > /tmp/DUALISO/RAWprogress_bar
#reset IFS
    IFS=$OLDIFS
#M #650D #700D #100D check for pixel script
    exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng -X > /tmp/DUALISO/what_cam.txt -overwrite_original
    if grep 'ColorMatrix1>0.6602' /tmp/DUALISO/what_cam.txt 
    then
    fs=$(exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Image Size/ { print $4; }')
    this_cam=$(cat /tmp/DUALISO/"this_cam")
    fs=$(cat /tmp/DUALISO/"image_size")
    mode=$(cat /tmp/DUALISO/"mode")
    fpm.sh -c "$this_cam" -m "$mode" -s "$fs" -o "$(cat /tmp/DUALISO/path_1)"/"${BASE}"_1_$(date +%Y-%m-%d)_0001_C0000/pix_fix.txt hej.RAW &
#check if default scale tag needs to be added or else only camera name gets added 
    find . -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 "$(cat /tmp/DUALISO/def_scal)" -M"set Exif.Image.UniqueCameraModel Ascii $this_cam"
    fi
#check if footage is slowmotion. will add specific default scale tag
    if ! grep 'ColorMatrix1>0.6602' /tmp/DUALISO/what_cam.txt
    then 
    numbc=$(exiftool "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Frame Rate/ { print $4; }' | cut -f1 -d".")
    count=$numbc
    if [ $count -gt 47 ]
    then 
    find . -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 5/3"
    fi
    fi
#Stored cr2hdr settings
    set=$(cat /tmp/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
#Verify dualiso or else contiue to next file
    cr2hdr $set "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | tee /tmp/DUALISO/dualiso.txt 
    if ! grep 'look like interlaced ISO' /tmp/DUALISO/dualiso.txt
    then
    rm /tmp/DUALISO/dualiso.txt
#grab fps before it,s too late
    fps=$(exiv2 -pt "${BASE}"_1_$(date +%Y-%m-%d)_0001_C000000.dng | awk '/Exif.Image.FrameRate/ { print $4; }')
#cr2hdr processing
    find . -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P $(sysctl -n hw.physicalcpu) -n 1 cr2hdr $set
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
#raw2dng time command
    res22=$(date +%s)
    if ! [ x"$res12" = x ]
    then
    dt2=$(echo "$res22 - $res12" | bc)
    dd2=$(echo "$dt2/86400" | bc)
    dt22=$(echo "$dt2-86400*$dd2" | bc)
    dh2=$(echo "$dt22/3600" | bc)
    dt32=$(echo "$dt22-3600*$dh2" | bc)
    dm2=$(echo "$dt32/60" | bc)
    ds2=$(echo "$dt32-60*$dm2" | bc)
    fi
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd2 $dh2 $dm2 $ds2 > /tmp/DUALISO/TOT_raw2dng
###############################################################
#Export to ProRes4444 and/or ProRes proxy 
    if ! [ x"$(cat /tmp/FFmpeg_settingsPR)" = x ]
    then
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
#Start ProRes counter
    if ! [ x"$(cat /tmp/DUALISO/FFmpeg)" = x ]
    then 
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then 
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
#ProRes time command
    res14=$(date +%s)
    . "$path_2"Contents/FFmpeg_produce_01.command & sleep 1
    if [ -f /tmp/THREADS ]
    then
    THR=$(cat /tmp/THREADS | tr -d Threads)
    if (( $THR > 1 ))
    then
    . "$path_2"Contents/FFmpeg_produce_02.command & sleep 1
    fi
    if (( $THR > 2 ))
    then
    . "$path_2"Contents/FFmpeg_produce_03.command & sleep 1
    fi
    if (( $THR > 3 ))
    then
    . "$path_2"Contents/FFmpeg_produce_04.command & sleep 1
    fi
    else
    . "$path_2"Contents/FFmpeg_produce_02.command & sleep 1
    . "$path_2"Contents/FFmpeg_produce_03.command & sleep 1
    . "$path_2"Contents/FFmpeg_produce_04.command & sleep 1
    fi
    fi
    fi
#check for proxy ProRes first
    if [ x"$(cat /tmp/FFmpeg_settingsPR)" = x ]
    then
    if ! [ x"$(cat /tmp/FFmpeg_settings)" = x ]
    then
    ls -d *C0000 > /tmp/DUALISO/FFmpeg
#Start ProRes counter
    if ! [ x"$(cat /tmp/DUALISO/FFmpeg)" = x ]
    then 
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
#ProRes time command
    res14=$(date +%s)
    . "$path_2"Contents/FFmpeg_produce_01.command & sleep 1
    if [ -f /tmp/THREADS ]
    then
    THR=$(cat /tmp/THREADS | tr -d Threads)
    if (( $THR > 1 ))
    then
    . "$path_2"Contents/FFmpeg_produce_02.command & sleep 1
    fi
    if (( $THR > 2 ))
    then
    . "$path_2"Contents/FFmpeg_produce_03.command & sleep 1
    fi
    if (( $THR > 3 ))
    then
    . "$path_2"Contents/FFmpeg_produce_04.command & sleep 1
    fi
    else
    . "$path_2"Contents/FFmpeg_produce_02.command & sleep 1
    . "$path_2"Contents/FFmpeg_produce_03.command & sleep 1
    . "$path_2"Contents/FFmpeg_produce_04.command & sleep 1
    fi
    fi
    fi
    fi
#trap
    while grep 'trap' /tmp/DUALISO/prores_TRAP 2>/dev/null
    do
    sleep 2
    done
#ProRes time command
    res24=$(date +%s)
    if ! [ x"$res14" = x ]
    then
    dt4=$(echo "$res24 - $res14" | bc)
    dd4=$(echo "$dt4/86400" | bc)
    dt24=$(echo "$dt4-86400*$dd4" | bc)
    dh4=$(echo "$dt24/3600" | bc)
    dt34=$(echo "$dt24-3600*$dh4" | bc)
    dm4=$(echo "$dt34/60" | bc)
    ds4=$(echo "$dt34-60*$dm4" | bc)
    fi
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd4 $dh4 $dm4 $ds4 > /tmp/DUALISO/TOT_prores
###############################################################
#Start RAW counter
#HDR_PROCESSING(don´t interfere with HDRCR2 processing)
    if ! [ -f /tmp/HDRCR2 ]
    then
    if ! [ -f /tmp/DUALISO/NOCOUNT ]
    then
    ls *.CR2 > /tmp/DUALISO/CR2progress_bar
    if grep -q 'CR2' /tmp/DUALISO/CR2progress_bar
    then
    rm /tmp/DUALISO/MLVprogress_bar_key
    open "$path_2"Contents/progress_bar.command &
    fi
    fi
#if full auto was chosen
    if ls /tmp/DUALISO/FULL_AUTO
    then
    if ls *.CR2
    then
    osascript -e 'display notification "CR2 dualiso processing" with title "Auto mode"'
    afplay /System/Library/Sounds/Tink.aiff
    fi
    fi
    if grep 'CR2\|DNG\|dng' <<< "$(ls *.CR2 *.DNG *.dng)"
    then 
#Create a dng file through Adobe dng converter for camera calibration tags 
    /Applications/Adobe\ DNG\ Converter.app/Contents/MacOS/Adobe\ DNG\ Converter -d /tmp/DUALISO "$(find *.CR2 | head -1)" 
    CAL=$(find *.CR2 | head -1 | cut -f1 -d".") 
#Let exiftool extract camera calibration values
    caltagA=$(exiftool /tmp/DUALISO/"$CAL".dng | awk '/Camera Calibration 1/ { print $5; exit }') 
    caltagB=$(exiftool /tmp/DUALISO/"$CAL".dng | awk '/Camera Calibration 1/ { print $13; exit }') 
    serial=$(exiftool /tmp/DUALISO/"$CAL".dng | grep -A1 'Owner Name' | awk 'FNR == 2 {print $4; exit}')
    rm /tmp/DUALISO/"$CAL".dng
#Stored cr2hdr settings
    set=$(cat /tmp/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
    set=$(cat /tmp/"A_cr2hdr_cmpr.txt" | sed -e 's/^[ \t]*//')
#Count cpu´s
    cpu=$(sysctl -n hw.physicalcpu)
#cpu boost
    if ls /tmp/cpuboost
    then
    cpu=$(sysctl -n hw.ncpu)
    fi
#run cr2hdr 4 processes in parallel
    ls *.DNG *.dng > /tmp/DUALISO/NOT_list
    echo hej >> /tmp/DUALISO/NOT_list
#cr2hdr time command
    res13=$(date +%s)
    if grep 'DNG\|dng' <<< "$(ls *.CR2 *.DNG *.dng)"
    then
    find . -maxdepth 1 -mindepth 1 -iname '*.DNG' -print0 | xargs -0 -P $cpu -n 1 cr2hdr $set $cmpr 
    fi
    if grep 'CR2' <<< "$(ls *.CR2 *.DNG *.dng)"
    then
    find . -maxdepth 1 -mindepth 1 -name '*.CR2' -print0 | xargs -0 -P $cpu -n 1 cr2hdr $set $cmpr
    fi
#cr2hdr time command
    res23=$(date +%s)
    if ! [ x"$res13" = x ]
    then
    dt3=$(echo "$res23 - $res13" | bc)
    dd3=$(echo "$dt3/86400" | bc)
    dt23=$(echo "$dt3-86400*$dd3" | bc)
    dh3=$(echo "$dt23/3600" | bc)
    dt33=$(echo "$dt23-3600*$dh3" | bc)
    dm3=$(echo "$dt33/60" | bc)
    ds3=$(echo "$dt33-60*$dm3" | bc)
    fi
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd3 $dh3 $dm3 $ds3 > /tmp/DUALISO/TOT_cr2hdr
#sort out the non dualiso CR2 files
    if [ x"$(ls *.DNG)" = x ] 
    then
    mkdir -p not_dualiso
    mv *.CR2 not_dualiso
    fi
    ls *.DNG  | cut -d "." -f1 > /tmp/DUALISO/not_dualiso
    while read line
    do
    echo "$line*"
    done < /tmp/DUALISO/not_dualiso > /tmp/DUALISO/not_dualiso1
    ls $(cat /tmp/DUALISO/not_dualiso1) > /tmp/DUALISO/not_dualiso
#if you find non dualiso files move them to folder
    if ! [ x"$(ls *.CR2 | grep -v "$(cat /tmp/DUALISO/not_dualiso)")" = x ] 
    then
    mkdir -p not_dualiso
    while IFS= read -r file; do mv "$file" not_dualiso; done <<< "$(ls *.CR2 | grep -v "$(cat /tmp/DUALISO/not_dualiso)")"
    fi   
#obtaining dcraw white balance multipliers and calculating them to AsShotNeutralvalues in the DNG file (thanks Chmee)
    ls *.CR2 > /tmp/DUALISO/d_iso_list
    cr2=$(ls *.CR2 | wc -l)
#if less than 4 files
    if ! [ $(ls *.CR2 | wc -l) -lt 4 ]; then 
#if working with 6 or 7 CR2 files
    if [[ "$(echo $cr2 | tr -d ' ')" == [67] ]]; then
    sed -n 1,$(($cr2/4))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_02
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_03
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_03
    sed -n $(($cr2/4*5+1)),$(($cr2/4*6))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_04
    sed -n $(($cr2/4*6+1)),$(($cr2/4*7))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
#Listing of DNG files
    ls *.DNG | grep -v "$(cat /tmp/DUALISO/NOT_list)" > /tmp/DUALISO/d_iso_list
    cr2=$(ls *.DNG | wc -l)
    sed -n 1,$(($cr2/4))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_02
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_03
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_03
    sed -n $(($cr2/4*5+1)),$(($cr2/4*6))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
    sed -n $(($cr2/4*6+1)),$(($cr2/4*7))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
#Sorting of CR2 and DNG files
    ls $(cat /tmp/DUALISO/list_01) > /tmp/DUALISO/list_01
    ls $(cat /tmp/DUALISO/list_02) > /tmp/DUALISO/list_02
    ls $(cat /tmp/DUALISO/list_03) > /tmp/DUALISO/list_03
    ls $(cat /tmp/DUALISO/list_04) > /tmp/DUALISO/list_04
    else
    sed -n 1,$(($cr2/4))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_03
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p /tmp/DUALISO/d_iso_list > /tmp/DUALISO/list_04
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
#Listing of DNG files
    ls *.DNG | grep -v "$(cat /tmp/DUALISO/NOT_list)" > /tmp/DUALISO/d_iso_list
    cr2=$(ls *.DNG | wc -l)
    sed -n 1,$(($cr2/4))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_01
    sed -n $(($cr2/4+1)),$(($cr2/4*2))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_02
    sed -n $(($cr2/4*2+1)),$(($cr2/4*3))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_03
    sed -n $(($cr2/4*3+1)),$(($cr2/4*4))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
    sed -n $(($cr2/4*4+1)),$(($cr2/4*5))p /tmp/DUALISO/d_iso_list >> /tmp/DUALISO/list_04
#Sorting of CR2 and DNG files
    ls $(cat /tmp/DUALISO/list_01) > /tmp/DUALISO/list_01
    ls $(cat /tmp/DUALISO/list_02) > /tmp/DUALISO/list_02
    ls $(cat /tmp/DUALISO/list_03) > /tmp/DUALISO/list_03
    ls $(cat /tmp/DUALISO/list_04) > /tmp/DUALISO/list_04
    fi
#if less than 4 files
    else
    ls *.CR2 *.DNG | grep -v "$(cat /tmp/DUALISO/NOT_list)" > /tmp/DUALISO/list_01 
    fi
###############################################################
#multithread processing
    . "$path_2"Contents/dualiso_to_DNG_A.command & pid1=$! 
    . "$path_2"Contents/dualiso_to_DNG_B.command & pid2=$! 
    . "$path_2"Contents/dualiso_to_DNG_C.command & pid3=$! 
    while grep -q 'CR2' /tmp/DUALISO/list_01
    do
    CR2=$(grep 'CR2' /tmp/DUALISO/list_01 | awk 'FNR == 1 {print}')
    DNG=$(grep 'DNG' /tmp/DUALISO/list_01 | awk 'FNR == 1 {print}')
#Will add stored white balance settings to processed readymade dualiso DNG files
    echo "$(tail -n +3 /tmp/DUALISO/list_01)" > /tmp/DUALISO/list_01
#matching camera serial or not
    serial_match=$(exiftool "$CR2" | grep -A1 'Owner Name' | awk 'FNR == 2 {print $4; exit}')
    if ! [ "$serial" = "$serial_match" ]; then
    /Applications/Adobe\ DNG\ Converter.app/Contents/MacOS/Adobe\ DNG\ Converter -d /tmp/DUALISO "$CR2" 
    CAL=$(echo "$CR2" | cut -f1 -d".") 
    caltagA=$(exiftool /tmp/DUALISO/"$CAL".dng | awk '/Camera Calibration 1/ { print $5; exit }') 
    caltagB=$(exiftool /tmp/DUALISO/"$CAL".dng | awk '/Camera Calibration 1/ { print $13; exit }')
    rm /tmp/DUALISO/"$CAL".dng
    fi
#check if the camera is an eos 100D
    model_match=$(exiftool "$CR2" | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9,$10; exit }')
    echo "$model_match" > /tmp/DUALISO/model_match
    if grep 'Canon EOS 100D\|SL1\|Kiss X7\|X7' /tmp/DUALISO/model_match
    then
    exiftool "-ColorMatrix1=0.6985 -0.1611 -0.0397 -0.3596 1.0749 0.3295 -0.0349 0.1136 0.6512" "-ColorMatrix2=0.6602 -0.0841 -0.0939 -0.4472 1.2458 0.2247 -0.0975 0.2039 0.6148" "$(find "$CR2" | cut -f1 -d".")".DNG -overwrite_original ;
    fi 
    CR2_00=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $4; exit }')
    CR2_01=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $3; exit }') 
    CR2_01b=$(echo "$CR2_00"/"$CR2_01" | bc -l | awk 'FNR == 1 {print}')
#If adobe dng converter is installed this calibration compensation will take place
    if ls /Applications/Adobe\ DNG\ Converter.app/Contents/MacOS/Adobe\ DNG\ Converter
    then
    CR2_01b=$(echo "$CR2_01b/$caltagA" | bc -l | awk 'FNR == 1 {print}')
    fi
    CR2_00b=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $6; exit }')
    CR2_02=$(dcraw -i -v "$CR2" | awk '/Camera multipliers/ { print $5; exit }') 
    CR2_02b=$(echo "$CR2_00b"/"$CR2_02" | bc -l | awk 'FNR == 1 {print}')
#If adobe dng converter is installed this calibration compensation will take place
    if ls /Applications/Adobe\ DNG\ Converter.app/Contents/MacOS/Adobe\ DNG\ Converter
    then
    CR2_02b=$(echo "$CR2_02b/$caltagB" | bc -l | awk 'FNR == 1 {print}')
    fi
#Add neccesssary tags for white balance with exiftool. Also rearrange illuminant tags
    exiftool "-AsShotNeutral=$CR2_01b 1 $CR2_02b" "-CalibrationIlluminant1=Standard Light A" "-CalibrationIlluminant2=D65" "$DNG" -overwrite_original
    mkdir -p A_ORIGINALS
    mv -i "$CR2" A_ORIGINALS
#wait for jobs to end
    wait < <(jobs -p)
    done
    fi
    fi
#check if A_ORIGINALS is empty and the erase it
    if [ x"$(ls A_ORIGINALS/*)" = x ]
    then
    rm -r A_ORIGINALS
    fi
#iterate in folder tree
    echo "$(tail -n +2 /tmp/folder_paths.txt)" > /tmp/folder_paths.txt
    if ! [ x"$(cat /tmp/folder_paths.txt)" = x ]
    then
    echo "$(cat /tmp/folder_paths.txt | head -1)" > /tmp/DUALISO/path_1
    "$path_2"Contents/Switch_MAIN_DBG.command
    else
#The end
    sleep 1
#X to ProRes time command
    if [ x"$res15" = x ]
    then
    echo XxXx > /tmp/DUALISO/TOT_xprores
    fi
#mlv_dump time command
    if [ x"$res11" = x ]
    then
    echo XxXx > /tmp/DUALISO/TOT_mlv_dump
    fi
#raw2dng time command
    if [ x"$res12" = x ]
    then
    echo XxXx > /tmp/DUALISO/TOT_raw2dng
    fi
#ProRes time command
    if [ x"$res14" = x ]
    then
    echo XxXx > /tmp/DUALISO/TOT_prores
    fi
#cr2hdr time command check
    if [ x"$res13" = x ]
    then
    echo XxXx > /tmp/DUALISO/TOT_cr2hdr
    fi
#Total time command ends here
    res2=$(date +%s)
    dt=$(echo "$res2 - $res1" | bc)
    dd=$(echo "$dt/86400" | bc)
    dt2=$(echo "$dt-86400*$dd" | bc)
    dh=$(echo "$dt2/3600" | bc)
    dt3=$(echo "$dt2-3600*$dh" | bc)
    dm=$(echo "$dt3/60" | bc)
    ds=$(echo "$dt3-60*$dm" | bc)
    sleep 1
    printf "%d Days, %02d Hrs, %02d Min, %02d Sec\n" $dd $dh $dm $ds > /tmp/DUALISO/TOT_time  
    open "$path_2"Contents/progress_bar.command &
    fi
 
#Thanks to Bouncyball, A1ex(cr2hdr, raw2dng, mlv_dump) g3gg0(mlv_dump) Dave Coffin(dcraw) Fabrice Bellard(FFmpeg) Phil Harvey(Exiftool) Andreas Huggel(exiv2) BWF MetaEdit(FADGI) dfort(Focus pixel script).
#Copyright Danne
