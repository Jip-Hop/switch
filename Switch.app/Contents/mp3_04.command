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
    echo > /tmp/DUALISO/mp3_TRAP4
#mp3 producer
#export to different flavours of prores through FFmpeg and dcraw
    while ! [ x"$(cat listad)" = x ]
    do  
    ffmpeg -i "$(cat "listad" | head -1)" -b:a 192k -vn "$(cat "listad" | head -1 | cut -d "." -f1)".mp3
    mv "$(cat "listad" | head -1)" A_ORIGINALS
#cut to the next name on the list
    echo "$(tail -n +2 listad)" > listad
    done
    rm listad
#remove trap
rm /tmp/DUALISO/mp3_TRAP4 






