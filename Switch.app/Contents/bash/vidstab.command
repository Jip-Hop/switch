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


#export files to prores and stabilized

#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"

#list files for multiprocessing
ls *.{MOV,mov,mp4,MP4,mkv,MKV,avi,AVI} >/dev/null 2>&1 > /tmp/vid_stab
split -l $(( $( wc -l < /tmp/vid_stab ) / 4 + 1 )) /tmp/vid_stab /tmp/vid_stab
rm /tmp/vid_stab

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabaa
then
cat <<'EOF' > /tmp/vid_stab.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
echo "##################vid_stab.command#####################" > web_LOG.txt
#run the log file
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabaa; do
ffmpeg -i "$(cat /tmp/vid_stabaa | head -1)" -vf vidstabdetect=shakiness=10:accuracy=10:result=transform_vectors.trf -f null -
ffmpeg -i "$(cat /tmp/vid_stabaa | head -1)" -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf vidstabtransform=input=transform_vectors.trf:smoothing=10,unsharp=5:5:0.8:3:3:0.4 "$(cat /tmp/vid_stabaa | head -1 | cut -d "." -f1)"_stbz.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/vid_stabaa)" > /tmp/vid_stabaa
rm "$(cat /tmp/DUALISO/path_1)"/transform_vectors.trf
done
rm /tmp/vid_stabaa
rm /tmp/vid_stab.command
osascript -e 'tell application "Terminal" to close (every window whose name contains "vid_stab.command")' & exit
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabab
then
cat <<'EOF' > /tmp/vid_stab1.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabab; do
ffmpeg -i "$(cat /tmp/vid_stabab | head -1)" -vf vidstabdetect=shakiness=10:accuracy=10:result=transform_vectors1.trf -f null -
ffmpeg -i "$(cat /tmp/vid_stabab | head -1)" -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf vidstabtransform=input=transform_vectors1.trf:smoothing=10,unsharp=5:5:0.8:3:3:0.4 "$(cat /tmp/vid_stabab | head -1 | cut -d "." -f1)"_stbz.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/vid_stabab)" > /tmp/vid_stabab
rm "$(cat /tmp/DUALISO/path_1)"/transform_vectors1.trf
done
rm /tmp/vid_stabab
rm /tmp/vid_stab1.command
osascript -e 'tell application "Terminal" to close (every window whose name contains "vid_stab1.command")' & exit
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabac
then
cat <<'EOF' > /tmp/vid_stab2.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabac; do
ffmpeg -i "$(cat /tmp/vid_stabac | head -1)" -vf vidstabdetect=shakiness=10:accuracy=10:result=transform_vectors2.trf -f null -
ffmpeg -i "$(cat /tmp/vid_stabac | head -1)" -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf vidstabtransform=input=transform_vectors2.trf:smoothing=10,unsharp=5:5:0.8:3:3:0.4 "$(cat /tmp/vid_stabac | head -1 | cut -d "." -f1)"_stbz.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/vid_stabac)" > /tmp/vid_stabac
rm "$(cat /tmp/DUALISO/path_1)"/transform_vectors2.trf
done
rm /tmp/vid_stabac
rm /tmp/vid_stab2.command
osascript -e 'tell application "Terminal" to close (every window whose name contains "vid_stab2.command")' & exit
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabad
then
cat <<'EOF' > /tmp/vid_stab3.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/vid_stabad; do
ffmpeg -i "$(cat /tmp/vid_stabad | head -1)" -vf vidstabdetect=shakiness=10:accuracy=10:result=transform_vectors3.trf -f null -
ffmpeg -i "$(cat /tmp/vid_stabad | head -1)" -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf vidstabtransform=input=transform_vectors3.trf:smoothing=10,unsharp=5:5:0.8:3:3:0.4 "$(cat /tmp/vid_stabad | head -1 | cut -d "." -f1)"_stbz.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/vid_stabad)" > /tmp/vid_stabad
rm "$(cat /tmp/DUALISO/path_1)"/transform_vectors3.trf
done
rm /tmp/vid_stabad
rm /tmp/vid_stab3.command
osascript -e 'tell application "Terminal" to close (every window whose name contains "vid_stab3.command")' & exit
EOF
fi


#ffmpeg
cat <<'EOF' > /tmp/depend.command
#!/bin/bash
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
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ffmpeg
if [ -f "/usr/local/bin/ffmpeg" ]
then
clear && echo "ffmpeg is installed and ready for use"
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
;;
esac
fi
rm /tmp/depend.command
EOF

chmod u=rwx /tmp/depend.command
chmod u=rwx /tmp/vid_stab.command
chmod u=rwx /tmp/vid_stab1.command
chmod u=rwx /tmp/vid_stab2.command
chmod u=rwx /tmp/vid_stab3.command

if ! [ -f "/usr/local/bin/ffmpeg" ]
then
sleep 1;
#start looking for dependencies
open /tmp/depend.command
while ls /tmp/depend.command
do 
wait 1
done
else 
rm /tmp/depend.command
fi

sleep 1 && open /tmp/vid_stab.command &
sleep 1 && open /tmp/vid_stab1.command &
sleep 1 && open /tmp/vid_stab2.command &
sleep 1 && open /tmp/vid_stab3.command &

osascript -e 'tell application "Terminal" to close (every window whose name contains "vidstab.command")' & exit

