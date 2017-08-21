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
#glue date
    date=$(date +%F)
#export to different flavours of prores through FFmpeg and dcraw
    while grep -q 'C0000' ~/Switch/config/tmp/FFmpegab
    do 
#output name then enter the folder and then tail the list to next folder
    name=$(cat ~/Switch/config/tmp/"FFmpegab" | head -1)
#establish output location
    if ls ~/Switch/config/output
    then
#output name
    out=$(cat ~/Switch/config/"output")/
#safety check new folder location(root)
    if ! ls -d "$out""$name" 
    then
    out= 
    out2=$(cat ~/Switch/config/"output")/
    out3=$(cat ~/Switch/config/tmp/"path_1")/
    fi 
    cd "$out""$name"
    else
    out=$(cat ~/Switch/config/tmp/"path_1")/
    cd "$name"
    fi   
#slash
    sl=$(printf "%s\n" /)
#cut to the next name on the list
    echo "$(tail -n +2 ~/Switch/config/tmp/FFmpegab)" > ~/Switch/config/tmp/FFmpegab
#will null values if no audio
    wav2=
    sd=
#search for wav2 file
    if ls *.wav
    then
    if ! [ "$(ls *.wav |wc -c | perl -p -e 's/^[ \t]*//')" = 6 ]
    then
    wav2=$(printf "%s\n" -i *.wav)
    sd=$(printf "%s\n" -c:v copy -c:a aac)
    fi
    fi
#check if footage is HDR(tblend filter)
    if grep 'HDR\|halfhdr' ~/Switch/config/pr4444_HDR 
    then 
    tbl=$(printf "%s\n" -vf tblend=all_mode=average)
    fi
#Choose FFmpeg output(ProRes4444)
    if grep 'lincineon' ~/Switch/config/FFmpeg_settings 
    then 
#check for HDR
    if [ x"$tbl" = x ]
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat ~/Switch/config/tmp/path_2))lin_cineon.cube 
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    else
    cin=$(printf "%s\n" ,lut3d=$(cat ~/Switch/config/tmp/path_2))lin_cineon.cube 
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    fi
    elif grep 'linlogC' ~/Switch/config/FFmpeg_settings 
    then 
#check for HDR
    if [ x"$tbl" = x ]
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat ~/Switch/config/tmp/path_2))lin_logC.cube
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    else
    cin=$(printf "%s\n" ,lut3d=$(cat ~/Switch/config/tmp/path_2))lin_logC.cube
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    fi    
    elif grep 'linear' ~/Switch/config/FFmpeg_settings 
    then
    h2=$(printf "%s\n" -H 2)  
    elif grep 'rec709' ~/Switch/config/FFmpeg_settings 
    then
    h2=
    elif grep 'xyz' ~/Switch/config/FFmpeg_settings 
    then
    o=$(printf "%s\n" -o 5)
    h2=$(printf "%s\n" -H 2)
    elif grep 'aces' ~/Switch/config/FFmpeg_settings 
    then
    o=$(printf "%s\n" -o 6)
    h2=$(printf "%s\n" -H 2)
    fi
