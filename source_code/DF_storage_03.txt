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

#print out trap note 3
    echo > /tmp/DUALISO/DF_TRAP3
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi
    while ! [ x"$(cat /tmp/DUALISO/DF_storageac)" = x ]
    do 
#get the file
    FILE_03="$(cat /tmp/DUALISO/DF_storageac | head -1)"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/DF_storageac)" > /tmp/DUALISO/DF_storageac
#snatch necessary matching features
#let´s check for lossless files
  if grep '0x00000021' <<< $($mlv_dump -v "$FILE_03" | awk '/Class Video/ { print $4; exit }')
    then
    white=$($mlv_dump -v "$FILE_03" | awk '/white_level/ { print $2; exit }')
    if (( $white > 14500 ))
    then 
    bit_03=$(echo 14L)
    elif (( $white < 14500 && $white > 4000 ))
    then 
    bit_03=$(echo 12L)
    elif (( $white < 4000 && $white > 3000 ))
    then 
    bit_03=$(echo 11L)
    elif (( $white < 3000 && $white > 2600 ))
    then 
    bit_03=$(echo 10L)
    elif (( $white < 2600 && $white > 2300 ))
    then 
    bit_03=$(echo 9L)
    fi
  else
    bit_03=$($mlv_dump -v "$FILE_01" | awk '/bits_per_pixel/ { print $2; exit }')
  fi
    res_03=$($mlv_dump -v "$FILE_03" | awk '/Res/ { print $2; exit }')
    iso_03=$($mlv_dump -v "$FILE_03" | awk '/ISO:/ { print $2; exit }')
    fra_03=$($mlv_dump -v "$FILE_03" | awk '/FPS/ { print $3; exit }')
    cn_03=$($mlv_dump -v "$FILE_03" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
#Do criterias match?
    if ls "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_03"bit_"$cn_03"_res_"$res_03"_iso_"$iso_03"_fps_"$fra_03".MLV
    then
    $mlv_dump -o a_"$FILE_03" -s "$(cat /tmp/DARK_FOLDER)"/avg_"$bit_03"bit_"$cn_03"_res_"$res_03"_iso_"$iso_03"_fps_"$fra_03".MLV "$FILE_03"
    rm *MLV.wav
    mv "$FILE_03" A_ORIGINALS
    mv  "$(echo "$FILE_03" | cut -d "." -f1)".M* A_ORIGINALS
    fi
    done
#remove trap
rm /tmp/DUALISO/DF_TRAP3






