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

rm /tmp/HDRMOV*
rm fps
rm dropframes
rm croprec
rm HDR_script*.command
rm /tmp/KILLMOV

#list files for multiprocessing
ls *.MOV > /tmp/HDRMOV
split -l $(( $( wc -l < /tmp/HDRMOV ) / 4 + 1 )) /tmp/HDRMOV /tmp/HDRMOV
rm /tmp/HDRMOV

if grep 'MOV' /tmp/HDRMOVaa
then
cat <<'EOF' > HDR_script.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

#progress_bar
open "$(cat /tmp/DUALISO/path_2)"progress_bar.command &

while grep 'MOV' /tmp/HDRMOVaa; do
#build a temp folder
mkdir -p $(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)
tmp="$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)"
mv $(cat /tmp/HDRMOVaa | head -1) $(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1)
cd "$tmp"

ffmpeg -i $(cat /tmp/HDRMOVaa | head -1) -pix_fmt rgb24 %06d.tif

#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
cr_W=$(echo $(exiftool $(cat /tmp/HDRMOVaa | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f1 ))
cr_H=$(echo $(exiftool $(cat /tmp/HDRMOVaa | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f2 ))
cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)

#First script combines enfused and aligned tif files then exports it to a prores mov file

while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do
#align images and rename
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff & pid1=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff & pid2=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff & pid3=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff & pid4=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff & pid5=$!

#wait for jobs to end
    wait < <(jobs -p)

#if killing process
if ! ls /tmp/KILLMOV 
then 
#output cropped and aligned images
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff

#safeguards
   if ! [ -f 1.tiff ] || ! [ -f 2.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 01.tiff ] || ! [ -f 02.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 001.tiff ] || ! [ -f 002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 0001.tiff ] || ! [ -f 0002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 00001.tiff ] || ! [ -f 00002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
   fi

#remove unwanted files
rm 00001.tiff 00002.tiff 0001.tiff 0002.tiff 001.tiff 002.tiff 01.tiff 02.tiff 1.tiff 2.tiff

rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1')
fi

done

#check for audio
if ! [ x"$(ffmpeg -i $(ls *.MOV | head -1) 2>&1 | grep Audio)" = x ]
then 
ffmpeg -i $(ls *.MOV | head -1) -vn -acodec copy $(ls *.MOV | head -1 | cut -d "." -f1).wav
wav=$(printf "%s\n" -i $(ls *.MOV | head -1 | cut -d "." -f1).wav)
acodec=$(printf "%s\n" -c:v copy -c:a aac)
fi

#output to prores
if ! grep 'a\|A' ../fps
then
fpsIN=$(cat ../fps | head -1)
fpsOUT=$(cat ../fps | tail -1)
if [ -f ../croprec ]
then
scale=$(printf "%s\n" ,scale=$(cat ../croprec))
fi
ffmpeg $wav -r $fpsIN -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le -vf "minterpolate='fps=$fpsOUT'"$scale ../HDR_$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1).mov
else 
#if chosen new output framerate
if [ x"$(cat ../fps  | awk 'FNR == 2 {print $1}')" = x ]
then
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale $dropframes ../HDR_$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1).mov
else
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
#new framerate
if ! [ -f ../croprec ]
then
fps=$(printf "%s\n" -vf minterpolate=fps=$(cat ../fps | tail -1))
else
fps=$(printf "%s\n" ,minterpolate=fps=$(cat ../fps | tail -1))
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale$fps $dropframes  ../HDR_$(cat /tmp/HDRMOVaa | head -1 | cut -d "." -f1).mov
fi
fi

if ls /tmp/KILLMOV 
then 
rm /tmp/HDRMOVaa
fi

mkdir -p ../HDR_ORIGINALS
mv $(cat /tmp/HDRMOVaa | head -1) ../HDR_ORIGINALS
cd -
rm -r "$tmp"
echo "$(tail -n +2 /tmp/HDRMOVaa)" > /tmp/HDRMOVaa
done
rm /tmp/HDRMOVaa

if ! grep 'MOV' /tmp/HDRMOV*
then
rm fps
rm croprec
rm dropframes
fi

rm HDR_script.command

EOF
fi


if grep 'MOV' /tmp/HDRMOVab
then
cat <<'EOF' > HDR_script1.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

while grep 'MOV' /tmp/HDRMOVab; do
#build a temp folder
mkdir -p $(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)
tmp="$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)"
mv $(cat /tmp/HDRMOVab | head -1) $(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1)
cd "$tmp"

