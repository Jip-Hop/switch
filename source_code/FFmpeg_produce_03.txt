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
    OLDIFS=$IFS
    IFS=$'\n'
#print out trap note 3
echo 3trap >> /tmp/DUALISO/prores_TRAP
#glue date
    date=$(date +%F)
#export to different flavours of prores through FFmpeg and dcraw
    while grep -q 'C0000' /tmp/DUALISO/FFmpeg
    do 
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
#establish output location
    if ls /tmp/output
    then
#output name
    out=$(cat /tmp/"output")/
#safety check new folder location(root)
    if ! ls -d "$out""$name" 
    then
    out= 
    out2=$(cat /tmp/"output")/
    out3=$(cat /tmp/DUALISO/"path_1")/
    fi 
    cd "$out""$name"
    else
    out=$(cat /tmp/DUALISO/"path_1")/
    cd "$name"
    fi   
#slash
    sl=$(printf "%s\n" /)
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/FFmpeg)" > /tmp/DUALISO/FFmpeg
#will null values if no audio
    wav3=
    sd=
#search for wav3 file
    if ls *.wav 
    then
    if ! [ "$(ls *.wav |wc -c | perl -p -e 's/^[ \t]*//')" = 6 ]
    then
    wav3=$(printf "%s\n" -i *.wav)
    sd=$(printf "%s\n" -c:v copy -c:a aac)
    fi
    fi
#check if footage is HDR(tblend filter)
    if grep 'HDR\|halfhdr' /tmp/pr4444_HDR 
    then 
    tbl=$(printf "%s\n" -vf tblend=all_mode=average)
#safety check if HDR or not
    A=$(dcraw -d -W -c *000024.dng | convert -resize 10% - 2>/dev/null -colorspace hsb -resize 1x1 txt:- | grep '%' | cut -d "%" -f3 | tr -d ',')
    B=$(dcraw -d -W -c *000025.dng | convert -resize 10% - 2>/dev/null -colorspace hsb -resize 1x1 txt:- | grep '%' | cut -d "%" -f3 | tr -d ',') 
    numb=$(echo $A - $B | bc -l)
    if (( $(echo "$numb < 5" |bc -l) )) && (( $(echo "$numb > -5" |bc -l) )) ; then
    tbl=
    fi
    fi
#Choose FFmpeg output(ProRes4444)
    if grep 'lincineon' /tmp/FFmpeg_settings 
    then 
#check for HDR
    if [ x"$tbl" = x ]
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    else
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    fi
    elif grep 'linlogC' /tmp/FFmpeg_settings 
    then 
#check for HDR
    if [ x"$tbl" = x ]
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    else
    cin=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    fi    
    elif grep 'linear' /tmp/FFmpeg_settings 
    then
    h2=$(printf "%s\n" -H 2)  
    elif grep 'rec709' /tmp/FFmpeg_settings 
    then
    h2=
    elif grep 'xyz' /tmp/FFmpeg_settings 
    then
    o=$(printf "%s\n" -o 5)
    h2=$(printf "%s\n" -H 2)
    elif grep 'aces' /tmp/FFmpeg_settings 
    then
    o=$(printf "%s\n" -o 6)
    h2=$(printf "%s\n" -H 2)
    fi
#check for alternate codec
    Pcodec=$(printf "%s\n" -vcodec prores_ks -pix_fmt yuv444p10)
    if grep 'qual0' /tmp/FFmpeg_settings
    then
    qual=$(printf "%s\n" -q 0)
    else
    qual=$(printf "%s\n" -q 3)
    fi
    cc=$(cat /tmp/FFmpeg_settings | grep 'x264a\|x264b\|prores_422') 
    if [ "$cc" = x264a ]; 
    then 
    Pcodec=$(printf "%s\n" -c:v libx264 -preset ultrafast -crf 10)
    ext=$(echo mp4)
    elif [ "$cc" = x264b ]; 
    then 
    Pcodec=$(printf "%s\n" -c:v libx264 -preset ultrafast -crf 0)
    ext=$(echo mp4)
    elif [ "$cc" = prores_422 ]; 
    then 
    Pcodec=$(printf "%s\n" -vcodec prores -pix_fmt yuv422p10le)
    ext=$(echo mov)   
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
    if grep 'lincineonpr' /tmp/FFmpeg_settingsPR 
    then 
    if [ x"$tbl" = x ]
    then 
