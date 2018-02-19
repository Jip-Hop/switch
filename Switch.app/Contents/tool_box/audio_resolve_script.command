#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

#dependencies
#exiftool
#bwfmetaedit

#script that will add metadata and rename every folder directory according to Davinci resolve specs

#usage:
#double click the script audio_resolve_script.command inside a folder containing dng folders and the included "bin" folder
#to be able to use the script audio_resolve_script.command it needs root privileges so add following:
#chmod u=rwx audio_resolve_script.command then hit enter. Now you can double click the script

#set export path to existing folder
    export PATH="${workingDir}"/bin:$PATH
#let´s clean
    rm audio.xml
    rm folderlist
#list directories
    ls -d M*/ | cut -d "/" -f1 > folderlist
    while ! [ x"$(cat folderlist)" = x ]
    do 
    cd $(cat "folderlist" | head -1)
    FPS=$(echo $(exiftool *000000.dng | grep 'Frame Rate' | awk '{print $4; exit}')*1000 | bc -l | cut -d "." -f1)
#check for wav file and add necessary metadata
    if ls *.WAV >/dev/null 2>&1
    then
#safety checks
    if [ -f ../bin/bwfmetaedit ] && [ -f ../bin/exiftool ]
    then
#Black magic audio tag copied from Dmilligan(mlvfs)
echo "<?xml version="\"1.0"\" encoding="\"UTF-8"\"?><BWFXML><IXML_VERSION>1.5</IXML_VERSION><PROJECT>Magic Lantern</PROJECT><NOTE></NOTE><CIRCLED>FALSE</CIRCLED><BLACKMAGIC-KEYWORDS></BLACKMAGIC-KEYWORDS><TAPE>1</TAPE><SCENE>1</SCENE><BLACKMAGIC-SHOT>1</BLACKMAGIC-SHOT><TAKE>1</TAKE><BLACKMAGIC-ANGLE>ms</BLACKMAGIC-ANGLE><SPEED><MASTER_SPEED>$FPS/1000</MASTER_SPEED><CURRENT_SPEED>$FPS/1000</CURRENT_SPEED><TIMECODE_RATE>$FPS/1000</TIMECODE_RATE><TIMECODE_FLAG>NDF</TIMECODE_FLAG></SPEED></BWFXML>" > ../audio.xml
#Add metadata information to the wav file
    bwfmetaedit *.WAV --in-iXML=../audio.xml
    else
    clear
    echo $(tput bold)$(tput setaf 1)"necessary binaries are missing"$(tput sgr0)
    exit 0
    fi
    fi
    cd ../
    rm audio.xml
#if already renamed then skip it
    if ! grep 'C0000' <<< $(cat "folderlist" | head -1) >/dev/null 2>&1
    then    
    mv $(cat "folderlist" | head -1) $(cat "folderlist" | head -1)_C0000
    fi
    echo "$(tail -n +2 folderlist)" > folderlist
    done
#the end
    rm folderlist