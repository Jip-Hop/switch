while grep 'CR2' /tmp/DUALISO/LISTab >/dev/null 2>&1
do 
/Applications/HDRMerge.app/Contents/MacOS/hdrmerge -b 16 -a $(cat /tmp/DUALISO/LISTab| awk 'FNR == 1')
mv $(cat /tmp/DUALISO/LISTab | awk 'FNR == 1') A_ORIGINALS
echo "$(tail -n +2 /tmp/DUALISO/LISTab)" > /tmp/DUALISO/LISTab
done
rm /tmp/DUALISO/LISTab