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

    mkdir -p A_ORIGINALS

    if ls /tmp/DUALISO/MLV_dcmrs
    then
    set=$(printf "%s\n" -d)
    else
    set=$(printf "%s\n" -c)
    fi
#if using the steroid version
    if [ -f /tmp/mlv_dump_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_steroids)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    fi

    while ! [ x"$(cat /tmp/DUALISO/MLV_cprsaa)" = x ]
    do 
    FILE_01="$(cat /tmp/DUALISO/MLV_cprsaa | head -1)"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/MLV_cprsaa)" > /tmp/DUALISO/MLV_cprsaa
#run MLV compressing
    if [ -f /tmp/DUALISO/MLV_cprs_output ]
    then
#safety check
    mkdir -p  "$(cat /tmp/DUALISO/MLV_cprs_output)"
    $mlv_dump $set -o "$(cat /tmp/DUALISO/MLV_cprs_output)"/tmp_"$FILE_01" "$(cat /tmp/DUALISO/path_1)"/"$FILE_01"
    else
    $mlv_dump $set -o tmp_"$FILE_01" "$FILE_01"
    fi
#decompress or not
    if ! ls /tmp/DUALISO/MLV_dcmrs
    then
#delete or not
    if ! ls /tmp/DUALISO/MLV_cprs_del 
    then
    if ! ls /tmp/DUALISO/MLV_cprs_output 
    then
    mv -i "$FILE_01" A_ORIGINALS
    mv -i  "$(echo "$FILE_01" | cut -d "." -f1)".M* A_ORIGINALS
    fi
    else 
    rm "$FILE_01"
    fi
#if changed output
    if [ -f /tmp/DUALISO/MLV_cprs_output ]
    then 
    mv -i "$(cat /tmp/DUALISO/MLV_cprs_output)"/tmp_"$FILE_01" "$(cat /tmp/DUALISO/MLV_cprs_output)"/"$FILE_01"
    else
    mv -i tmp_"$FILE_01" "$FILE_01"
    fi
    fi

#decompress or not
    if ls /tmp/DUALISO/MLV_dcmrs
    then
    mkdir -p A_COMPRESSED
#delete or not
    if ! ls /tmp/DUALISO/MLV_cprs_del 
    then
    if ! ls /tmp/DUALISO/MLV_cprs_output 
    then
    mv -i "$FILE_01" A_COMPRESSED
    mv -i "$(echo "$FILE_01" | cut -d "." -f1)".M* A_COMPRESSED
    fi
    else
    rm "$FILE_01"
    fi
#if changed output
    if [ -f /tmp/DUALISO/MLV_cprs_output ]
    then
    mv -i "$(cat /tmp/DUALISO/MLV_cprs_output)"/tmp_"$FILE_01" "$(cat /tmp/DUALISO/MLV_cprs_output)"/"$FILE_01"
    else
    mv -i tmp_"$FILE_01" "$FILE_01"
    fi
    fi
#list check
    echo "$(tail -n +2 /tmp/DUALISO/MLV_cprs)" > /tmp/DUALISO/MLV_cprs
    done
    







   