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


#Will clean your files from aliasing. Slight movement needed at least...

#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"

#list files for multiprocessing
ls *.{MOV,mov,mp4,MP4,mkv,MKV,avi,AVI} > /tmp/alias_clean
split -l $(( $( wc -l < /tmp/alias_clean ) / 4 + 1 )) /tmp/alias_clean /tmp/alias_clean
rm /tmp/alias_clean

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanaa
then
cat <<'EOF' > /tmp/alias_script.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
echo "##################alias_script.command#####################" > alias_LOG.txt
#run the log file
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanaa; do
"$(cat /tmp/DUALISO/path_2)"/ffmpeg -i "$(cat /tmp/alias_cleanaa | head -1)" -i "$(cat /tmp/alias_cleanaa | head -1)" -filter_complex "[1] boxblur=1:cr=5:ar=5 [tmp]; [0][tmp] blend=all_mode='normal':all_opacity=0.5" -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf minterpolate=50,tblend=all_mode=average,framestep=2 "$(cat /tmp/alias_cleanaa | head -1 | cut -d "." -f1)"_clean.mov 2>> "$(cat /tmp/DUALISO/path_1)"/alias_LOG.txt
echo "$(tail -n +2 /tmp/alias_cleanaa)" > /tmp/alias_cleanaa
done
rm /tmp/alias_cleanaa
rm /tmp/alias_script.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanab
then
cat <<'EOF' > /tmp/alias_script1.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanab; do
"$(cat /tmp/DUALISO/path_2)"/ffmpeg -i "$(cat /tmp/alias_cleanab | head -1)" -i "$(cat /tmp/alias_cleanab | head -1)" -filter_complex "[1] boxblur=1:cr=5:ar=5 [tmp]; [0][tmp] blend=all_mode='normal':all_opacity=0.5" -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf minterpolate=50,tblend=all_mode=average,framestep=2 "$(cat /tmp/alias_cleanab | head -1 | cut -d "." -f1)"_clean.mov 2>> "$(cat /tmp/DUALISO/path_1)"/alias_LOG.txt
echo "$(tail -n +2 /tmp/alias_cleanab)" > /tmp/alias_cleanab
done
rm /tmp/alias_cleanab
rm /tmp/alias_script1.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanac
then
cat <<'EOF' > /tmp/alias_script2.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanac; do
"$(cat /tmp/DUALISO/path_2)"/ffmpeg -i "$(cat /tmp/alias_cleanac | head -1)" -i "$(cat /tmp/alias_cleanac | head -1)" -filter_complex "[1] boxblur=1:cr=5:ar=5 [tmp]; [0][tmp] blend=all_mode='normal':all_opacity=0.5" -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf minterpolate=50,tblend=all_mode=average,framestep=2 "$(cat /tmp/alias_cleanac | head -1 | cut -d "." -f1)"_clean.mov 2>> "$(cat /tmp/DUALISO/path_1)"/alias_LOG.txt
echo "$(tail -n +2 /tmp/alias_cleanac)" > /tmp/alias_cleanac
done
rm /tmp/alias_cleanac
rm /tmp/alias_script2.command
EOF
fi

if grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanad
then
cat <<'EOF' > /tmp/alias_script3.command
#!/bin/bash
cd "$(cat /tmp/DUALISO/path_1)"
while grep 'MOV\|mov\|mp4\|MP4\|mkv\|MKV\|avi\|AVI' /tmp/alias_cleanad; do
"$(cat /tmp/DUALISO/path_2)"/ffmpeg -i "$(cat /tmp/alias_cleanad | head -1)" -i "$(cat /tmp/alias_cleanad | head -1)" -filter_complex "[1] boxblur=1:cr=5:ar=5 [tmp]; [0][tmp] blend=all_mode='normal':all_opacity=0.5" -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -vf minterpolate=50,tblend=all_mode=average,framestep=2 -c:v libx264 -preset ultrafast -crf 0 -f matroska - | \
ffmpeg -i - -c:a copy -c:v prores_ks -profile:v 2 -pix_fmt yuv422p10 -color_primaries bt709 -color_trc bt709 -colorspace bt709 -vf minterpolate=50,tblend=all_mode=average,framestep=2 "$(cat /tmp/alias_cleanad | head -1 | cut -d "." -f1)"_clean.mov 2>> "$(cat /tmp/DUALISO/path_1)"/alias_LOG.txt
echo "$(tail -n +2 /tmp/alias_cleanad)" > /tmp/alias_cleanad
done
rm /tmp/alias_cleanad
rm /tmp/alias_script3.command
EOF
fi

chmod u=rwx /tmp/alias_script.command
chmod u=rwx /tmp/alias_script1.command
chmod u=rwx /tmp/alias_script2.command
chmod u=rwx /tmp/alias_script3.command

sleep 1 && open /tmp/alias_script.command &
sleep 1 && open /tmp/alias_script1.command &
sleep 1 && open /tmp/alias_script2.command &
sleep 1 && open /tmp/alias_script3.command &





