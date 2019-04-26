

    while grep -q 'CR2' /tmp/DUALISO/draglist_03
    do
    three=$(grep 'CR2' /tmp/DUALISO/draglist_03 | awk 'FNR == 1 {print}')
#Will add stored white balance settings to processed readymade dualiso DNG files
    echo "$(tail -n +2 /tmp/DUALISO/draglist_03)" > /tmp/DUALISO/draglist_03
#matching camera serial or not
    serial_match=$(exiftool "$three" | grep -A1 'Owner Name' | awk 'FNR == 2 {print $4; exit}')
    if ! [ "$serial" = "$serial_match" ]; then
    mkdir -p /tmp/DUALISO/DNG_C
    /Applications/Adobe\ DNG\ Converter.app/Contents/MacOS/Adobe\ DNG\ Converter -d /tmp/DUALISO/DNG_C "$three" 
    CAL=$(echo "$three" | cut -f1 -d".") 
    caltagA=$(exiftool /tmp/DUALISO/DNG_C/*.dng | awk '/Camera Calibration 1/ { print $5; exit }') 
    caltagB=$(exiftool /tmp/DUALISO/DNG_C/*.dng | awk '/Camera Calibration 1/ { print $13; exit }')
    rm -r /tmp/DUALISO/DNG_C
    fi
#check if the camera is an eos 100D
    model_match=$(exiftool "$three" | awk '/Camera Model Name/ { print $5,$6,$7,$8,$9,$10; exit }')
    echo "$model_match" > /tmp/DUALISO/model_match_A
    if grep 'Canon EOS 100D\|SL1\|Kiss X7\|X7' /tmp/DUALISO/model_match_A
    then
    exiftool "-ColorMatrix1=0.6985 -0.1611 -0.0397 -0.3596 1.0749 0.3295 -0.0349 0.1136 0.6512" "-ColorMatrix2=0.6602 -0.0841 -0.0939 -0.4472 1.2458 0.2247 -0.0975 0.2039 0.6148" "$(find "$three" | cut -f1 -d".")".DNG -overwrite_original ;
    fi  
    CR2_00=$(dcraw -i -v "$three" | awk '/Camera multipliers/ { print $4; exit }')
    CR2_01=$(dcraw -i -v "$three" | awk '/Camera multipliers/ { print $3; exit }') 
    CR2_01b=$(echo "$CR2_00"/"$CR2_01" | bc -l | awk 'FNR == 1 {print}')
    CR2_01b=$(echo "$CR2_01b/$caltagA" | bc -l | awk 'FNR == 1 {print}')
    CR2_00b=$(dcraw -i -v "$three" | awk '/Camera multipliers/ { print $6; exit }')
    CR2_02=$(dcraw -i -v "$three" | awk '/Camera multipliers/ { print $5; exit }') 
    CR2_02b=$(echo "$CR2_00b"/"$CR2_02" | bc -l | awk 'FNR == 1 {print}')
    CR2_02b=$(echo "$CR2_02b/$caltagB" | bc -l | awk 'FNR == 1 {print}')
#Add neccesssary tags for white balance with exiftool. Also rearrange illuminant tags
    exiftool "-AsShotNeutral=$CR2_01b 1 $CR2_02b" "-CalibrationIlluminant1=Standard Light A" "-CalibrationIlluminant2=D65" "$(echo $three | awk 'FNR == 1 {print; }' | cut -d "." -f1)".DNG -overwrite_original
    done