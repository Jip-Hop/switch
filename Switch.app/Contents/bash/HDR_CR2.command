    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    else
#remove unwanted subscripts
#set silent mode
    if [ -f /tmp/silent ]
    then
    sleep 5 && rm /tmp/silent &
    mode=$(echo .)
    else
    mode=$(echo open)
    fi
if ! [ -f /tmp/matchaa ]
then
  rm /tmp/HDR1.command
  else
  chmod u=rwx /tmp/HDR1.command
  $mode /tmp/HDR1.command & 
fi

if ! [ -f /tmp/matchab ] 
 then
  rm /tmp/HDR2.command
  else
  chmod u=rwx /tmp/HDR2.command 
  $mode /tmp/HDR2.command & 
fi

if ! [ -f /tmp/matchac ]
 then
  rm /tmp/HDR3.command
  else
  chmod u=rwx /tmp/HDR3.command
  $mode /tmp/HDR3.command &  
fi

if ! [ -f /tmp/matchad ]
 then
  rm /tmp/HDR4.command
  else
  chmod u=rwx /tmp/HDR4.command 
  $mode /tmp/HDR4.command & 
fi
    fi
#remove first command and start HDRmerge processing
sleep 2 && rm /tmp/HDR_match.command & echo -n -e "\033]0;end\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end")' & exit 
EOF

#now build multiprocessing subscripts
#process1
cat <<'EOF' > /tmp/HDR1.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[3;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
#process 1
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"HDRmerge script 1 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchaa | awk 'FNR == 1')
    mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
  done
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
else
rm /tmp/matchaa
mv /tmp/matchBaa /tmp/matchaa
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
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
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
done
rm /tmp/HDR1.command
rm /tmp/matchaa
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
then 
rm /tmp/all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif)  
rm aligned1*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned1*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
  done
fi
rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchaa >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 1 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchaa | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned1.tif $(cat /tmp/matchaa | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchaa | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned1.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchaa | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchaa | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchaa | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchaa | awk 'FNR == 1')
then
mv $(cat /tmp/matchaa | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchaa)" > /tmp/matchaa
#erase 
   rm aligned1*.tif 
done
rm /tmp/HDR1.command /tmp/matchaa
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end1\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end1")' & exit
fi
EOF

#process2
cat <<'EOF' > /tmp/HDR2.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[5;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchab >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 2 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchab | awk 'FNR == 1')
    mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
  done
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
else
rm /tmp/matchab
mv /tmp/matchBab /tmp/matchab
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchab | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
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
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
   rm FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
done
rm /tmp/HDR2.command
rm /tmp/matchab
#remove all_in list
if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
then 
rm all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif)  
rm aligned2*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned2*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
  done
fi
rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchab >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 2 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchab | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchab | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned2.tif $(cat /tmp/matchab | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchab | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned2.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv "$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchab | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchab | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
#move original file
   mv $(cat /tmp/matchab | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchab | awk 'FNR == 1')
then
mv $(cat /tmp/matchab | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchab)" > /tmp/matchab
#erase 
   rm aligned2*.tif 
done
rm /tmp/HDR2.command /tmp/matchab
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR1.command\|HDR3.command\|HDR4.command' <<< $(ls /tmp/HDR1.command /tmp/HDR3.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end2\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end2")' & exit
fi
EOF

#process3
cat <<'EOF' > /tmp/HDR3.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[7;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchac >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 3 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchac | awk 'FNR == 1')
    mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
  done
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
else
rm /tmp/matchac
mv /tmp/matchBac /tmp/matchac
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchac | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
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
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
   rm FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
done
rm /tmp/HDR3.command
rm /tmp/matchac
#remove all_in list
if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
then 
rm all_in
fi
#check for multiple input folders(all_in)
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif)  
rm aligned3*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned3*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
  done
fi
rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchac >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 3 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchac | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchac | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned3.tif $(cat /tmp/matchac | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchac | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned3.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchac | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchac | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchac | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchac | awk 'FNR == 1')
then
mv $(cat /tmp/matchac | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchac)" > /tmp/matchac
#erase 
   rm aligned3*.tif 
done
rm /tmp/HDR3.command /tmp/matchac
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR1.command\|HDR4.command' <<< $(ls /tmp/HDR2.command /tmp/HDR1.command /tmp/HDR4.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end3\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end3")' & exit
fi
EOF

#process4
cat <<'EOF' > /tmp/HDR4.command
cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 

printf '\e[8;6;40t'
printf '\e[9;410;100t'
#stash away originals
mkdir -p A_ORIGINALS
mkdir -p A_previews

#choose HDR workflow
if [ -f /tmp/HDRmerge ] || [ -f /tmp/all_in ]
then
#set prefix if all_in mode
if [ -f /tmp/all_in ]
then
pre=$(echo HDRmerge_)
fi
 while grep 'CR2\|cr2' /tmp/matchad >/dev/null 2>&1
  do 
clear
echo $(tput bold)"HDRmerge script 4 is working!"$(tput sgr0)
   /Applications/HDRMerge.app/Contents/MacOS/hdrmerge -r 15 -o $pre%iF[0]-%in[-1].dng $(cat /tmp/matchad | awk 'FNR == 1')
    mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
   echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
  done
#all_in mode
if ! [ -f /tmp/all_in ]
then
rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
else
rm /tmp/matchad
mv /tmp/matchBad /tmp/matchad
fi
fi

