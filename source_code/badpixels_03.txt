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

#print out trap note 1
    echo > /tmp/DUALISO/BP_TRAP3
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    map=$(printf "%s\n" fpm)
    else
    map=$(printf "%s\n" map)
    fi 
    while ! [ x"$(cat /tmp/DUALISO/badpixelMLVac)" = x ]
    do 
#get the file
    FILE_03="$(cat /tmp/DUALISO/badpixelMLVac | head -1)"
    FILE_03o="$(cat /tmp/DUALISO/badpixelMLVac | head -1 | cut -d "." -f1)"
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/badpixelMLVac)" > /tmp/DUALISO/badpixelMLVac
#run dfort focus pixel script
    if ! grep '5D\|7D\|T1i\|500D\|T2i\|550D\|6D\|T3i\|600D\|50D' <<< $(mlv_dump -v -m "$FILE_03" | awk '/Camera Name/ { print $5,$6; exit 0}')
    then 
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    if [ -f /tmp/DUALISO/crop_rec ]
    then
#check for a 100D
    dpass3=
    if grep '100D\|SL1\|X7' <<< $(mlv_dump -v -m "$FILE_03" | awk '/Camera Name/ { print $5,$6,$7; exit 0}')
    then
    dpass3=$(printf "%s\n" -c 100D)
    fi 
    fpmutil -m croprec $dpass3 -o "$(cat /tmp/DUALISO/path_1)"/"$FILE_03o".$map "$(cat /tmp/DUALISO/path_1)"/"$FILE_03"
    else
    fpmutil -o "$(cat /tmp/DUALISO/path_1)"/"$FILE_03o".$map "$(cat /tmp/DUALISO/path_1)"/"$FILE_03"
    fi
    else
#check for new output folder
    if ! [ -f /tmp/output ]
    then
    if [ -f /tmp/DUALISO/crop_rec ]
    then
    fpm.sh -m crop_rec -o "$(cat /tmp/DUALISO/path_1)"/"$FILE_03o".$map "$(cat /tmp/DUALISO/path_1)"/"$FILE_03"
    else
    fpm.sh -o "$(cat /tmp/DUALISO/path_1)"/"$FILE_03o".$map "$(cat /tmp/DUALISO/path_1)"/"$FILE_03"  
    fi 
    fi
    fi
    fi
    done
#remove trap
rm /tmp/DUALISO/BP_TRAP3






