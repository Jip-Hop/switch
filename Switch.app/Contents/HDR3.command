#HDRCR2 settings
    if [ -f /tmp/HDRCR2_settings ]
    then
    HDR="$(cat /tmp/"HDRCR2_settings" | perl -p -e 's/^[ \t]*//')"
    fi
while grep 'CR2' /tmp/DUALISO/LISTac >/dev/null 2>&1
do 
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -a $(cat /tmp/DUALISO/LISTac | awk 'FNR == 1')
mv $(cat /tmp/DUALISO/LISTac | awk 'FNR == 1') A_ORIGINALS
echo "$(tail -n +2 /tmp/DUALISO/LISTac)" > /tmp/DUALISO/LISTac
done
rm /tmp/DUALISO/LISTac