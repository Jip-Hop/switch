#useful when comparing metadata on all files inside a folder. 
#usage. put in folder with dng files and then doubleclick

workingDir=`dirname "$0"`
cd "${workingDir}"
rm list
rm dng_diff

bold="$(tput bold)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"

sleep 1000 & PID=$! 
while kill -0 $PID 2> /dev/null; do 
clear
echo "$(tput setaf 0)""$(tput bold)""Searching for changes in metadata. Might take a while."
echo "
$(cat list| wc -l) files left to check."
    sleep 3
done &
find . -maxdepth 1 -name '*.dng' > list
echo "$(tail -n +2 list)" > list
sleep 0.5
while grep -q 'dng' list
do 
output1=$(exiftool *000000.dng | grep -v 'ExifTool Version Number\|File Name\|Directory\|File Size\|File Modification Date/Time\|File Access Date/Time\|File Inode Change Date/Time\|File Permissions\|File Type\|File Type Extension\|MIME Type\|Modify Date\|Date/Time Original\|Date/Time Original\|Modify Date\|Sub Sec Time\|Sub Sec Time Original\|Time Codes\|Strip Byte Counts\|Strip Offsets') ;
output2=$(exiftool "$(cat list | head -1)" | grep -v 'ExifTool Version Number\|File Name\|Directory\|File Size\|File Modification Date/Time\|File Access Date/Time\|File Inode Change Date/Time\|File Permissions\|File Type\|File Type Extension\|MIME Type\|Modify Date\|Date/Time Original\|Date/Time Original\|Modify Date\|Sub Sec Time\|Sub Sec Time Original\|Time Codes\|Strip Byte Counts\|Strip Offsets') ;
echo "$(tail -n +2 list)" > list
if ! [ X"$(diff <(echo "$output1") <(echo "$output2"))" = X ]
then 
echo "$(diff <(echo "$output1") <(echo "$output2"))" >> dng_diff
fi
done
kill $(ps aux | pgrep sleep)
rm list
if ls dng_diff
then
clear 
echo "$(tput bold)""$(tput setaf 1)""metadata has changed in files, check your dng_diff file""$(tput sgr0)""$(tput setaf 0)"
sleep 2 
else
clear
echo "$(tput bold)""$(tput setaf 2)""All seems fine, no metadata changes""$(tput sgr0)""$(tput setaf 0)"
sleep 2
fi




