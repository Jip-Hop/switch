#HDRCR2 settings
    if [ -f /tmp/HDRCR2_settings ]
    then
    HDR="$(cat /tmp/"HDRCR2_settings" | perl -p -e 's/^[ \t]*//')"
    fi
while grep 'CR2' /tmp/DUALISO/LISTad >/dev/null 2>&1
do 
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge $HDR -a $(cat /tmp/DUALISO/LISTad | awk 'FNR == 1')
mv $(cat /tmp/DUALISO/LISTad | awk 'FNR == 1') A_ORIGINALS
echo "$(tail -n +2 /tmp/DUALISO/LISTad)" > /tmp/DUALISO/LISTad
done
rm /tmp/DUALISO/LISTad