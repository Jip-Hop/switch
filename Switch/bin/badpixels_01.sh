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
    echo > ~/Switch/config/tmp/BP_TRAP1
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    map=$(printf "%s\n" fpm)
    else
    map=$(printf "%s\n" map)
    fi    
    while ! [ x"$(cat ~/Switch/config/tmp/badpixelMLVaa)" = x ]
    do 
    FILE_01="$(cat ~/Switch/config/tmp/badpixelMLVaa | head -1)"
    FILE_01o="$(cat ~/Switch/config/tmp/badpixelMLVaa | head -1 | cut -d "." -f1)"
#cut to the next name on the list
    echo "$(tail -n +2 ~/Switch/config/tmp/badpixelMLVaa)" > ~/Switch/config/tmp/badpixelMLVaa
#run dfort focus pixel script
    if ! grep '5D\|7D\|T1i\|500D\|T2i\|550D\|6D\|T3i\|600D\|50D' <<< $(mlv_dump -v -m "$FILE_01" | awk '/Camera Name/ { print $5,$6; exit 0}')
    then 
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    if [ -f ~/Switch/config/tmp/crop_rec ]
    then
    fpmutil -m croprec -o "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01o".$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01"
    else
    fpmutil -o "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01o".$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01"
    fi
    else
#check for new output folder
    if ! [ -f ~/Switch/config/output ]
    then
    if [ -f ~/Switch/config/tmp/crop_rec ]
    then
    fpm.sh -m crop_rec -o "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01o".$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01"
    else
    fpm.sh -o "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01o".$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE_01"  
    fi 
    fi  
    fi
    fi
    done
#remove trap
rm ~/Switch/config/tmp/BP_TRAP1






