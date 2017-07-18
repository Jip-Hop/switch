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

#Script originally to test/verify hdrmerge flicker issue

workingDir=`dirname "$0"`
cd "${workingDir}"

mkdir -p originals

ls *.dng > list

while grep 'dng' list
do

/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $bit -o "tmp1$(awk 'FNR == 1 {print $1}' list)" $(awk 'FNR == 1 {print $1}' list) $(awk 'FNR == 2 {print $1}' list)

/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $bit -o "tmp2$(awk 'FNR == 2 {print $1}' list)" $(awk 'FNR == 2 {print $1}' list) $(awk 'FNR == 3 {print $1}' list)


mv $(awk 'FNR == 1' list) $(awk 'FNR == 1 {print $1}' list) $(awk 'FNR == 2 {print $1}' list) originals
mv "tmp1$(awk 'FNR == 1 {print $1}' list)" "$(awk 'FNR == 1 {print $1}' list)"
mv "tmp2$(awk 'FNR == 2 {print $1}' list)" "$(awk 'FNR == 2 {print $1}' list)"
echo "$(tail -n +3 list)" > list
done






