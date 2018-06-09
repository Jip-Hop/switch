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

#print out trap note 4
    echo > /tmp/DUALISO/DF_TRAP4
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
    while ! [ x"$(cat /tmp/DUALISO/DF_storagead)" = x ]
    do 
#get the file
    FILE_04="$(cat /tmp/DUALISO/DF_storagead | head -1)"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/DF_storagead)" > /tmp/DUALISO/DF_storagead
#snatch necessary matching features
#let´s check for lossless files
  if grep '0x00000021' <<< $($mlv_dump -v "$FILE_04" | awk '/Class Video/ { print $4; exit }')
    then
    white=$($mlv_dump -v "$FILE_04" | awk '/white_level/ { print $2; exit }')
    if (( $white > 14500 ))
    then 
    bit_04=$(echo 14L)
    elif (( $white < 14500 && $white > 4000 ))
    then 
    bit_04=$(echo 12L)
    elif (( $white < 4000 && $white > 3000 ))
    then 
    bit_04=$(echo 11L)
    elif (( $white < 3000 && $white > 2600 ))
    then 
    bit_04=$(echo 10L)
    elif (( $white < 2600 && $white > 2300 ))
    then 
    bit_04=$(echo 9L)
    fi
  else
    bit_04=$($mlv_dump -v "$FILE_04" | awk '/bits_per_pixel/ { print $2; exit }')
  fi
    res_04=$($mlv_dump -v "$FILE_04" | awk '/Res/ { print $2; exit }')
    iso_04=$($mlv_dump -v "$FILE_04" | awk '/ISO:/ { print $2; exit }')
    fra_04=$($mlv_dump -v "$FILE_04" | awk '/FPS/ { print $3; exit }')
    cn_04=$($mlv_dump -v "$FILE_04" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
#Do criterias match?
    if ls "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_04"bit_"$cn_04"_res_"$res_04"_iso_"$iso_04"_fps_"$fra_04".MLV
    then
    $mlv_dump -o a_"$FILE_04" -s "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_04"bit_"$cn_04"_res_"$res_04"_iso_"$iso_04"_fps_"$fra_04".MLV "$FILE_04"
    rm *MLV.wav
    mv "$FILE_04" A_ORIGINALS
    mv  "$(echo "$FILE_04" | cut -d "." -f1)".M* A_ORIGINALS
    fi
    done
#remove trap
rm /tmp/DUALISO/DF_TRAP4






