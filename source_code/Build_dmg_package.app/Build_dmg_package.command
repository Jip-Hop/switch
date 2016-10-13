#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"


#simple command to rename txt scripts to .command and copy these to MLP content folder.

for file in ../*.txt; do
    mv "$file" ../"`basename $file .txt`.command"

yes | cp ../*.command  ../../cr2hdr.app/Contents
done

for file in ../*.command; do
    mv "$file" ../"`basename $file .command`.txt" 
done

rm ../../cr2hdr.app/Contents/Build_dmg_package.command
rm ../../cr2hdr.app/Contents/dualiso_to_DNG_MAIN.command