#check for HDR
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    else
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    fi
    elif grep 'linlogCpr' /tmp/FFmpeg_settingsPR 
    then 
    if [ x"$tbl" = x ]
    then 
#check for HDR
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    else
    cinpr=$(printf "%s\n" ,lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    fi
    elif grep 'linearpr' /tmp/FFmpeg_settingsPR 
    then
    h2pr=$(printf "%s\n" -H 2)  
    elif grep 'rec709pr' /tmp/FFmpeg_settingsPR 
    then
    h2pr=
    elif grep 'xyzpr' /tmp/FFmpeg_settingsPR 
    then
    opr=$(printf "%s\n" -o 5)
    h2pr=$(printf "%s\n" -H 2)
    elif grep 'acespr' /tmp/FFmpeg_settingsPR 
    then
    opr=$(printf "%s\n" -o 6)
    h2pr=$(printf "%s\n" -H 2)
    fi
#check for proxy or LT codec
    if grep 'Pcodec_lt' /tmp/FFmpeg_settingsPR 
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
    if grep 'AWB' /tmp/FFmpeg_settings 
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
    if grep 'dcrawA' /tmp/FFmpeg_settings 
    then
    wb=$(printf "%s\n" -a)
    fi
#alter white level
    if [ -f /tmp/FFmpeg_white_level ] 
    then  
    S=$(printf "%s\n" -S $(cat /tmp/FFmpeg_white_level))
    fi  
#check for extra picked pixels
    pix=    
    if ls "$out""$date"_ProRes4444/*.txt
    then
    tail -n +2 "$out""$date"_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out""$date"_ProRes4444/allbadpixels.map
    rm "$out""$date"_ProRes4444/*.txt
    fi
    if ls "$out""$date"_ProRes4444/*.xls
    then
    mv "$out""$date"_ProRes4444/*.xls "$out""$date"_ProRes4444/allbadpixels.txt
    tail -n +2 "$out""$date"_ProRes4444/*.txt | awk '{print $2,"	 "$3"	 0"}' >> "$out""$date"_ProRes4444/allbadpixels.map
    rm "$out""$date"_ProRes4444/*.txt
    fi
#check for ready made pixel pick list 
    if ls "$out""$date"_ProRes4444/allbadpixels.map
    then
    pix=$(printf "%s\n" -P "$out""$date"_ProRes4444/allbadpixels.map)
    fi
#pixel fix script created by dfort  
    if ls allbadpixels.map 
    then
    cat "$out""$date"_ProRes4444/allbadpixels.map >> allbadpixels.map
    pix=$(printf "%s\n" -P allbadpixels.map)
    fi
#check for scale changes(prores4444)
    if ! [ x$(cat /tmp/_X_pres_SCALE) = x ]
    then
    if [ x"$cin""$cin_01" = x ]
    then
    scale=$(printf "%s\n" -vf scale=$(cat /tmp/_X_pres_SCALE))
    else
    scale=$(printf "%s\n" ,scale=$(cat /tmp/_X_pres_SCALE))
    fi
    fi
#check for scale changes(proxy)
    if ! [ x$(cat /tmp/prox_SCALE) = x ]
    then
    if [ x"$cinpr""$cinpr_01" = x ]
    then
    scalePR=$(printf "%s\n" -vf scale=$(cat /tmp/prox_SCALE))
    else
    scalePR=$(printf "%s\n" ,scale=$(cat /tmp/prox_SCALE))
    fi
    fi
#check for denoising settings(prores)
    if ! [ x$(cat /tmp/denoise) = x ]
    then
    if [ x"$cin""$cin_01""$scale" = x ]
    then
    denoise=$(printf "%s\n" -vf $(cat /tmp/denoise))
    else
    denoise=$(printf "%s\n" ,$(cat /tmp/denoise))
    fi
    fi
#check for denoising settings(proxy)
    if ! [ x$(cat /tmp/denoise) = x ]
    then
    if [ x"$cinpr""$cinpr_01""$scalePR" = x ]
    then
    denoisePR=$(printf "%s\n" -vf $(cat /tmp/denoise))
    else
    denoisePR=$(printf "%s\n" ,$(cat /tmp/denoise))
    fi
    fi
#check for sharpen settings(prores)
    if ! [ x$(cat /tmp/sharpen) = x ]
    then
    if [ x"$cin""$cin_01""$scale""$denoise" = x ]
    then
    sharpen=$(printf "%s\n" -vf $(cat /tmp/sharpen))
    else
    sharpen=$(printf "%s\n" ,$(cat /tmp/sharpen))
    fi
    fi
#check for sharpen settings(proxy)
    if ! [ x$(cat /tmp/sharpen) = x ]
    then
    if [ x"$cinpr""$cinpr_01""$scalePR""$denoisePR" = x ]
    then
    sharpenPR=$(printf "%s\n" -vf $(cat /tmp/sharpen))
    else
    sharpenPR=$(printf "%s\n" ,$(cat /tmp/sharpen))
    fi
    fi
#brightness settings dcraw
    if ls /tmp/DUALISO/BRIGHTER
    then
    br=$(printf "%s\n" -b "$(cat /tmp/DUALISO/BRIGHTER)")
    fi
#check for AE template 
    if ! grep 'AE_template\|AE_temp_HDR' /tmp/FFmpeg_settings
    then
#grab correct frames per second
    fps=$(exiftool *000000*.{dng,DNG} | awk '/Frame Rate/ { print $4; exit }')
#check for tif spitter
    if ! ls /tmp/DUALISO/tif_spit 
    then
#check if ProRes4444 settings file contains information 
    if ! [ x"$(cat /tmp/FFmpeg_settings | grep -v 'AWB\|dcrawA')" = x ]
    then
    mkdir -p "$out""$out2""$date"_ProRes4444
#potential HDR settings
    if grep -q 'halfhdr' /tmp/pr4444_HDR && grep -q 'HDR' /tmp/pr4444_HDR && ! [ x"$tbl" = x ]
    then
#export ProRes4444
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W $qual $gam $wb $pix $br | ffmpeg -loglevel warning $wav3 -f image2pipe -vcodec ppm -r $fps -i pipe:0 $sd $Pcodec -n -r $(echo $fps / 2 | bc -l) $tbl$cin$cin_01$cin_02$cin_03$cin_01b$cin_02b$cin_03b$scale$denoise$sharpen "$out""$out2""$date"_ProRes4444/"$name".$ext 
    else
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W $qual $gam $wb $pix $br | ffmpeg -loglevel warning $wav3 -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd $Pcodec -n -r "$fps" $tbl$cin$cin_01$cin_02$cin_03$cin_01b$cin_02b$cin_03b$scale$denoise$sharpen "$out""$out2""$date"_ProRes4444/"$name".$ext
    fi
    fi
#check if proxy settings file contains information 
    if ! [ x"$(cat /tmp/ffmpeg_settingsPR | grep -v 'AWB\|dcrawA\|Pcodec_lt')" = x ]
    then
    mkdir -p "$out""$out2""$date"_Proxy
#potential HDR settings
    if grep -q 'halfhdr' /tmp/pr4444_HDR && grep -q 'HDR' /tmp/pr4444_HDR && ! [ x"$tbl" = x ]
    then
#export ProRes proxy
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb $pix $br | ffmpeg -loglevel warning $wav3 -f image2pipe -vcodec ppm -r $fps -i pipe:0 $sd $codec -n -r $(echo $fps / 2 | bc -l) $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$cinpr_01b$cinpr_02b$cinpr_03b$scalePR$denoisePR$sharpenPR "$out""$out2""$date"_Proxy/"$name".mov 
    else
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb $pix $br | ffmpeg -loglevel warning $wav3 -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd $codec -n -r "$fps" $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$cinpr_01b$cinpr_02b$cinpr_03b$scalePR$denoisePR$sharpenPR "$out""$out2""$date"_Proxy/"$name".mov
    fi
    fi
    else
#tif spitter
#check if ProRes4444 settings file contains information 
    if ! [ x"$(cat /tmp/FFmpeg_settings | grep -v 'AWB\|dcrawA')" = x ]
    then
    mkdir -p "$out""$out2""$date"_ProRes4444
        find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W -q 3 $gam $wb $pix $br | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 $tbl$cin$cin_01$cin_02$cin_03$denoise$sharpen -t 1 "$out""$out2""$date"_ProRes4444/"$name".tif 2> /tmp/what
    fi
#check if proxy settings file contains information
    if ! [ x"$(cat /tmp/FFmpeg_settingsPR | grep -v 'AWB\|dcrawA')" = x ]
    then
    mkdir -p "$out""$out2""$date"_Proxy
    find "$out""$out3""$name""$sl". -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb $pix $br | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 $tbl$cinpr$cinpr_01$cinpr_02$cinpr_03$denoisePR$sharpenPR -t 1 "$out""$out2""$date"_Proxy/"$name".tif
    fi
    fi
    else
#Will create an identity project file for AE
#Reset file if needed
if ! grep 'any_X' "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep
then
perl -pi -e 's/'"$(LC_ALL=C cat -v "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep | tr ' ' '\n' | grep -o -m 1 '[^ ]*C0000')"'/any_X/g' "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep
fi
#folder output
    mkdir -p "$out""$out2""$date"_ProRes4444
#if no dng folders exists change folder path
    if ls /tmp/output
    then
    mkdir -p $(cat /tmp/"output")
    if ! ls -d "$(cat /tmp/DUALISO/"path_1")"/*C0000
    then 
    cp -n "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep $(cat /tmp/"output")/"$date"_ProRes4444
    cat /tmp/"output" > /tmp/DUALISO/"path_1"
    fi
    fi
#AE root folder
    mkdir -p "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444
    if grep 'CC' <<< $(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)")
    then
    numb=$(echo "$(cat /tmp/DUALISO/AErenderPATH | head -1)" | awk 'FNR == 1 {print $5; }')
    if (( $(echo "$numb > 2015.2" |bc -l) )); 
    then
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_templateCC.aep "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444
    fi
    else
    cp -n "$(cat /tmp/DUALISO/"path_2")"bin/AE_prores_template.aep "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444
    fi
    cp "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/AE_prores_template.aep ./
    find AE_prores_template.aep | xargs perl -pi -e 's/any_X/'"$name"'/g'
#if added an xmp file
    if ls "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/*.xmp
    then
    if grep 'MLVFS' <<< $(exiftool "$name"_000000.dng | awk '/Software/ { print $3; exit }')
    then
    rm *.xmp
    cp "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/*.xmp "$name"_000000.xmp
    else
    exiftool -tagsfromfile "$(cat /tmp/DUALISO/"path_1")"/"$date"_ProRes4444/*.xmp -all:all "$name"_000000.dng -overwrite_original
    fi
    fi
#creating a dummy audio file if not present
    if ! ls "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    then
    ffmpeg -t 1 -f s16le -acodec pcm_s16le -ac 2 -i /dev/zero -acodec copy "$(cat /tmp/DUALISO/"path_1")"/"$name"/"$name".wav
    fi
#trap file
    echo > tmp 
    if grep 'AE_temp_HDR' /tmp/FFmpeg_settings
    then
    "$(cd "$(cat /tmp/DUALISO/AErenderPATH | head -1)" ; find "$(pwd)" -name "aerender")" -comp "$name" -output "$out""$out2""$date"_ProRes4444/"$name".mov -e "$(echo $(find . -iname '*.dng' | wc -l) / 2 - 1 | bc)" -project "$(cat /tmp/DUALISO/"path_1")"/"$name"/AE_prores_template.aep
    else
    "$(cd "$(cat /tmp/DUALISO/AErenderPATH | head -1)" ; find "$(pwd)" -name "aerender")" -comp "$name" -output "$out""$out2""$date"_ProRes4444/"$name".mov -e "$(echo $(find . -iname '*.dng' | wc -l) - 1 | bc)" -project "$(cat /tmp/DUALISO/"path_1")"/"$name"/AE_prores_template.aep 
    fi
    rm tmp
    rm *.aep
    find . -name '*.aep Logs' -type d -exec rm -r {} \;
    fi
#deletion of dng folders to save space
    if [ -f /tmp/DUALISO/DEL_DNG ]
    then
    rm -r "$out""$out3""$name"
    fi
    cd ..
    done
    OLDIFS=$IFS
#remove trap
find /tmp/DUALISO/prores_TRAP | xargs perl -pi -e 's/3trap//g'
