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


#export files to h264 format

#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"

#list files for multiprocessing
ls *.{MOV,mov,mp4,MP4,mkv,MKV,avi,AVI} > /tmp/web_h264
split -l $(( $( wc -l < /tmp/web_h264 ) / 4 + 1 )) /tmp/web_h264 /tmp/web_h264
rm /tmp/web_h264

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264aa
then
cat <<'EOF' > /tmp/web_script.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
echo "##################web_script.command#####################" > web_LOG.txt
#run the log file
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264aa; do
ffmpeg -i "$(cat /tmp/web_h264aa | head -1)" -c:v libx264 -preset ultrafast -crf 20 "$(cat /tmp/web_h264aa | head -1 | cut -d "." -f1)"_h264.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/web_h264aa)" > /tmp/web_h264aa
done
rm /tmp/web_h264aa
rm /tmp/web_script.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ab
then
cat <<'EOF' > /tmp/web_script1.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ab; do
ffmpeg -i "$(cat /tmp/web_h264ab | head -1)" -c:v libx264 -preset ultrafast -crf 20 "$(cat /tmp/web_h264ab | head -1 | cut -d "." -f1)"_h264.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/web_h264ab)" > /tmp/web_h264ab
done
rm /tmp/web_h264ab
rm /tmp/web_script1.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ac
then
cat <<'EOF' > /tmp/web_script2.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ac; do
ffmpeg -i "$(cat /tmp/web_h264ac | head -1)" -c:v libx264 -preset ultrafast -crf 20 "$(cat /tmp/web_h264ac | head -1 | cut -d "." -f1)"_h264.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/web_h264ac)" > /tmp/web_h264ac
done
rm /tmp/web_h264ac
rm /tmp/web_script2.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ad
then
cat <<'EOF' > /tmp/web_script3.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/web_h264ad; do
ffmpeg -i "$(cat /tmp/web_h264ad | head -1)" -c:v libx264 -preset ultrafast -crf 20 "$(cat /tmp/web_h264ad | head -1 | cut -d "." -f1)"_h264.mov 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
echo "$(tail -n +2 /tmp/web_h264ad)" > /tmp/web_h264ad
done
rm /tmp/web_h264ad
rm /tmp/web_script3.command
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
chmod u=rwx /tmp/web_script.command
chmod u=rwx /tmp/web_script1.command
chmod u=rwx /tmp/web_script2.command
chmod u=rwx /tmp/web_script3.command

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

sleep 1 && open /tmp/web_script.command &
sleep 1 && open /tmp/web_script1.command &
sleep 1 && open /tmp/web_script2.command &
sleep 1 && open /tmp/web_script3.command &





