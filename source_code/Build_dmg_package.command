#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

#A MAKE like solution which copies changes made in source txt files and migrates the changes into cr2hdr.app and at the end creates a dmg package


#simple command to rename txt scripts to .command and copy these to MLP content folder.

xattr -d com.apple.quarantine ../cr2hdr.app

for file in *.txt; do
    mv "$file" "`basename $file .txt`.command"

yes | cp *.command  ../cr2hdr.app/Contents
done

for file in *.command; do
    mv "$file" "`basename $file .command`.txt" 
done

mv Build_dmg_package.txt Build_dmg_package.command

rm ../cr2hdr.app/Contents/Build_dmg_package.command
rm ../cr2hdr.app/Contents/cr2hdr_MAIN.command

cd ../

#Script originally for MLVFS
#https://bitbucket.org/dmilligan/mlvfs/src/9f8191808407bb49112b9ab14c27053ae5022749/build_installer.sh?at=master&fileviewer=file-view-default

# A lot of this script came from here:
# http://stackoverflow.com/questions/96882/how-do-i-create-a-nice-looking-dmg-for-mac-os-x-using-command-line-tools

source="install_temp"
title="cr2hdr"
finalDMGName="cr2hdr.dmg"
size=100000

mkdir "${source}"
cp -R cr2hdr.app "${source}"
cp -R source_code "${source}"
cp LICENSE "${source}"
cp HOWTO.txt "${source}"

#remove any previously existing build
rm -f "${finalDMGName}"

hdiutil create -srcfolder "${source}" -volname "${title}" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${size}k pack.temp.dmg
device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')
sleep 2
chmod -Rf go-w /Volumes/"${title}"
sync
sync
hdiutil detach ${device}
hdiutil convert "pack.temp.dmg" -format UDZO -imagekey zlib-level=9 -o "${finalDMGName}"
rm -f pack.temp.dmg
rm -R "${source}"


