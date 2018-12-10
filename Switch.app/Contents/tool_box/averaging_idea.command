#https://www.magiclantern.fm/forum/index.php?topic=22986.msg207823#msg207823

#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"


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
;;
  * ) 
echo "invalid selection, let´s start again"
sleep 1
. /tmp/fps.command
;;
esac
fi


#exiftool dependency
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
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
;;
esac
fi


#HDRmerge dependency
if ! [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
then
printf '\e[8;16;85t'
printf '\e[3;410;100t'
clear
echo $(tput bold)"
Checking for HDRmerge, please wait..."
sleep 2
read -p $(tput bold)"HDRMerge is not installed would you like to install it?$(tput setaf 1)
(Y/N)?$(tput sgr0)
" choice
case "$choice" in 
  y|Y ) 
#!/bin/bash
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
[ ! -f "`which wget`" ] && brew install wget
wget -O HDRMerge.dmg https://github.com/jcelaya/hdrmerge/releases/download/v0.5.0/HDRMerge.dmg && hdiutil attach HDRMerge.dmg && cp -r /Volumes/HDRMerge\ for\ Mac/HDRMerge.app /Applications && hdiutil eject /Volumes/HDRMerge\ for\ Mac && rm HDRMerge.dmg
sleep 2
if [ -f "/Applications/HDRMerge.app/Contents/MacOS/hdrmerge" ]
then
clear && echo "HDRmerge is intalled and ready for use"
else
clear && echo "HDRmerge did not install"
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
;;
esac
fi


#works on tif files
while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif \
$(find -s . -maxdepth 1 -name '*.tif' | head -n 15)
/Applications/Hugin/tools_mac/enfuse --exposure-optimum=0.5 --exposure-width=0.5 $(find . -maxdepth 1 -iname 'aligned.*tif') -o $(find -s . -maxdepth 1 -iname '*.tif' | awk 'FNR == 1' | cut -d "." -f2 | tr -d "/").tiff
rm aligned.*tif
mkdir -p tif_tmp
mv $(find -s . -maxdepth 1 -name '*.tif' | awk 'FNR == 1') tif_tmp
done



#works on dng files
#fps
fps=$(echo $(echo $(exiftool $(find -s . -maxdepth 1 -name '*.dng' | awk 'FNR == 1') | grep 'Frame Rate' | tr '\r' '\n'  | awk '{print $4}') / 2 | bc -l) | cut -d '.' -f1)
mkdir -p dng_originals
mkdir -p dng_HDRmerge
while grep -E "dng" <<< $(find . -maxdepth 1 -iname '*.dng')
do
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -o dng_HDRmerge/$pre%iF[0].dng $(find -s . -maxdepth 1 -name '*.dng' | head -n $fps)
mv $(find -s . -maxdepth 1 -name '*.dng' | awk 'FNR == 1') dng_originals
done
mv -i dng_HDRmerge/*.dng ./
rm -r dng_HDRmerge




exit 0





#version with ffmpeg included:


#works on tif files. Will spit out both ffmpeg and enfuse files prefixed Enfuse_ and FFmpeg_
while grep -E "tif" <<< $(find . -maxdepth 1 -iname '*.tif')
do
#FFmpeg
name=$(find -s . -maxdepth 1 -name '*.tif' | awk 'FNR == 1' | cut -d '/' -f2)
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(find -s . -maxdepth 1 -name '*.tif' | awk 'FNR == 1') | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(find -s . -maxdepth 1 -name '*.tif' | awk 'FNR == 1') | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use align_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned.tif $(find -s . -maxdepth 1 -name '*.tif' | head -n 15) | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'tif' <<< $(find -s . -maxdepth 1 -name '*.tif' | head -n 15) | wc -w)-1 | bc -l)) | tr -d " ")

#align files now
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned.tif \
$(find -s . -maxdepth 1 -name '*.tif' | head -n 15)

#producing the file
   ffmpeg -i aligned.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_$(echo $name | cut -d "." -f1).tiff

/Applications/Hugin/tools_mac/enfuse --exposure-optimum=0.5 --exposure-width=0.5 $(find . -maxdepth 1 -iname 'aligned.*tif') -o Enfuse_$(echo $name | cut -d "." -f1).tiff
rm aligned.*tif
mkdir -p tif_tmp
mv $name tif_tmp
done


#works on dng files
#fps
fps=$(echo $(echo $(exiftool $(find -s . -maxdepth 1 -name '*.dng' | awk 'FNR == 1') | grep 'Frame Rate' | tr '\r' '\n'  | awk '{print $4}') / 2 | bc -l) | cut -d '.' -f1)
mkdir -p dng_originals
mkdir -p dng_HDRmerge
while grep -E "dng" <<< $(find . -maxdepth 1 -iname '*.dng')
do
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -o dng_HDRmerge/$pre%iF[0].dng $(find -s . -maxdepth 1 -name '*.dng' | head -n $fps)
mv $(find -s . -maxdepth 1 -name '*.dng' | awk 'FNR == 1') dng_originals
done
mv -i dng_HDRmerge/*.dng ./
rm -r dng_HDRmerge