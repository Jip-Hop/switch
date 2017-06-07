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

vit_01a=$(dcraw -T -a -v -c *000000*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
vit_01=$(echo $vit_01a | awk '{print $1}') 
vit_02=$(echo $vit_01a | awk '{print $2}')
vit_03=$(echo $vit_01a | awk '{print $3}')
vit_04=$(echo $vit_01a | awk '{print $4}')

if find *000070*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000070*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000140*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000140*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000200*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000200*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000250*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000250*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000310*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000310*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000390*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000390*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

if find *000450*.{dng,DNG}
then
vit_01a=$(dcraw -T -a -v -c *000450*.{dng,DNG} 2>&1 | awk '/multipliers/ { print $2,$3,$4,$5; exit }')
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

vit_01f=$(echo $vit_01+$vit_01b+$vit_01c+$vit_01d+$vit_01e+$vit_01f+$vit_01g+$vit_01h | bc -l)
vit_01_r=$(echo $vit_01f/6 | bc -l)

vit_02f=$(echo $vit_02+$vit_02b+$vit_02c+$vit_02d+$vit_02e+$vit_02f+$vit_02g+$vit_02h | bc -l)
vit_02_r=$(echo $vit_02f/6 | bc -l)

vit_03f=$(echo $vit_03+$vit_03b+$vit_03c+$vit_03d+$vit_03e+$vit_03f+$vit_03g+$vit_03h | bc -l)
vit_03_r=$(echo $vit_03f/6 | bc -l)

vit_04f=$(echo $vit_04+$vit_04b+$vit_04c+$vit_04d+$vit_04e+$vit_04f+$vit_04g+$vit_04h | bc -l)
vit_04_r=$(echo $vit_04f/6 | bc -l)

vit_01=$(echo $vit_02_r/$vit_01_r | bc -l | awk 'FNR == 1 {print}')
vit_02=$(echo $vit_04_r/$vit_03_r | bc -l | awk 'FNR == 1 {print}')

cp *000000*.{dng,DNG} /tmp/
exiftool "$(echo "-AsShotNeutral=$vit_01 1 $vit_02")" /tmp/*000000.dng -overwrite_original
wi=$(exiv2 -pt /tmp/*000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
rm /tmp/*000000.dng
exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi" *000000.dng



