while grep 'CR2' /tmp/DUALISO/LISTad >/dev/null 2>&1
do 
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge -b 16 -a $(cat /tmp/DUALISO/LISTad | awk 'FNR == 1')
mv $(cat /tmp/DUALISO/LISTad | awk 'FNR == 1') A_ORIGINALS
echo "$(tail -n +2 /tmp/DUALISO/LISTad)" > /tmp/DUALISO/LISTad
done
rm /tmp/DUALISO/LISTad