ffmpeg -i $(cat /tmp/HDRMOVab | head -1) -pix_fmt rgb24 %06d.tif

#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
cr_W=$(echo $(exiftool $(cat /tmp/HDRMOVab | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f1 ))
cr_H=$(echo $(exiftool $(cat /tmp/HDRMOVab | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f2 ))
cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)

#First script combines enfused and aligned tif files then exports it to a prores mov file

while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do

#align images and rename
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff & pid1=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff & pid2=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff & pid3=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff & pid4=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff & pid5=$!

#wait for jobs to end
    wait < <(jobs -p)

#if killing process
if ! ls /tmp/KILLMOV 
then 
#output cropped and aligned images
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff

#safeguards
   if ! [ -f 1.tiff ] || ! [ -f 2.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 01.tiff ] || ! [ -f 02.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 001.tiff ] || ! [ -f 002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 0001.tiff ] || ! [ -f 0002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 00001.tiff ] || ! [ -f 00002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
   fi

#remove unwanted files
rm 00001.tiff 00002.tiff 0001.tiff 0002.tiff 001.tiff 002.tiff 01.tiff 02.tiff 1.tiff 2.tiff

rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1')
fi
done

#check for audio
if ! [ x"$(ffmpeg -i $(ls *.MOV | head -1) 2>&1 | grep Audio)" = x ]
then 
ffmpeg -i $(ls *.MOV | head -1) -vn -acodec copy $(ls *.MOV | head -1 | cut -d "." -f1).wav
wav=$(printf "%s\n" -i $(ls *.MOV | head -1 | cut -d "." -f1).wav)
acodec=$(printf "%s\n" -c:v copy -c:a aac)
fi

#output to prores
if ! grep 'a\|A' ../fps
then
fpsIN=$(cat ../fps | head -1)
fpsOUT=$(cat ../fps | tail -1)
if [ -f ../croprec ]
then
scale=$(printf "%s\n" ,scale=$(cat ../croprec))
fi
ffmpeg $wav -r $fpsIN -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le -vf "minterpolate='fps=$fpsOUT'"$scale ../HDR_$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1).mov
else 
#if chosen new output framerate
if [ x"$(cat ../fps  | awk 'FNR == 2 {print $1}')" = x ]
then
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale $dropframes ../HDR_$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1).mov
else
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
#new framerate
if ! [ -f ../croprec ]
then
fps=$(printf "%s\n" -vf minterpolate=fps=$(cat ../fps | tail -1))
else
fps=$(printf "%s\n" ,minterpolate=fps=$(cat ../fps | tail -1))
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale$fps $dropframes  ../HDR_$(cat /tmp/HDRMOVab | head -1 | cut -d "." -f1).mov
fi
fi

if ls /tmp/KILLMOV 
then 
rm /tmp/HDRMOVab
fi

mkdir -p ../HDR_ORIGINALS
mv $(cat /tmp/HDRMOVab | head -1) ../HDR_ORIGINALS
cd -
rm -r "$tmp"
echo "$(tail -n +2 /tmp/HDRMOVab)" > /tmp/HDRMOVab
done
rm /tmp/HDRMOVab

if ! grep 'MOV' /tmp/HDRMOV*
then
rm fps
rm croprec
rm dropframes
fi

rm HDR_script1.command

EOF
fi


if grep 'MOV' /tmp/HDRMOVac
then
cat <<'EOF' > HDR_script2.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

while grep 'MOV' /tmp/HDRMOVac; do
#build a temp folder
mkdir -p $(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)
tmp="$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)"
mv $(cat /tmp/HDRMOVac | head -1) $(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1)
cd "$tmp"

ffmpeg -i $(cat /tmp/HDRMOVac | head -1) -pix_fmt rgb24 %06d.tif

