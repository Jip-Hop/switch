while grep 'CR2' /tmp/DUALISO/LISTac >/dev/null 2>&1
do 
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge -b 16 -a $(cat /tmp/DUALISO/LISTac | awk 'FNR == 1')
mv $(cat /tmp/DUALISO/LISTac | awk 'FNR == 1') A_ORIGINALS
echo "$(tail -n +2 /tmp/DUALISO/LISTac)" > /tmp/DUALISO/LISTac
done
rm /tmp/DUALISO/LISTac