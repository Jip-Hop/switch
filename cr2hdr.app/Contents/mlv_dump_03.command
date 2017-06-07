#Processing MLV files into folders with dng files
    while ! [ x"$(cat /tmp/DUALISO/MLVFILESac)" = x ]
    do 
    FILE=$(cat /tmp/DUALISO/"MLVFILESac" | head -1 | grep -v 'avg_\|ft_')
    date=$(mlv_dump -m -v "$FILE" | grep 'Date' | head -1 | awk 'FNR == 1 {print $2}')
    date_01=$(echo "$date" | head -c2)
    date_02=$(echo "$date" | cut -c4-5)
    date_03=$(echo "$date" | cut -c7-10)
    date=$(echo "$date_03"-"$date_02"-"$date_01""_0001_C0000")
#will add a dummy file if darkframe averaging is done. Will rename back with prefix before moving to mlv_raw_original folder
    if grep 'a_' <<< "$FILE"
    then
    FILEn=$(echo "$FILE" | cut -c3-)
    mv "$FILE" "$FILEn"
    FILE=$FILEn
    BASE=`echo "$FILE" | cut -d "." -f1`;
    mkdir "$O""${BASE}"
    echo > "$O""${BASE}"/avg
    else
    BASE=`echo $FILE | cut -d "." -f1`;
    mkdir "$O""${BASE}"
    fi
    mv "$O""${BASE}" "$O""${BASE}_1_$date" 
#check for output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv "$FILE" "${BASE}_1_$date"
    mv "$BASE".M* "${BASE}_1_$date"
#check for white balance(WB) file
    mv "$BASE".WB "${BASE}_1_$date"
#allbadpixel.map handling
    if ls *"$BASE".map
    then
    mv "$BASE".map "${BASE}_1_$date"/allbadpixels.map
    mv a_"$BASE".map "${BASE}_1_$date"/allbadpixels.map
    else
#check for external allbadpixel.map file
    if ls allbadpixels.map
    then
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    fi
#move any additional pixel list from within root folder
    if ls *.xls
    then
    mv *.xls allbadpixels.txt
    tail -n +2 allbadpixels.txt | awk '{print $2,"	 "$3"	 0"}' >> allbadpixels.map
    rm allbadpixels.txt
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    fi
#move any additional pixel list from within root folder
    if ls allbadpixels.txt
    then
    tail -n +2 allbadpixels.txt | awk '{print $2,"	 "$3"	 0"}' >> allbadpixels.map
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    rm allbadpixels.txt
    fi
#move any additional pixel list from within root folder
    if ls deadpixels.txt
    then
    mv deadpixels.txt allbadpixels.map
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    fi
    fi
    cd "${BASE}_1_$date"
    fi
#mlv_dump settings
#Uncompressed setting then
    if [ -f /tmp/mlv_dump_UNC ]
    then
    rm /tmp/mlv_dump_settings
    mlv="$(cat /tmp/"mlv_dump_UNC" | perl -p -e 's/^[ \t]*//')"
    else
    if grep '10\|12' <<< $(mlv_dump -v "$FILE" | grep 'bits_per_pixel' | awk 'FNR == 1 {print $2; }')
    then
    mlv="$(cat /tmp/"mlv_dump_settings" | perl -pi -e 's/ -c//g' 2>/dev/null | perl -p -e 's/^[ \t]*//')"
    else
    mlv="$(cat /tmp/"mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"
    fi
    fi
#create second output
    if ! [ x"$(cat /tmp/output)" = x ]
    then
    mkdir -p "$(cat /tmp/output)"
    O2="$O${BASE}_1_$date"/
#dfort focus pixel list in case you change output
    if ls /tmp/DUALISO/crop_rec
    then
    fpm.sh -m crop_rec -o "$O2"allbadpixels.map "$(cat /tmp/DUALISO/path_1)"/"$FILE"
    else
    fpm.sh -o "$O2"allbadpixels.map "$(cat /tmp/DUALISO/path_1)"/"$FILE"   
    fi 
#enter new output
    cd "$O2"
#extract dng frames
    mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat /tmp/DUALISO/path_1)"/"$FILE" 
    cd "$(cat /tmp/DUALISO/path_1)"/
    else
#extract dng frames
    mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" 
    fi 
#tail the MLVprogress_bar list
    echo "$(tail -n +2 /tmp/DUALISO/MLVprogress_bar)" > /tmp/DUALISO/MLVprogress_bar
