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

#!/bin/bash
#print out trap note 2
echo 2trap >> /tmp/DUALISO/X_prores_TRAP
#first check for output
    if ls /tmp/output
    then
    out=$(cat /tmp/"output")/
    mkdir -p "$out"$(date +%F)_X_ProRes4444
    mkdir -p "$out"$(date +%F)_X_Proxy
    fi
#export to different flavours of prores through FFmpeg and dcraw
    while ! [ x"$(cat /tmp/DUALISO/FFmpeg_ALL)" = x ]
    do 
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg_ALL" | head -1)
#name without suffix
    name_01=$(cat /tmp/DUALISO/"FFmpeg_ALL" | head -1 | cut -d "." -f1)
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/FFmpeg_ALL)" > /tmp/DUALISO/FFmpeg_ALL
#determine if HDR or not
    tbl=
    cin=
    cinpr=
    ffmpeg -i "$name" -pix_fmt yuvj444p -r 1 -t 2 /tmp/DUALISO/check02%03d.jpeg
    convert /tmp/DUALISO/check02001.jpeg -colorspace hsb -resize 1x1 /tmp/DUALISO/check1_02.txt
    convert /tmp/DUALISO/check02002.jpeg -colorspace hsb -resize 1x1 /tmp/DUALISO/check2_02.txt
    numb=$(echo $(grep '%' /tmp/DUALISO/check1_02.txt | cut -d "%" -f3 | tr -d ',') - $(grep '%' /tmp/DUALISO/check2_02.txt | cut -d "%" -f3 | tr -d ',') | bc -l)
    if (( $(echo "$numb > 5" |bc -l) )) || (( $(echo "$numb < -5" |bc -l) )) ; then
    echo "HDR" >> /tmp/_X_HDR_02
    else
    find /tmp/_X_HDR_02 | xargs perl -pi -e 's/HDR//g'
    fi
    rm /tmp/DUALISO/check02001.jpeg
    rm /tmp/DUALISO/check02002.jpeg
    rm /tmp/DUALISO/check1_02.txt
    rm /tmp/DUALISO/check2_02.txt
#Choose FFmpeg output(ProRes4444)
    if grep 'copy' /tmp/_X_ProRes4444 
    then 
    cin= 
    elif grep 'logN' /tmp/_X_ProRes4444 
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))logNeutral.cube
    elif  grep 'login' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))logNeutral_inverse.cube  
    elif grep 'Clog' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))rec709_C-log.cube
    elif grep 'logC' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))rec709_logC.cube
    elif grep 'Xaces' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))aces.cube
    fi
#watch out for HDR footage
    if grep 'HDR\|halfhdr' /tmp/_X_HDR_02 
    then
    if grep 'copy' /tmp/_X_ProRes4444 
    then 
    cin= 
    elif grep 'logN' /tmp/_X_ProRes4444 
    then 
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))logNeutral.cube
    elif  grep 'login' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))logNeutral_inverse.cube  
    elif grep 'Clog' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))rec709_C-log.cube
    elif grep 'logC' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))rec709_logC.cube
    elif grep 'Xaces' /tmp/_X_ProRes4444 
    then
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))aces.cube
    fi
    fi
#Choose FFmpeg output(Proxy)
    if grep 'copypr' /tmp/_X_Proxy 
    then 
    cinpr= 
    elif grep 'logNpr' /tmp/_X_Proxy 
    then 
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))logNeutral.cube
    elif  grep 'loginpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))logNeutral_inverse.cube  
    elif grep 'Clogpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))rec709_C-log.cube
    elif grep 'logCpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))rec709_logC.cube
    elif grep 'Xacespr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))aces.cube
    fi
