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
#export to different flavours of prores through FFmpeg and dcraw
    while grep -q 'C0000' /tmp/DUALISO/FFmpeg
    do 
#output name then enter the folder and then tail the list to next folder
    name=$(cat /tmp/DUALISO/"FFmpeg" | head -1)
    cd "$name"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/FFmpeg)" > /tmp/DUALISO/FFmpeg
#will null values if no audio
    wav=
    sd=
#search for wav file
    if ls *.wav 
    then
    wav=$(printf "%s\n" -i *.wav)
    sd=$(printf "%s\n" -c:v copy -c:a aac)
    fi
#Choose FFmpeg output(ProRes4444)
    if grep 'lincineon' /tmp/FFmpeg_settings 
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
    elif grep 'linlogC' /tmp/FFmpeg_settings 
    then 
    cin=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gam=$(printf "%s\n" -g 1 1)
    h2=$(printf "%s\n" -H 2)
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
#check for additional 3D luts in ProRes4444 folder
    if ls ../$(date +%F)_ProRes4444/*.cube
    then 
    if [ x"$cin" = x ]
    then 
    cin_01=$(printf "%s\n" -vf lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    else
    cin_01=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cin_02=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cin_03=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#Choose FFmpeg output(ProRes proxy)
    if grep 'lincineonpr' /tmp/FFmpeg_settingsPR 
    then 
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_cineon.cube 
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
    elif grep 'linlogCpr' /tmp/FFmpeg_settingsPR 
    then 
    cinpr=$(printf "%s\n" -vf lut3d=$(cat /tmp/DUALISO/path_2))lin_logC.cube
    gampr=$(printf "%s\n" -g 1 1)
    h2pr=$(printf "%s\n" -H 2)
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
#check for additional 3D luts in proxy folder
    if ls ../$(date +%F)_Proxy/*.cube
    then 
    if [ x"$cinpr" = x ]
    then 
    cinpr_01=$(printf "%s\n" -vf lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    else
    cinpr_01=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 1 {print; }'))
    cinpr_02=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 2 {print; }'))
    cinpr_03=$(printf "%s\n" ,lut3d=$(ls ../$(date +%F)_Proxy/*.cube | awk 'FNR == 3 {print; }'))
    fi  
    fi
#choose auto or in cam white balance. AWB median calculations which iI use in MLP
    if grep 'AWB' /tmp/FFmpeg_settings 
    then
    vit_01a=$(dcraw -T -a -v -c *000000.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
    vit_01=$(echo $vit_01a | awk '{print $1}') 
    vit_02=$(echo $vit_01a | awk '{print $2}')
    vit_03=$(echo $vit_01a | awk '{print $3}')
    vit_04=$(echo $vit_01a | awk '{print $4}')
#white balance sum
    wb=$(printf "%s\n" -r $vit_01 $vit_02 $vit_03 $vit_04)
#second wb source
    if ls *000070.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000070.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000140.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000140.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000200.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000200.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000250.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000250.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000310.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000310.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000390.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000390.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    if ls *000450.dng
    then
    vit_01a=$(dcraw -T -a -v -c *000450.dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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
    else
    wb=$(printf "%s\n" -w)
    fi 
#alter white level to 16383
    if grep 'HL' /tmp/FFmpeg_settings 
    then  
    S=$(printf "%s\n" -S 16383)
    fi  
#grab correct frames per second
    fps=$(exiftool *000000.{dng,DNG} | awk '/Frame Rate/ { print $4; exit }')
#check if ProRes4444 settings file contains information 
    if ! [ x"$(cat /tmp/FFmpeg_settings | grep -v 'HL\|AWB')" = x ]
    then
    mkdir -p ../$(date +%F)_ProRes4444
#export ProRes4444
    find . -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W -q 3 $gam $wb | ffmpeg $wav -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd -vcodec prores_ks -pix_fmt yuv444p10 -n -r "$fps" $cin$cin_01$cin_02$cin_03 ../$(date +%F)_ProRes4444/"$name".mov
    fi
#check if proxy settings file contains information 
    if ! [ x"$(cat /tmp/FFmpeg_settingsPR | grep -v 'HL\|AWB')" = x ]
    then
    mkdir -p ../$(date +%F)_Proxy
#export ProRes proxy
    find . -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb | ffmpeg $wav -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd -vcodec prores -profile 0 -n -r "$fps" $cinpr$cinpr_01$cinpr_02$cinpr_03 ../$(date +%F)_Proxy/"$name".mov
    fi
    cd ..
    done