#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
cr_W=$(echo $(exiftool $(cat /tmp/HDRMOVac | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f1 ))
cr_H=$(echo $(exiftool $(cat /tmp/HDRMOVac | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f2 ))
cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)

#First script combines enfused and aligned tif files then exports it to a prores mov file

while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do

#align images and rename
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff & pid1=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff & pid2=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff & pid3=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff & pid4=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff & pid5=$!

#wait for jobs to end
    wait < <(jobs -p)

#if killing process
if ! ls /tmp/KILLMOV 
then 
#output cropped and aligned images
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff

#safeguards
   if ! [ -f 1.tiff ] || ! [ -f 2.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 01.tiff ] || ! [ -f 02.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 001.tiff ] || ! [ -f 002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 0001.tiff ] || ! [ -f 0002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 00001.tiff ] || ! [ -f 00002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
   fi

#remove unwanted files
rm 00001.tiff 00002.tiff 0001.tiff 0002.tiff 001.tiff 002.tiff 01.tiff 02.tiff 1.tiff 2.tiff

rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1')
fi
done

#check for audio
if ! [ x"$(ffmpeg -i $(ls *.MOV | head -1) 2>&1 | grep Audio)" = x ]
then 
ffmpeg -i $(ls *.MOV | head -1) -vn -acodec copy $(ls *.MOV | head -1 | cut -d "." -f1).wav
wav=$(printf "%s\n" -i $(ls *.MOV | head -1 | cut -d "." -f1).wav)
acodec=$(printf "%s\n" -c:v copy -c:a aac)
fi

#output to prores
if ! grep 'a\|A' ../fps
then
fpsIN=$(cat ../fps | head -1)
fpsOUT=$(cat ../fps | tail -1)
if [ -f ../croprec ]
then
scale=$(printf "%s\n" ,scale=$(cat ../croprec))
fi
ffmpeg $wav -r $fpsIN -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le -vf "minterpolate='fps=$fpsOUT'"$scale ../HDR_$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1).mov
else 
#if chosen new output framerate
if [ x"$(cat ../fps  | awk 'FNR == 2 {print $1}')" = x ]
then
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale $dropframes ../HDR_$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1).mov
else
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
#new framerate
if ! [ -f ../croprec ]
then
fps=$(printf "%s\n" -vf minterpolate=fps=$(cat ../fps | tail -1))
else
fps=$(printf "%s\n" ,minterpolate=fps=$(cat ../fps | tail -1))
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale$fps $dropframes  ../HDR_$(cat /tmp/HDRMOVac | head -1 | cut -d "." -f1).mov
fi
fi

if ls /tmp/KILLMOV 
then 
rm /tmp/HDRMOVac
fi

mkdir -p ../HDR_ORIGINALS
mv $(cat /tmp/HDRMOVac | head -1) ../HDR_ORIGINALS
cd -
rm -r "$tmp"
echo "$(tail -n +2 /tmp/HDRMOVac)" > /tmp/HDRMOVac
done
rm /tmp/HDRMOVac

if ! grep 'MOV' /tmp/HDRMOV*
then
rm fps
rm croprec
rm dropframes
fi

rm HDR_script2.command

EOF
fi


if grep 'MOV' /tmp/HDRMOVad
then
cat <<'EOF' > HDR_script3.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

while grep 'MOV' /tmp/HDRMOVad; do
#build a temp folder
mkdir -p $(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)
tmp="$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)"
mv $(cat /tmp/HDRMOVad | head -1) $(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1)
cd "$tmp"

ffmpeg -i $(cat /tmp/HDRMOVad | head -1) -pix_fmt rgb24 %06d.tif

#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
cr_W=$(echo $(exiftool $(cat /tmp/HDRMOVad | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f1 ))
cr_H=$(echo $(exiftool $(cat /tmp/HDRMOVad | head -1) | awk '/Image Size/ { print $4,$5; exit }' | cut -d ":" -f2 | cut -d "x" -f2 ))
cr_Ws=$(echo $cr_W*0.98 | bc -l | cut -d "." -f1)
cr_Hs=$(echo $cr_H*0.98 | bc -l | cut -d "." -f1)
crp_fix=$(echo crop=$cr_Ws:$cr_Hs,scale=$cr_W:$cr_H)

#First script combines enfused and aligned tif files then exports it to a prores mov file

while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do

#align images and rename
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff & pid1=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff & pid2=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff & pid3=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff & pid4=$!

/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff & pid5=$!

#wait for jobs to end
    wait < <(jobs -p)

#if killing process
if ! ls /tmp/KILLMOV 
then 
#output cropped and aligned images
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff

#safeguards
   if ! [ -f 1.tiff ] || ! [ -f 2.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') && mv aligned.tif0000.tif 1.tiff && mv aligned.tif0001.tif 2.tiff
ffmpeg -i %01d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 01.tiff ] || ! [ -f 02.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') && mv aligned2.tif0000.tif 01.tiff && mv aligned2.tif0001.tif 02.tiff
ffmpeg -i %02d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 001.tiff ] || ! [ -f 002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') && mv aligned3.tif0000.tif 001.tiff && mv aligned3.tif0001.tif 002.tiff
ffmpeg -i %03d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 0001.tiff ] || ! [ -f 0002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') && mv aligned4.tif0000.tif 0001.tiff && mv aligned4.tif0001.tif 0002.tiff
ffmpeg -i %04d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4' | cut -d "." -f2 | tr -d "/").tiff
   fi

   if ! [ -f 00001.tiff ] || ! [ -f 00002.tiff ]
   then
   sleep 2
rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned5.tif $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 6') && mv aligned5.tif0000.tif 00001.tiff && mv aligned5.tif0001.tif 00002.tiff
ffmpeg -i %05d.tiff -pix_fmt rgb24 -vf tblend=all_mode=average,$crp_fix $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5' | cut -d "." -f2 | tr -d "/").tiff
   fi

#remove unwanted files
rm 00001.tiff 00002.tiff 0001.tiff 0002.tiff 001.tiff 002.tiff 01.tiff 02.tiff 1.tiff 2.tiff

rm $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 5') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 4') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 3') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 2') $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1')
fi
done