#check for additional 3D luts in ProRes4444 folder
    if ls ../"$date"_ProRes4444/*.cube
    then 
    if [ x"$cin" = x ] && [ x"$tbl" = x ]
    then 
    cin_01=$(printf "%s\n" -vf lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 3 {print; }'))
    else
    cin_01=$(printf "%s\n" ,lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#check for additional 3D luts in dng folder
    cin_01b= ; cin_02b= ; cin_03b= ; cin_01b= ; cin_02b= ; cin_03b=    
    if ls *.cube
    then 
    if [ x"$cin" = x ] && [ x"$tbl" = x ]
    then 
    cin_01b=$(printf "%s\n" -vf lut3d=$(ls ../"$date"_ProRes4444/*.cube | awk 'FNR == 1 {print; }'))
    cin_02b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 2 {print; }'))
    cin_03b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 3 {print; }'))
    else
    cin_01b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 1 {print; }'))
    cin_02b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 2 {print; }'))
    cin_03b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#Choose FFmpeg output(ProRes proxy)
    if grep 'lincineonpr' ~/Switch/config/FFmpeg_settingsPR 
    then 
    if [ x"$tbl" = x ]
    then 
#check for HDR
    cinpr=$(printf "%s\n" -vf lut3d=$(cat ~/Switch/config/tmp/path_2))lin_cineon.cube 
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    else
    cinpr=$(printf "%s\n" ,lut3d=$(cat ~/Switch/config/tmp/path_2))lin_cineon.cube 
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    fi
    elif grep 'linlogCpr' ~/Switch/config/FFmpeg_settingsPR 
    then 
    if [ x"$tbl" = x ]
    then 
#check for HDR
    cinpr=$(printf "%s\n" -vf lut3d=$(cat ~/Switch/config/tmp/path_2))lin_logC.cube
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    else
    cinpr=$(printf "%s\n" ,lut3d=$(cat ~/Switch/config/tmp/path_2))lin_logC.cube
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    fi
    elif grep 'linearpr' ~/Switch/config/FFmpeg_settingsPR 
    then
    h2pr=$(printf "%s\n" -H 2)  
    elif grep 'rec709pr' ~/Switch/config/FFmpeg_settingsPR 
    then
    h2pr=
    elif grep 'xyzpr' ~/Switch/config/FFmpeg_settingsPR 
    then
    opr=$(printf "%s\n" -o 5)
    h2pr=$(printf "%s\n" -H 2)
    elif grep 'acespr' ~/Switch/config/FFmpeg_settingsPR 
    then
    opr=$(printf "%s\n" -o 6)
    h2pr=$(printf "%s\n" -H 2)
    fi
#check for proxy or LT codec
    if grep 'Pcodec_lt' ~/Switch/config/FFmpeg_settingsPR 
    then 
    codec=$(printf "%s\n" -vcodec prores -profile:v 1)
    else
    codec=$(printf "%s\n" -vcodec prores -profile:v 0)
    fi
#check for additional 3D luts in proxy folder
    if ls ../"$date"_Proxy/*.cube
    then 
    if [ x"$cinpr" = x ] && [ x"$tbl" = x ]
    then 
    cinpr_01=$(printf "%s\n" -vf lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    else
    cinpr_01=$(printf "%s\n" ,lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#check for additional 3D luts in dng folder
    cinpr_01b= ; cinpr_02b= ; cinpr_03b= ; cinpr_01b= ; cinpr_02b= ; cinpr_03b=
    if ls *.cube
    then 
    if [ x"$cinpr" = x ] && [ x"$tbl" = x ]
    then 
    cinpr_01b=$(printf "%s\n" -vf lut3d=$(ls ../"$date"_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 2 {print; }'))
    cinpr_03b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 3 {print; }'))
    else
    cinpr_01b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 1 {print; }'))
    cinpr_02b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 2 {print; }'))
    cinpr_03b=$(printf "%s\n" ,lut3d=$(ls *.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#default white balance setting. Will apply AWB or dcrawA if selected
    wb=$(printf "%s\n" -w)
#choose auto or in cam white balance. AWB median calculations which iI use in MLP
    if grep 'AWB' ~/Switch/config/FFmpeg_settings 
    then
    vit_01a=$(dcraw -T -a -v -c *000000*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01=$(echo $vit_01a | awk '{print $1}') 
    vit_02=$(echo $vit_01a | awk '{print $2}')
    vit_03=$(echo $vit_01a | awk '{print $3}')
    vit_04=$(echo $vit_01a | awk '{print $4}')
#white balance sum
    wb=$(printf "%s\n" -r $vit_01 $vit_02 $vit_03 $vit_04)
#second wb source
    if ls *000070*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000070*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01b=$(echo $vit_01a | awk '{print $1}') 
    vit_02b=$(echo $vit_01a | awk '{print $2}')
    vit_03b=$(echo $vit_01a | awk '{print $3}')
    vit_04b=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b | bc -l)
    vit_01_r=$(echo $vit_01f/2 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b | bc -l)
    vit_02_r=$(echo $vit_02f/2 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b | bc -l)
    vit_03_r=$(echo $vit_03f/2 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b | bc -l)
    vit_04_r=$(echo $vit_04f/2 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01 $vit_02 $vit_03 $vit_04)
    fi
#third wb source
    if ls *000140*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000140*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01c=$(echo $vit_01a | awk '{print $1}') 
    vit_02c=$(echo $vit_01a | awk '{print $2}')
    vit_03c=$(echo $vit_01a | awk '{print $3}')
    vit_04c=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c | bc -l)
    vit_01_r=$(echo $vit_01f/3 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c| bc -l)
    vit_02_r=$(echo $vit_02f/3 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c | bc -l)
    vit_03_r=$(echo $vit_03f/3 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c | bc -l)
    vit_04_r=$(echo $vit_04f/3 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
#fourth wb source
    if ls *000200*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000200*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01d=$(echo $vit_01a | awk '{print $1}') 
    vit_02d=$(echo $vit_01a | awk '{print $2}')
    vit_03d=$(echo $vit_01a | awk '{print $3}')
    vit_04d=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d | bc -l)
    vit_01_r=$(echo $vit_01f/4 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d | bc -l)
    vit_02_r=$(echo $vit_02f/4 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d | bc -l)
    vit_03_r=$(echo $vit_03f/4 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d | bc -l)
    vit_04_r=$(echo $vit_04f/4 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
#fifth wb source
    if ls *000250*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000250*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01e=$(echo $vit_01a | awk '{print $1}') 
    vit_02e=$(echo $vit_01a | awk '{print $2}')
    vit_03e=$(echo $vit_01a | awk '{print $3}')
    vit_04e=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e | bc -l)
    vit_01_r=$(echo $vit_01f/5 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e | bc -l)
    vit_02_r=$(echo $vit_02f/5 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e | bc -l)
    vit_03_r=$(echo $vit_03f/5 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04 | bc -l)
    vit_04_r=$(echo $vit_04f/5 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
#sixth wb source
    if ls *000310*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000310*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01f=$(echo $vit_01a | awk '{print $1}') 
    vit_02f=$(echo $vit_01a | awk '{print $2}')
    vit_03f=$(echo $vit_01a | awk '{print $3}')
    vit_04f=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e+$vit_01f | bc -l)
    vit_01_r=$(echo $vit_01f/6 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e+$vit_02f | bc -l)
    vit_02_r=$(echo $vit_02f/6 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e+$vit_03f | bc -l)
    vit_03_r=$(echo $vit_03f/6 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04e+$vit_04f | bc -l)
    vit_04_r=$(echo $vit_04f/6 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
#seventh wb source
    if ls *000390*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000390*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01g=$(echo $vit_01a | awk '{print $1}') 
    vit_02g=$(echo $vit_01a | awk '{print $2}')
    vit_03g=$(echo $vit_01a | awk '{print $3}')
    vit_04g=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e+$vit_01f+$vit_01g | bc -l)
    vit_01_r=$(echo $vit_01f/7 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e+$vit_02f+$vit_02g | bc -l)
    vit_02_r=$(echo $vit_02f/7 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e+$vit_03f+$vit_03g | bc -l)
    vit_03_r=$(echo $vit_03f/7 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04e+$vit_04f+$vit_04g | bc -l)
    vit_04_r=$(echo $vit_04f/7 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
#eighth wb source
    if ls *000450*.{dng,DNG}
    then
    vit_01a=$(dcraw -T -a -v -c *000450*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01h=$(echo $vit_01a | awk '{print $1}') 
    vit_02h=$(echo $vit_01a | awk '{print $2}')
    vit_03h=$(echo $vit_01a | awk '{print $3}')
    vit_04h=$(echo $vit_01a | awk '{print $4}')
    vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e+$vit_01f+$vit_01g+$vit_01h | bc -l)
    vit_01_r=$(echo $vit_01f/8 | bc -l)
    vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e+$vit_02f+$vit_02g+$vit_02h | bc -l)
    vit_02_r=$(echo $vit_02f/8 | bc -l)
    vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e+$vit_03f+$vit_03g+$vit_03h | bc -l)
    vit_03_r=$(echo $vit_03f/8 | bc -l)
    vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04e+$vit_04f+$vit_04g+$vit_04h | bc -l)
    vit_04_r=$(echo $vit_04f/8 | bc -l)
#white balance sum
    wb=$(printf "%s\n" -r $vit_01_r $vit_02_r $vit_03_r $vit_04_r)
    fi
    fi
#dcraw white balance
    if grep 'dcrawA' ~/Switch/config/FFmpeg_settings 
    then
    wb=$(printf "%s\n" -a)
    fi
#alter white level
    if [ -f ~/Switch/config/FFmpeg_white_level ] 
    then  
    S=$(printf "%s\n" -S $(cat ~/Switch/config/FFmpeg_white_level))
    fi  
#pixel fix script created by dfort  
    if ls allbadpixels.map 
    then
    cat "$out""$date"_ProRes4444/allbadpixels.map >> allbadpixels.map
    pix=$(printf "%s\n" -P allbadpixels.map)
    fi
#check for scale changes(prores4444)
    if ! [ x$(cat ~/Switch/config/_X_pres_SCALE) = x ]
    then
    if [ x"$cin""$cin_01" = x ]
    then
    scale=$(printf "%s\n" -vf scale=$(cat ~/Switch/config/_X_pres_SCALE))
    else
    scale=$(printf "%s\n" ,scale=$(cat ~/Switch/config/_X_pres_SCALE))
    fi
    fi
#check for scale changes(proxy)
    if ! [ x$(cat ~/Switch/config/prox_SCALE) = x ]
    then
    if [ x"$cinpr""$cinpr_01" = x ]
    then
    scalePR=$(printf "%s\n" -vf scale=$(cat ~/Switch/config/prox_SCALE))
    else
    scalePR=$(printf "%s\n" ,scale=$(cat ~/Switch/config/prox_SCALE))
    fi
    fi
#check for denoising settings(prores)
    if ! [ x$(cat ~/Switch/config/denoise) = x ]
    then
    if [ x"$cin""$cin_01""$scale" = x ]
    then
    denoise=$(printf "%s\n" -vf $(cat ~/Switch/config/denoise))
    else
    denoise=$(printf "%s\n" ,$(cat ~/Switch/config/denoise))
    fi
    fi
#check for denoising settings(proxy)
    if ! [ x$(cat ~/Switch/config/denoise) = x ]
    then
    if [ x"$cinpr""$cinpr_01""$scalePR" = x ]
    then
    denoisePR=$(printf "%s\n" -vf $(cat ~/Switch/config/denoise))
    else
    denoisePR=$(printf "%s\n" ,$(cat ~/Switch/config/denoise))
    fi
    fi
#check for sharpen settings(prores)
    if ! [ x$(cat ~/Switch/config/sharpen) = x ]
    then
    if [ x"$cin""$cin_01""$scale""$denoise" = x ]
    then
    sharpen=$(printf "%s\n" -vf $(cat ~/Switch/config/sharpen))
    else
    sharpen=$(printf "%s\n" ,$(cat ~/Switch/config/sharpen))
    fi
    fi
#check for sharpen settings(proxy)
    if ! [ x$(cat ~/Switch/config/sharpen) = x ]
    then
    if [ x"$cinpr""$cinpr_01""$scalePR""$denoisePR" = x ]
    then
    sharpenPR=$(printf "%s\n" -vf $(cat ~/Switch/config/sharpen))
    else
    sharpenPR=$(printf "%s\n" ,$(cat ~/Switch/config/sharpen))
    fi
    fi
#grab correct frames per second
    fps=$(exiftool *000000*.{dng,DNG} | awk '/Frame Rate/ { print $4; exit }')
#check if ProRes4444 settings file contains information 
    if ! [ x"$(cat ~/Switch/config/FFmpeg_settings | grep -v 'AWB\|dcrawA')" = x ]
    then
    mkdir -p "$out""$out2""$date"_ProRes4444
#potential HDR settings
    if grep -q 'halfhdr' ~/Switch/config/pr4444_HDR && grep -q 'HDR' ~/Switch/config/pr4444_HDR && ! [ x"$tbl" = x ]
    then
#export ProRes4444
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W -q 3 $gam $wb $pix $br | ffmpeg -loglevel warning $wav2 -f image2pipe -vcodec ppm -r $fps -i pipe:0 $sd -vcodec prores_ks -pix_fmt yuv444p10 -n -r $(echo $fps / 2 | bc -l) $tbl$cin$cin_01$cin_02$cin_03$cin_01b$cin_02b$cin_03b$scale$denoise$sharpen "$out""$out2""$date"_ProRes4444/"$name".mov 
    else
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W -q 3 $gam $wb $pix $br | ffmpeg -loglevel warning $wav2 -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd -vcodec prores_ks -pix_fmt yuv444p10 -n -r "$fps" $tbl$cin$cin_01$cin_02$cin_03$cin_01b$cin_02b$cin_03b$scale$denoise$sharpen "$out""$out2""$date"_ProRes4444/"$name".mov
    fi
    fi
#check if proxy settings file contains information 
    if ! [ x"$(cat ~/Switch/config/FFmpeg_settingsPR | grep -v 'AWB\|dcrawA\|Pcodec_lt')" = x ]
    then
    mkdir -p "$out""$out2""$date"_Proxy
#potential HDR settings
    if grep -q 'halfhdr' ~/Switch/config/pr4444_HDR && grep -q 'HDR' ~/Switch/config/pr4444_HDR && ! [ x"$tbl" = x ]
    then
#export ProRes proxy
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb $pix $br | ffmpeg -loglevel warning $wav2 -f image2pipe -vcodec ppm -r $fps -i pipe:0 $sd $codec -n -r $(echo $fps / 2 | bc -l) $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$cinpr_01b$cinpr_02b$cinpr_03b$scalePR$denoisePR$sharpenPR "$out""$out2""$date"_Proxy/"$name".mov 
    else
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb $pix $br | ffmpeg -loglevel warning $wav2 -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd $codec -n -r "$fps" $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$cinpr_01b$cinpr_02b$cinpr_03b$scalePR$denoisePR$sharpenPR "$out""$out2""$date"_Proxy/"$name".mov
    fi
    fi
    cd ..
    done
