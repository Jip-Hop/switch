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


#export files to average png format

#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"

#list files for multiprocessing
ls *.{MOV,mov,mp4,MP4,mkv,MKV,avi,AVI} > /tmp/avr
split -l $(( $( wc -l < /tmp/avr ) / 4 + 1 )) /tmp/avr /tmp/avr
rm /tmp/avr

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avraa
then
cat <<'EOF' > /tmp/avr_script.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
echo "##################avr_script.command#####################" > web_LOG.txt
#run the log file
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avraa; do
rot=$(exiftool "$(cat /tmp/avraa | head -1)" | grep 'Rotation' | cut -d ":" -f2)
if [ $rot == 90 ] 
then
ffmpeg -i "$(cat /tmp/avraa | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf transpose=2,tmix=frames=50 -frames 1 "$(cat /tmp/avraa | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
else
ffmpeg -i "$(cat /tmp/avraa | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf tmix=frames=50 -frames 1 "$(cat /tmp/avraa | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
fi
echo "$(tail -n +2 /tmp/avraa)" > /tmp/avraa
done
rm /tmp/avraa
rm /tmp/avr_script.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrab
then
cat <<'EOF' > /tmp/avr_script1.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrab; do
rot=$(exiftool "$(cat /tmp/avraa | head -1)" | grep 'Rotation' | cut -d ":" -f2)
if [ $rot == 90 ] 
then
ffmpeg -i "$(cat /tmp/avrab | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf transpose=2,tmix=frames=50 -frames 1 "$(cat /tmp/avrab | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
else
ffmpeg -i "$(cat /tmp/avrab | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf tmix=frames=50 -frames 1 "$(cat /tmp/avrab | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
fi
echo "$(tail -n +2 /tmp/avrab)" > /tmp/avrab
done
rm /tmp/avrab
rm /tmp/avr_script1.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrac
then
cat <<'EOF' > /tmp/avr_script2.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrac; do
rot=$(exiftool "$(cat /tmp/avraa | head -1)" | grep 'Rotation' | cut -d ":" -f2)
if [ $rot == 90 ] 
then
ffmpeg -i "$(cat /tmp/avrac | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf transpose=2,tmix=frames=50 -frames 1 "$(cat /tmp/avrac | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
else
ffmpeg -i "$(cat /tmp/avrac | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf tmix=frames=50 -frames 1 "$(cat /tmp/avrac | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
fi
echo "$(tail -n +2 /tmp/avrac)" > /tmp/avrac
done
rm /tmp/avrac
rm /tmp/avr_script2.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrad
then
cat <<'EOF' > /tmp/avr_script3.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/avrad; do
rot=$(exiftool "$(cat /tmp/avraa | head -1)" | grep 'Rotation' | cut -d ":" -f2)
if [ $rot == 90 ] 
then
ffmpeg -i "$(cat /tmp/avrad | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf transpose=2,tmix=frames=50 -frames 1 "$(cat /tmp/avrad | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
else
ffmpeg -i "$(cat /tmp/avrad | head -1)" -pix_fmt rgb48 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf tmix=frames=50 -frames 1 "$(cat /tmp/avrad | head -1 | cut -d "." -f1)".png 2>> "$(cat /tmp/DUALISO/path_1)"/web_LOG.txt
fi
echo "$(tail -n +2 /tmp/avrad)" > /tmp/avrad
done
rm /tmp/avrad
rm /tmp/avr_script3.command
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
rm /tmp/depend.command
EOF


chmod u=rwx /tmp/depend.command
chmod u=rwx /tmp/avr_script.command
chmod u=rwx /tmp/avr_script1.command
chmod u=rwx /tmp/avr_script2.command
chmod u=rwx /tmp/avr_script3.command

if [ -f "/usr/local/bin/ffmpeg" ] && [ -f "/usr/local/bin/exiftool" ]
then
rm /tmp/depend.command
else 
sleep 1;
#start looking for dependencies
open /tmp/depend.command
while ls /tmp/depend.command
do 
wait 1
done
fi

sleep 1 && open /tmp/avr_script.command &
sleep 1 && open /tmp/avr_script1.command &
sleep 1 && open /tmp/avr_script2.command &
sleep 1 && open /tmp/avr_script3.command &