#check for audio
if ! [ x"$(ffmpeg -i $(ls *.MOV | head -1) 2>&1 | grep Audio)" = x ]
then 
ffmpeg -i $(ls *.MOV | head -1) -vn -acodec copy $(ls *.MOV | head -1 | cut -d "." -f1).wav
wav=$(printf "%s\n" -i $(ls *.MOV | head -1 | cut -d "." -f1).wav)
acodec=$(printf "%s\n" -c:v copy -c:a aac)
fi

#output to prores
if ! grep 'a\|A' ../fps
then
fpsIN=$(cat ../fps | head -1)
fpsOUT=$(cat ../fps | tail -1)
if [ -f ../croprec ]
then
scale=$(printf "%s\n" ,scale=$(cat ../croprec))
fi
ffmpeg $wav -r $fpsIN -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le -vf "minterpolate='fps=$fpsOUT'"$scale ../HDR_$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1).mov
else 
#if chosen new output framerate
if [ x"$(cat ../fps  | awk 'FNR == 2 {print $1}')" = x ]
then
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale $dropframes ../HDR_$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1).mov
else
if [ -f ../croprec ]
then
scale=$(printf "%s\n" -vf scale=$(cat ../croprec))
fi
if [ -f ../dropframes ]
then
drop=$(echo $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) / 2 | bc -l)
dropframes=$(printf "%s\n" -r $drop)
fi
#new framerate
if ! [ -f ../croprec ]
then
fps=$(printf "%s\n" -vf minterpolate=fps=$(cat ../fps | tail -1))
else
fps=$(printf "%s\n" ,minterpolate=fps=$(cat ../fps | tail -1))
fi
ffmpeg $wav -r $(exiftool $(ls *.MOV | head -1) | grep 'Video Frame Rate' | cut -d ":" -f2) -i %06d.tiff $acodec -vcodec prores -pix_fmt yuv422p10le $scale$fps $dropframes  ../HDR_$(cat /tmp/HDRMOVad | head -1 | cut -d "." -f1).mov
fi
fi

if ls /tmp/KILLMOV 
then 
rm /tmp/HDRMOVad
fi

mkdir -p ../HDR_ORIGINALS
mv $(cat /tmp/HDRMOVad | head -1) ../HDR_ORIGINALS
cd -
rm -r "$tmp"
echo "$(tail -n +2 /tmp/HDRMOVad)" > /tmp/HDRMOVad
done
rm /tmp/HDRMOVad

if ! grep 'MOV' /tmp/HDRMOV*
then
rm fps
rm croprec
rm dropframes
fi

rm HDR_script3.command
 
EOF
fi


#fps command
cat <<'EOF' > fps.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

