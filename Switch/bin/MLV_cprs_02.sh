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

    if [ -f ~/Switch/config/tmp/MLV_dcmrs ]
    then
    set=$(printf "%s\n" -d)
    else
    set=$(printf "%s\n" -c)
    fi
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi

    while ! [ x"$(cat ~/Switch/config/tmp/MLV_cprsab)" = x ]
    do 
    FILE_02="$(cat ~/Switch/config/tmp/MLV_cprsab | head -1)"
#cut to the next name on the list
    echo "$(tail -n +2 ~/Switch/config/tmp/MLV_cprsab)" > ~/Switch/config/tmp/MLV_cprsab
#run MLV compressing
    if [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    $mlv_dump $set -o "$(cat ~/Switch/config/tmp/MLV_cprs_output)"/tmp_"$FILE_02" "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_02"
    else
    $mlv_dump $set -o tmp_"$FILE_02" "$FILE_02"
    fi
#decompress or not
    if ! [ -f ~/Switch/config/tmp/MLV_dcmrs ]
    then
#delete or not
    if ! [ -f ~/Switch/config/tmp/MLV_cprs_del ]
    then
    if ! [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    mv -i "$FILE_02" A_ORIGINALS
    mv -i  "$(echo "$FILE_02" | cut -d "." -f1)".M* A_ORIGINALS
    fi
    else 
    rm "$FILE_02"
    fi
#if changed output
    if [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    mv -i "$(cat ~/Switch/config/tmp/MLV_cprs_output)"/tmp_"$FILE_02" "$(cat ~/Switch/config/tmp/MLV_cprs_output)"/"$FILE_02"
    else
    mv -i tmp_"$FILE_02" "$FILE_02"
    fi
    fi

#decompress or not
    if [ -f ~/Switch/config/tmp/MLV_dcmrs ]
    then
    mkdir -p A_COMPRESSED
#delete or not
    if ! [ -f ~/Switch/config/tmp/MLV_cprs_del ]
    then
    if ! [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    mv -i "$FILE_02" A_COMPRESSED
    mv -i "$(echo "$FILE_02" | cut -d "." -f1)".M* A_COMPRESSED
    fi
    else
    rm "$FILE_02"
    fi
#if changed output
    if [ -f ~/Switch/config/tmp/MLV_cprs_output ]
    then
    mv -i "$(cat ~/Switch/config/tmp/MLV_cprs_output)"/tmp_"$FILE_02" "$(cat ~/Switch/config/tmp/MLV_cprs_output)"/"$FILE_02"
    else
    mv -i tmp_"$FILE_02" "$FILE_02"
    fi
    fi
#list check
    echo "$(tail -n +2 ~/Switch/config/tmp/MLV_cprs)" > ~/Switch/config/tmp/MLV_cprs
    done







