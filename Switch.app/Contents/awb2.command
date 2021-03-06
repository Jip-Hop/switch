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
 # Free Software Foundation, Inc.
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.

#check extension
    ext=WB
#rename if needed
    for old in M*.txt; do mv $old `basename $old .txt`.WB; done 2>/dev/null

#selection point white balance handling

vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 1') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01=$(echo $vit_01a | awk '{print $1}') 
vit_02=$(echo $vit_01a | awk '{print $2}')
vit_03=$(echo $vit_01a | awk '{print $3}')
vit_04=$(echo $vit_01a | awk '{print $4}')

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 2' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 2') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01b=$(echo $vit_01a | awk '{print $1}') 
vit_02b=$(echo $vit_01a | awk '{print $2}')
vit_03b=$(echo $vit_01a | awk '{print $3}')
vit_04b=$(echo $vit_01a | awk '{print $4}')
else 
vit_01b=$(echo 0)
vit_02b=$(echo 0)
vit_03b=$(echo 0)
vit_04b=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 3' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 3') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01c=$(echo $vit_01a | awk '{print $1}') 
vit_02c=$(echo $vit_01a | awk '{print $2}')
vit_03c=$(echo $vit_01a | awk '{print $3}')
vit_04c=$(echo $vit_01a | awk '{print $4}')
else 
vit_01c=$(echo 0)
vit_02c=$(echo 0)
vit_03c=$(echo 0)
vit_04c=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 4' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 4') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01d=$(echo $vit_01a | awk '{print $1}') 
vit_02d=$(echo $vit_01a | awk '{print $2}')
vit_03d=$(echo $vit_01a | awk '{print $3}')
vit_04d=$(echo $vit_01a | awk '{print $4}')
else 
vit_01d=$(echo 0)
vit_02d=$(echo 0)
vit_03d=$(echo 0)
vit_04d=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 5' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 5') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01e=$(echo $vit_01a | awk '{print $1}') 
vit_02e=$(echo $vit_01a | awk '{print $2}')
vit_03e=$(echo $vit_01a | awk '{print $3}')
vit_04e=$(echo $vit_01a | awk '{print $4}')
else 
vit_01e=$(echo 0)
vit_02e=$(echo 0)
vit_03e=$(echo 0)
vit_04e=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 6' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 6') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01f=$(echo $vit_01a | awk '{print $1}') 
vit_02f=$(echo $vit_01a | awk '{print $2}')
vit_03f=$(echo $vit_01a | awk '{print $3}')
vit_04f=$(echo $vit_01a | awk '{print $4}')
else 
vit_01f=$(echo 0)
vit_02f=$(echo 0)
vit_03f=$(echo 0)
vit_04f=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 7' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 7') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01g=$(echo $vit_01a | awk '{print $1}') 
vit_02g=$(echo $vit_01a | awk '{print $2}')
vit_03g=$(echo $vit_01a | awk '{print $3}')
vit_04g=$(echo $vit_01a | awk '{print $4}')
else 
vit_01g=$(echo 0)
vit_02g=$(echo 0)
vit_03g=$(echo 0)
vit_04g=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 8' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 8') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01h=$(echo $vit_01a | awk '{print $1}') 
vit_02h=$(echo $vit_01a | awk '{print $2}')
vit_03h=$(echo $vit_01a | awk '{print $3}')
vit_04h=$(echo $vit_01a | awk '{print $4}')
else 
vit_01h=$(echo 0)
vit_02h=$(echo 0)
vit_03h=$(echo 0)
vit_04h=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 9' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 9') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01i=$(echo $vit_01a | awk '{print $1}') 
vit_02i=$(echo $vit_01a | awk '{print $2}')
vit_03i=$(echo $vit_01a | awk '{print $3}')
vit_04i=$(echo $vit_01a | awk '{print $4}')
else 
vit_01i=$(echo 0)
vit_02i=$(echo 0)
vit_03i=$(echo 0)
vit_04i=$(echo 0)
fi

if ! [ "x$(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 10' | grep -v 'whitebalance')" = x ]
then
vit_01a=$(dcraw -v -c -T -A $(cat $(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).$ext | awk 'FNR == 10') 10 10 /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01j=$(echo $vit_01a | awk '{print $1}') 
vit_02j=$(echo $vit_01a | awk '{print $2}')
vit_03j=$(echo $vit_01a | awk '{print $3}')
vit_04j=$(echo $vit_01a | awk '{print $4}')
else 
vit_01j=$(echo 0)
vit_02j=$(echo 0)
vit_03j=$(echo 0)
vit_04j=$(echo 0)
fi


vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e+$vit_01f+$vit_01g+$vit_01h+$vit_01i+$vit_01j | bc -l)
vit_01_r=$(echo $vit_01f/6 | bc -l)

vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e+$vit_02f+$vit_02g+$vit_02h+$vit_02i+$vit_02j | bc -l)
vit_02_r=$(echo $vit_02f/6 | bc -l)

vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e+$vit_03f+$vit_03g+$vit_03h+$vit_03i+$vit_03j | bc -l)
vit_03_r=$(echo $vit_03f/6 | bc -l)

vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04e+$vit_04f+$vit_04g+$vit_04h+$vit_04i+$vit_04j | bc -l)
vit_04_r=$(echo $vit_04f/6 | bc -l)

vit_01=$(echo $vit_02_r/$vit_01_r | bc -l | awk 'FNR == 1 {print}')
vit_02=$(echo $vit_04_r/$vit_03_r | bc -l | awk 'FNR == 1 {print}')

exiftool "$(echo "-AsShotNeutral=$vit_01 1 $vit_02")" /tmp/DUALISO/$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1).dng -overwrite_original
dcraw +M -w -c -6 -W -q 3 /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1)".dng | ffmpeg -f image2pipe -vcodec ppm -i pipe:0 -y -pix_fmt rgb24 -t 1 2>/dev/null /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1)".tif
open -a /Applications/ImageJ/ImageJ.app /tmp/DUALISO/"$(cat /tmp/DUALISO/WB_MLV_list | awk 'FNR == 1' | cut -d "." -f1)".tif &
 


