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


#Scripts for testing purposes
#Drop HDR MOV files into a folder and run the script i terminal from within the folder with MOV files. Hit enter when prompted

#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
for file in *.CR2; do
num=$(exiftool "$file" | grep 'Image Height' | head -1 | cut -d ":" -f2 | tr -d " ")
exiftool "-CroppedImageHeight=$num" "-CroppedImageTop=0" "-Aspectratio+=249" "$file" -overwrite_original 
done



