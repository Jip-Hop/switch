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

#print out trap note 2
    echo > /tmp/DUALISO/DF_TRAP2
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
    while ! [ x"$(cat /tmp/DUALISO/DF_storageab)" = x ]
    do 
#get the file
    FILE_02="$(cat /tmp/DUALISO/DF_storageab | head -1)"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/DF_storageab)" > /tmp/DUALISO/DF_storageab
#snatch necessary matching features
#let´s check for lossless files
    if grep '0x00000021' <<< $($mlv_dump -v "$FILE_02" | awk '/Class Video/ { print $4; exit }')
    then
    if grep '55' <<< $($mlv_dump -v "$FILE_02" | awk '/white_level/ { print $2; exit }')
    then
    bit_02=$(echo 12L)
    else
    if grep '16\|15\|14' <<< $($mlv_dump -v "$FILE_02" | awk '/white_level/ { print $2; exit }')
    then
    bit_02=$(echo 14L)
    else
    if grep '24' <<< $($mlv_dump -v "$FILE_02" | awk '/white_level/ { print $2; exit }')
    then
    bit_02=$(echo 9L)
    else
    if grep '29' <<< $($mlv_dump -v "$FILE_02" | awk '/white_level/ { print $2; exit }')
    then
    bit_02=$(echo 10L)
    else
    if grep '38' <<< $($mlv_dump -v "$FILE_02" | awk '/white_level/ { print $2; exit }')
    then
    bit_02=$(echo 11L)
    else
    bit_02=$(echo 8L)
    fi
    fi
    fi
    fi
    fi 
    else
    bit_02=$($mlv_dump -v "$FILE_02" | awk '/bits_per_pixel/ { print $2; exit }')
    fi
    res_02=$($mlv_dump -v "$FILE_02" | awk '/Res/ { print $2; exit }')
    iso_02=$($mlv_dump -v "$FILE_02" | awk '/ISO:/ { print $2; exit }')
    fra_02=$($mlv_dump -v "$FILE_02" | awk '/FPS/ { print $3; exit }')
    cn_02=$($mlv_dump -v "$FILE_02" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
#Do criterias match?
    if ls "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_02"bit_"$cn_02"_res_"$res_02"_iso_"$iso_02"_fps_"$fra_02".MLV
    then
    $mlv_dump -o a_"$FILE_02" -s "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_02"bit_"$cn_02"_res_"$res_02"_iso_"$iso_02"_fps_"$fra_02".MLV "$FILE_02"
    rm *MLV.wav
    mv "$FILE_02" A_ORIGINALS
    mv  "$(echo "$FILE_02" | cut -d "." -f1)".M* A_ORIGINALS
    fi
    done
#remove trap
rm /tmp/DUALISO/DF_TRAP2







