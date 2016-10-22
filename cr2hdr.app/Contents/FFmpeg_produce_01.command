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
#choose auto or in cam white balance
    if grep 'AWB' /tmp/FFmpeg_settings 
    then
    wb=$(printf "%s\n" -a)
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
    if ! [ x"$(cat /tmp/FFmpeg_settings)" = x ]
    then
    mkdir -p ../$(date +%F)_ProRes4444
#export ProRes4444
    find . -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2 $o $S -c -6 -W -q 3 $gam $wb | ffmpeg $wav -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd -vcodec prores_ks -pix_fmt yuv444p10 -n -r "$fps" $cin ../$(date +%F)_ProRes4444/"$name".mov 
    fi
#check if proxy settings file contains information 
    if ! [ x"$(cat /tmp/FFmpeg_settingsPR)" = x ]
    then
    mkdir -p ../$(date +%F)_Proxy
#export ProRes proxy
    find . -maxdepth 1 -iname '*.dng' -print0 | xargs -0 dcraw +M $h2pr $opr $S -c -6 -W -q 3 $gampr $wb | ffmpeg $wav -f image2pipe -vcodec ppm -r "$fps" -i pipe:0 $sd -vcodec prores -profile 0 -n -r "$fps" $cinpr ../$(date +%F)_Proxy/"$name".mov
    fi
    cd ..
    done