if [ -f /tmp/enfuse ] || [ -f /tmp/all_in ]
then
#all_in mode
if [ -f /tmp/all_in ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse/FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#enfuse
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif) 
#build a preview jpg
    ffmpeg -i Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/Enfuse_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
#FFmpeg
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchad | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
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
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
   rm FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#build a preview jpg
    ffmpeg -i FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg 
#metadata going back to jpg preview
   mv FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/FFmpeg_"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
done
rm /tmp/HDR4.command
rm /tmp/matchad
#remove all_in list
if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
then 
rm all_in
fi
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
else
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"enfuse script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1') && /Applications/Hugin/tools_mac/enfuse -o "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif)  
rm aligned4*.tif 
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif $(echo -n aligned4*.tif) 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp 
mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
  done
fi
rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &
    chmod u=rwx /tmp/HDR_match.command 
    sleep 1 && open /tmp/HDR_match.command & echo -n -e "\033]0;start\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "start")' & exit
    fi
    fi
#the end
echo -n -e "\033]0;end4\007" && osascript -e 'tell application "Terminal" to close (every window whose name contains "end4")' & exit
fi

if [ -f /tmp/FFmpeg ]
then
 while grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' /tmp/matchad >/dev/null 2>&1
  do
clear
echo $(tput bold)"FFmpeg script 4 is working!"$(tput sgr0)
mkdir -p A_ORIGINALS
#crop and rescale is needed is needed after aligning. Will take place in #output cropped and aligned images section
   cr_W=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f1 ))
   cr_H=$(echo $(exiftool $(cat /tmp/matchad | head -1) | grep 'Image Size' | grep -v 'Canon Image Size' | awk '/Image Size/ { print $4; exit }' | cut -d "x" -f2 ))
#use aligne_image_stack to determine crop area
   crop1=$(/Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -v -C -a aligned1.tif $(cat /tmp/matchad | awk 'FNR == 1') | grep -m 1 'Set crop size' | awk '{ print $5}' | cut -d ',' -f1,2,3,4)
#set all crop parameters
   cr_Wx=$(echo $crop1 | cut -d ',' -f1)
   cr_Wy=$(echo $crop1 | cut -d ',' -f2)
   cr_Ws=$(echo $crop1 | cut -d ',' -f3)
   cr_Hs=$(echo $crop1 | cut -d ',' -f4)
   cr_Ws=$(echo $cr_Ws-$cr_Wx | bc -l)
   cr_Hs=$(echo $cr_Hs-$cr_Wy | bc -l)
#crop result   
   crp_fix=$(echo crop=$cr_Ws:$cr_Hs:$cr_Wx:$cr_Wy,scale=$cr_W:-1)
#hugin aligning
   /Applications/Hugin/Hugin.app/Contents/MacOS/align_image_stack -a aligned4.tif $(cat /tmp/matchad | awk 'FNR == 1')
#tblend filter chain
   chain=$(echo $(yes "tblend=all_mode=average," | head -n $(echo $(grep 'jpg\|JPG\|tif\|tiff\|TIF\|TIFF' <<< $(cat /tmp/matchad | awk 'FNR == 1') | wc -w)-1 | bc -l)) | tr -d " ")
#producing the file
   ffmpeg -i aligned4.tif%04d.tif -pix_fmt rgb24 -vf $chain$crp_fix "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif
#metadata going back to tif again
   exiv2 -e X extract $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1)
   mv $(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1).xmp "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
   exiv2 -i X insert "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif 
#build a preview jpg
    ffmpeg -i "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".tif -pix_fmt rgb24 -y A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
#metadata going back to jpg preview
   mv "$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp A_previews
   exiv2 -i X insert A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".jpg
   rm A_previews/"$(cat /tmp/matchad | awk 'FNR == 1' | cut -d " " -f1 | cut -d "." -f1)"-"$(cat /tmp/matchad | awk 'FNR == 1' | grep -oE '[^ ]+$' | cut -d "." -f1)".xmp
#move original file
   mv $(cat /tmp/matchad | awk 'FNR == 1') A_ORIGINALS
if grep 'preview3' <<< $(cat /tmp/matchad | awk 'FNR == 1')
then
mv $(cat /tmp/matchad | awk 'FNR == 1' | perl -p -e 's/-preview3.jpg/.CR2/g') A_ORIGINALS
fi
   echo "$(tail -n +2 /tmp/matchad)" > /tmp/matchad
#erase 
   rm aligned4*.tif 
done
rm /tmp/HDR4.command /tmp/matchad
#check for multiple input folders
    if [ -d "$(cat /tmp/folder_paths.txt | awk 'FNR == 2')" ]
    then
    if ! grep 'HDR2.command\|HDR3.command\|HDR1.command' <<< $(ls /tmp/HDR2.command /tmp/HDR3.command /tmp/HDR1.command)
    then 
    echo "$(tail -n +2 /tmp/folder_paths.txt )" > /tmp/folder_paths.txt
sleep 1
    cd "$(cat /tmp/folder_paths.txt | awk 'FNR == 1')" 
    echo > /tmp/DUALISO/HDR_CR2
    . "$(cat /tmp/DUALISO/path_2)"/bash/HDR_CR2.command & sleep 1
    sleep 3 && open "$(cat /tmp/DUALISO/path_2)"/progress_bar.command &