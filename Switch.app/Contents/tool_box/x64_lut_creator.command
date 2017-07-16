#requires pylut installed. Will resize your luts to 64x64x64 manageable in ffmpeg
#run sudo pip install pylut then double click this command file inside a folder with cube luts
#mainly to be able to optimize size of 3D cubes for use with ffmpeg

workingDir=`dirname "$0"`
cd "${workingDir}"
mkdir -p x64
ls *.cube > cube_list 

sleep 1000 & PID=$! 
while kill -0 $PID 2> /dev/null; do 
    printf  "▓"
    sleep 1
done &
clear
echo working!

while grep -q 'cube' cube_list
do
cat "cube_list" 1> /dev/null 2>&1 & 
cube=$(cat cube_list | sed 's/\(.*\)\..*/\1/' | head -1)   
echo "$(tail -n +2 cube_list)" > cube_list
pylut "$cube".cube --resize 64 --name x64/"$cube".cube 1> /dev/null 2>&1 & 

cat "cube_list" 1> /dev/null 2>&1 & 
cube=$(cat cube_list | sed 's/\(.*\)\..*/\1/' | head -1)   
echo "$(tail -n +2 cube_list)" > cube_list
pylut "$cube".cube --resize 64 --name x64/"$cube".cube 1> /dev/null 2>&1 & 

cat "cube_list" 1> /dev/null 2>&1 & 
cube=$(cat cube_list | sed 's/\(.*\)\..*/\1/' | head -1)   
echo "$(tail -n +2 cube_list)" > cube_list
pylut "$cube".cube --resize 64 --name x64/"$cube".cube 1> /dev/null 2>&1 & 

cat "cube_list" 1> /dev/null 2>&1 &
cube=$(cat cube_list | sed 's/\(.*\)\..*/\1/' | head -1)    
echo "$(tail -n +2 cube_list)" > cube_list

sleep 1
pylut "$cube".cube --resize 64 --name x64/"$cube".cube 1> /dev/null 2>&1 
done

while pgrep -l pylut 
do
  sleep 1
done
kill $(ps aux | pgrep bash)
kill $(ps aux | pgrep sleep)
rm cube_list
osascript -e 'tell application "Terminal" to close first window' & exit &