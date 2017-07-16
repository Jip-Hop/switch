workingDir=`dirname "$0"`
cd "${workingDir}"
export PATH="$(cat /tmp/DUALISO/path_2):$PATH"
#dependencies(dcraw, Imagemagick)

#Testing out ideas around auto white balance through image_magick

#handle white space
   OLDIFS=$IFS
   IFS=$'\n'
#iterate over dng files
   if [ -f "$(ls *.dng | head -1)" ]
   then
   for dng in *.dng
   do
   echo "$dng"
#x,y coordinates. Pipe output to convert resize for speed reason
   x=$(dcraw -T -h -c -a $dng | convert  -resize 10% - 2>/dev/null -auto-level -threshold 90% txt:- | grep white | head -1 | awk '{print $1}' | cut -f1 -d",") 
   y=$(dcraw -T -h -c -a $dng | convert  -resize 10% - 2>/dev/null -auto-level -threshold 90% txt:- | grep white | head -1 | awk '{print $1}' | cut -f2 -d"," | cut -f1 -d":")
#output tiff and apply white balance multipliers derived from whitest area on output 
   dcraw -6 -T -W -A "$(($x * 10))"  "$(($y * 10))" 10 10 "$dng"
#rename
   tiff=`echo "$dng" | cut -d "." -f1`;
   mv $tiff.tiff "$tiff"_IM.tiff
#compare with dcraw auto white balance
   dcraw -T -a -W "$dng"
#rename
   tiff=`echo "$dng" | cut -d "." -f1`;
   mv $tiff.tiff "$tiff"_DC.tiff
   done
   fi

#iterate over CR2 files
   if [ -f "$(ls *.CR2 | head -1)" ]
   then
   for CR2 in *.CR2
   do
   echo "$CR2"
#x,y coordinates. Pipe output to convert resize for speed reason
   x=$(dcraw -T -h -c -a $CR2 | convert  -resize 10% - 2>/dev/null -auto-level -threshold 90% txt:- | grep white | head -1 | awk '{print $1}' | cut -f1 -d",") 
   y=$(dcraw -T -h -c -a $CR2 | convert  -resize 10% - 2>/dev/null -auto-level -threshold 90% txt:- | grep white | head -1 | awk '{print $1}' | cut -f2 -d"," | cut -f1 -d":")
#output tiff and apply white balance multipliers derived from whitest area on output 
   dcraw -T -W -A "$(($x * 10))"  "$(($y * 10))" 10 10 "$CR2"
#rename
   tiff=`echo "$CR2" | cut -d "." -f1`;
   mv $tiff.tiff "$tiff"_IM.tiff
#compare with dcraw auto white balance
   dcraw -T -a -W "$CR2"
#rename
   tiff=`echo "$CR2" | cut -d "." -f1`;
   mv $tiff.tiff "$tiff"_DC.tiff
   done
   fi
#end whitespace handling
   IFS=$OLDIFS

exit 0