#watch out for HDR footage
    if grep 'HDR\|halfhdr' /tmp/_X_HDR_02 
    then
    if grep 'copypr' /tmp/_X_Proxy 
    then 
    cinpr= 
    elif grep 'logNpr' /tmp/_X_Proxy 
    then 
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))logNeutral.cube
    elif  grep 'loginpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))logNeutral_inverse.cube  
    elif grep 'Clogpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))rec709_C-log.cube
    elif grep 'logCpr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))rec709_logC.cube
    elif grep 'Xacespr' /tmp/_X_Proxy 
    then
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))aces.cube
    fi
    fi
#check for proxy or LT codec
    if grep 'codec_lt' /tmp/_X_Proxy 
    then 
    codec=$(printf "%s\n" -vcodec prores -profile:v 1)
    else
    codec=$(printf "%s\n" -vcodec prores -profile:v 0)
    fi
#check if footage is HDR(tblend filter)
    if grep 'HDR\|halfhdr' /tmp/_X_HDR_02 
    then 
    tbl=$(printf "%s\n" -vf tblend=all_mode=average)
    fi
#check for additional 3D luts in ProRes4444 folder
    if ls $(date +%F)_X_ProRes4444/*.cube
    then 
    if [ x"$cin" = x ]
    then 
    cin_01=$(printf "%s\n" -vf lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 3 {print; }'))
    else
    cin_01=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#if HDR do following
    if grep 'HDR\|halfhdr' /tmp/_X_HDR_02 
    then
    if ls $(date +%F)_X_ProRes4444/*.cube
    then 
    cin_01=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_ProRes4444/*.cube | awk 'FNR == 3 {print; }'))
    fi
    fi
#check for additional 3D luts in proxy folder
    if ls $(date +%F)_X_Proxy/*.cube
    then 
    if [ x"$cinpr" = x ]
    then 
    cinpr_01=$(printf "%s\n" -vf lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    else
    cinpr_01=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#if HDR do following
    if grep 'HDR\|halfhdr' /tmp/_X_HDR_02
    then
    if ls $(date +%F)_X_Proxy/*.cube
    then
    cinpr_01=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls $(date +%F)_X_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    fi 
    fi
#check for half fps setting HDR
    if grep 'halfhdr' /tmp/_X_HDR_02 
    then 
    fps=$(exiftool "$name" | awk '/Video Frame Rate/ { print $5; }')
    fi
#check for scale changes(prores4444)
    if ! [ x$(cat /tmp/_X_prores_SCALE) = x ]
    then
    if [ x"$cin""$tbl""$cin_01" = x ]
    then
    scale=$(printf "%s\n" -vf scale=$(cat /tmp/_X_prores_SCALE))
    else
    scale=$(printf "%s\n" ,scale=$(cat /tmp/_X_prores_SCALE))
    fi
    fi
#check for scale changes(proxy)
    if ! [ x$(cat /tmp/_X_proxy_SCALE) = x ]
    then
    if [ x"$cinpr""$tbl""$cinpr_01" = x ]
    then
    scalePR=$(printf "%s\n" -vf scale=$(cat /tmp/_X_proxy_SCALE))
    else
    scalePR=$(printf "%s\n" ,scale=$(cat /tmp/_X_proxy_SCALE))
    fi
    fi
#check for denoising settings(prores)
    if ! [ x$(cat /tmp/_X_denoise) = x ]
    then
    if [ x"$cin""$tbl""$cin_01""$scale" = x ]
    then
    denoise=$(printf "%s\n" -vf $(cat /tmp/_X_denoise))
    else
    denoise=$(printf "%s\n" ,$(cat /tmp/_X_denoise))
    fi
    fi
#check for denoising settings(proxy)
    if ! [ x$(cat /tmp/_X_denoise) = x ]
    then
    if [ x"$cinpr""$tbl""$cinpr_01""$scalePR" = x ]
    then
    denoisePR=$(printf "%s\n" -vf $(cat /tmp/_X_denoise))
    else
    denoisePR=$(printf "%s\n" ,$(cat /tmp/_X_denoise))
    fi
    fi
#check for sharpen settings(prores)
    if ! [ x$(cat /tmp/_X_sharpen) = x ]
    then
    if [ x"$cin""$tbl""$cin_01""$scale""$denoise" = x ]
    then
    sharpen=$(printf "%s\n" -vf $(cat /tmp/_X_sharpen))
    else
    sharpen=$(printf "%s\n" ,$(cat /tmp/_X_sharpen))
    fi
    fi
#check for sharpen settings(proxy)
    if ! [ x$(cat /tmp/_X_sharpen) = x ]
    then
    if [ x"$cinpr""$tbl""$cinpr_01""$scalePR""$denoisePR" = x ]
    then
    sharpenPR=$(printf "%s\n" -vf $(cat /tmp/_X_sharpen))
    else
    sharpenPR=$(printf "%s\n" ,$(cat /tmp/_X_sharpen))
    fi
    fi
#check for tif spitter
    if ! ls /tmp/DUALISO/tif_spit 
    then
#Export to different flavours of ProRes 
#check if ProRes settings file contains information export ProRes4444
    if ! [ x"$(cat /tmp/_X_ProRes4444)" = x ]
    then
    mkdir -p "$out"$(date +%F)_X_ProRes4444
#watch ut for half fps(HDR setting)
    if grep -q 'halfhdr' /tmp/_X_HDR_02 && grep -q 'HDR' /tmp/_X_HDR_02
    then
    ffmpeg -loglevel warning -i "$name" -vcodec prores_ks -pix_fmt yuv444p10 -n $tbl$cin$cin_01$cin_02$cin_03$scale$denoise$sharpen -r $(echo $fps / 2 | bc -l) "$out"$(date +%F)_X_ProRes4444/"$name_01".mov
    else
    ffmpeg -loglevel warning -i "$name" -vcodec prores_ks -pix_fmt yuv444p10 -n $tbl$cin$cin_01$cin_02$cin_03$scale$denoise$sharpen "$out"$(date +%F)_X_ProRes4444/"$name_01".mov
    fi
    fi
#check if proxy settings file contains information export ProRes proxy
    if ! [ x"$(cat /tmp/_X_Proxy)" = x ]
    then
    mkdir -p "$out"$(date +%F)_X_Proxy
#watch ut for half fps(HDR setting)
    if grep -q 'halfhdr' /tmp/_X_HDR_02 && grep -q 'HDR' /tmp/_X_HDR_02
    then
    ffmpeg -loglevel warning -i "$name" $codec -n $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$scalePR$denoisePR$sharpenPR -r $(echo $fps / 2 | bc -l) "$out"$(date +%F)_X_Proxy/"$name_01".mov
    else
    ffmpeg -loglevel warning -i "$name" $codec -n $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$scalePR$denoisePR$sharpenPR "$out"$(date +%F)_X_Proxy/"$name_01".mov 
    fi
    fi
#move original file to A_ORIGINALS
    mv -n "$name" A_ORIGINALS
    else
#Export to different flavours of ProRes 
#check if ProRes settings file contains information
    if ! [ x"$(cat /tmp/_X_ProRes4444)" = x ]
    then
    mkdir -p "$out"$(date +%F)_X_ProRes4444
    ffmpeg -loglevel warning -i "$name" -y -pix_fmt rgb24 $tbl$cin$cin_01$cin_02$cin_03$scale$denoise$sharpen -t 1 "$out"$(date +%F)_X_ProRes4444/"$name_01".tif
    fi
#check if proxy settings file contains information 
    if ! [ x"$(cat /tmp/_X_Proxy)" = x ]
    then
    mkdir -p "$out"$(date +%F)_X_Proxy
    ffmpeg -loglevel warning -i "$name" -y -pix_fmt rgb24 $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$scalePR$denoisePR$sharpenPR -t 1 "$out"$(date +%F)_X_Proxy/"$name_01".tif
    fi
    fi
    done
#remove trap
find /tmp/DUALISO/X_prores_TRAP | xargs perl -pi -e 's/2trap//g'