#try to determine if shooting footage with 3x3mv720cropmode
    if ls /tmp/DUALISO/crop_rec
    then
    if [ $(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Default Scale/ { print $5;}') = 1.666666667 ]
    then
    find "$O2". -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 1/1"
    fi
    fi
#syncs audio to amount of dng frames
    FPS=$(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Frame Rate/ { print $4; }')      
    frct_result=$(echo $frct/$FPS | bc -l | awk 'FNR == 1 {print}')
#cut audio  
    ffmpeg -ss 0 -t $frct_result -i "$O2""${BASE}_1_$date"_.wav "$O2""${BASE}_1_$date".wav ;
    rm "$O2""${BASE}_1_$date"_.wav
#adding fps to wav metadata
    fps_au=$(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Frame Rate/ { print $4; }' | tr -d . )
#adding zeros
    num="$fps_au"
    len=`echo ${#num}`
    while [ $len -lt 5 ];
    do
        num=$num"0"
        let len=len+1
    done
    FPS=$(echo $num)
#Black magic audio tag copied from Dmilligan(mlvfs)
echo "<?xml version="\"1.0"\" encoding="\"UTF-8"\"?><BWFXML><IXML_VERSION>1.5</IXML_VERSION><PROJECT>Magic Lantern</PROJECT><NOTE></NOTE><CIRCLED>FALSE</CIRCLED><BLACKMAGIC-KEYWORDS></BLACKMAGIC-KEYWORDS><TAPE>1</TAPE><SCENE>1</SCENE><BLACKMAGIC-SHOT>1</BLACKMAGIC-SHOT><TAKE>1</TAKE><BLACKMAGIC-ANGLE>ms</BLACKMAGIC-ANGLE><SPEED><MASTER_SPEED>$FPS/1000</MASTER_SPEED><CURRENT_SPEED>$FPS/1000</CURRENT_SPEED><TIMECODE_RATE>$FPS/1000</TIMECODE_RATE><TIMECODE_FLAG>NDF</TIMECODE_FLAG></SPEED></BWFXML>" > /tmp/DUALISO/audio.xml
#Add metadata information to the wav file
    bwfmetaedit "$O2""${BASE}_1_$date".wav --in-iXML=/tmp/DUALISO/audio.xml
#grabs the white balance tag and saves it for later  
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }') 
#move mlv originals to folder 
#Check for darkframe workflow
    if ls "$O2"avg
    then
    mv -i "${BASE}".MLV "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/a_"${BASE}".MLV ;
    rm "$O2"avg
    else
    mkdir -p "$(cat /tmp/output)"
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv -i "${BASE}".MLV "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS ;
    mv -i "${BASE}".M* "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS ;
    else
    mkdir -p "$(cat /tmp/output)"
    fi
    fi
#Stored cr2hdr settings
    set=$(cat /tmp/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
#disable dualiso automation
    if ls /tmp/dualisodisable
    then
#check for imageJ multipoint white balance file
    if [ -f "$BASE".WB ]
    then
    . "$path_2"Contents/awb3.command
#check for new output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv "$BASE".WB "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS
    fi
    else
#check if cam was set to auto white balance. Non dualiso
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A4 'Block: WBAL' | awk 'FNR == 5 {print $2}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
#check for new output location
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/path_1)"/"$FILE" | grep -A4 'Block: WBAL' | awk 'FNR == 5 {print $2}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
    fi
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    else
#Verify dualiso or else continue to next file
    cr2hdr $set "$O2""${BASE}"_1_"$date"_000000.dng | tee /tmp/DUALISO/dualiso.txt 
    if ! grep 'look like interlaced ISO' /tmp/DUALISO/dualiso.txt
    then
    rm /tmp/DUALISO/dualiso.txt
#cr2hdr processing
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P $(sysctl -n hw.physicalcpu) -n 1 cr2hdr $set 
#grabs white level
    wle=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.SubImage1.WhiteLevel/ { print $4; }')
#check if cam was set to auto white balance
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A4 'Block: WBAL' | awk 'FNR == 5 {print $2}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
#grabs the white balance tag and saves it for later  
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
#adds back correct white balance tag and also sets the same whitelevel to prevent flicker
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.DNG' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi" -M"set Exif.SubImage1.WhiteLevel $wle"
    else
#check for imageJ multipoint white balance file
    if [ -f "$BASE".WB ]
    then
    . "$path_2"Contents/awb3.command
#check for new output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv "$BASE".WB "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS
    fi
    else 
#check for new output location
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/path_1)"/"$FILE" | grep -A4 'Block: WBAL' | awk 'FNR == 5 {print $2}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    fi
#check if cam was set to auto white balance. Non dualiso
    if [ "$(mlv_dump -v -m "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A4 'Block: WBAL' | awk 'FNR == 5 {print $2}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    fi
    fi
    fi
    fi
#check output
    if [ x"$(cat /tmp/output)" = x ]
    then
    cd ..
    fi
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/MLVFILESac)" > /tmp/DUALISO/MLVFILESac
    done