###########dependencies############
#homebrew
if ! [ -f "/usr/local/bin/brew" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
read -p $(tput bold)"homebrew is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
if [ -f "/usr/local/bin/brew" ]
then
clear && echo "brew is intalled and ready for use"
else
clear && echo "brew did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi

#hugin
if ! [ -f "/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for hugin, please wait..."
sleep 2
read -p $(tput bold)"hugin is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
brew cask install hugin
if [ -f "/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack" ]
then
clear && echo "hugin is intalled and ready for use"
else
clear && echo "hugin did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi


#exiftool
if ! [ -f "/usr/local/bin/exiftool" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for exiftool, please wait..."
sleep 2
read -p $(tput bold)"exiftool is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
brew install exiftool
if [ -f "/usr/local/bin/exiftool" ]
then
clear && echo "exiftool is intalled and ready for use"
else
clear && echo "exiftool did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi


#ffmpeg
if ! [ -f "/usr/local/bin/ffmpeg" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for ffmpeg, please wait..."
sleep 2
read -p $(tput bold)"ffmpeg is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
brew install ffmpeg
if [ -f "/usr/local/bin/ffmpeg" ]
then
clear && echo "ffmpeg is intalled and ready for use"
else
clear && echo "ffmpeg did not install"
fi
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi

if grep 'MOV' /tmp/HDRMOV*
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"Specify input fps:$(tput sgr0)(e.g $(tput bold)24,25,29.97,36,38 $(tput sgr0)etc or specify $(tput bold)A$(tput sgr0) for auto then hit enter)"
read input_variable
printf "%s\n" "$input_variable" > fps
if grep -q 'a\|A' fps
then
input_variable=$(echo auto)
fi
echo "Input fps is set to: $(tput bold)$(tput setaf 4)$input_variable fps"$(tput sgr0)

sleep 2

if ! grep 'a\|A' fps
then
clear
echo $(tput bold)"Specify wanted output fps:$(tput sgr0)e.g $(tput bold)24,25,29.97 $(tput sgr0)etc then hit enter)"
read input_variable
echo "output fps is set to: $(tput bold)$(tput setaf 4)$input_variable fps"$(tput sgr0)
printf "%s\n" "$input_variable" >> fps
sleep 2
fi

#if you still want to specify another output fps if chosen auto
if grep 'a\|A' fps
then
printf '\e[8;16;98t'
printf '\e[3;410;100t'
clear
read -p $(tput bold)"Do you still want to change to another framerate output?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
clear
echo $(tput bold)"Please specify output framrerate:$(tput sgr0)e.g $(tput bold)24,25,29.97 $(tput sgr0)etc then hit enter)"
read input_variable
echo "output fps is set to: $(tput bold)$(tput setaf 4)$input_variable fps"$(tput sgr0)
printf "%s\n" "$input_variable" >> fps
sleep 2
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi

#check for croprec
num=$(exiftool $(ls *.MOV | head -1) | awk '/Video Frame Rate/ { print $5; exit}')
if (( $(echo "$num > 47" |bc -l) ))
then
clear
read -p $(tput bold)"Did you film croprec and need to destretch footage?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
echo $(tput bold)"
Now specify only width:$(tput sgr0)($(tput sgr0)e.g 1920 and hit enter)"
read input_variable
echo "Your scale output will be: $(tput bold)$(tput setaf 4)$input_variable"$(tput sgr0)
echo $input_variable:-1,setdar=16:6 > croprec
sleep 1
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi


#check for dropframe
#if chosen new output framerate

if [ x"$(cat fps  | awk 'FNR == 2 {print $1}')" = x ]
then
if grep 'a\|A' fps 
then
num=$(exiftool $(ls *.MOV | head -1) | awk '/Video Frame Rate/ { print $5; exit}')
if (( $(echo "$num > 47" |bc -l) ))
then
clear
read -p $(tput bold)"Dropframes?$(tput sgr0)(50fps to 25fps, 60fps to 30fps and so on...)$(tput setaf 1)
$(tput bold)(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) echo > dropframes
;;
  n|N ) 
clear
echo "no thanks!"
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac
fi
fi
fi

#silent mode?
clear
read -p $(tput bold)"Do you want to run in silent mode?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
mode=$(echo .)
echo $(tput bold)"silent mode set"$(tput sgr0)
sleep 1
;;
  n|N ) 
clear
mode=$(echo open)
echo $(tput bold)silent mode NOT set$(tput sgr0)
sleep 1
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. fps.command
;;
esac


chmod u=rwx HDR_script.command
chmod u=rwx HDR_script1.command
chmod u=rwx HDR_script2.command
chmod u=rwx HDR_script3.command

sleep 1 && $mode HDR_script.command &
sleep 1 && $mode HDR_script1.command &
sleep 1 && $mode HDR_script2.command &
sleep 1 && $mode HDR_script3.command &

fi

sleep 1 && rm fps.command & echo -n -e "\033]0;fps\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "fps")' & exit

EOF

#open fps command
chmod u=rwx fps.command
open fps.command

echo -n -e "\033]0;HDR_script\007" && kill $(echo $$) && osascript -e 'tell application "Terminal" to close (every window whose name contains "HDR_script")' & exit



