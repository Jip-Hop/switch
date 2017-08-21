#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    map=$(printf "%s\n" fpm)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    map=$(printf "%s\n" map)
    fi
#check for new output folder
    if [ -f ~/Switch/config/output ]
    then
    mkdir -p "$(cat ~/Switch/config/output)"
    O=$(cat ~/Switch/config/"output")/
    fi
#Processing MLV files into folders with dng files
    while ! [ x"$(cat ~/Switch/config/tmp/MLVFILESaa)" = x ]
    do 
    FILE=$(cat ~/Switch/config/tmp/"MLVFILESaa" | head -1 | grep -v 'avg_\|ft_')
    date=$($mlv_dump -m -v "$FILE" | grep 'Date' | head -1 | awk 'FNR == 1 {print $2}')
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
    if [ x"$(cat ~/Switch/config/output)" = x ]
    then
    mv "$FILE" "${BASE}_1_$date"
    mv "$BASE".M* "${BASE}_1_$date"
#check for white balance(WB) file
    mv "$BASE".WB "${BASE}_1_$date"
#allbadpixel.map handling
    if ls *"$BASE".$map 
    then
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    mv "$BASE".$map "${BASE}_1_$date"/"$BASE".$map
    mv a_"$BASE".$map "${BASE}_1_$date"/"$BASE".$map
    else
    mv "$BASE".$map "${BASE}_1_$date"/allbadpixels.$map
    mv a_"$BASE".$map "${BASE}_1_$date"/allbadpixels.$map
    fi
    else
#check for external allbadpixel.map file
    if [ -f allbadpixels.map ]
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
    if [ -f allbadpixels.txt ]
    then
    tail -n +2 allbadpixels.txt | awk '{print $2,"	 "$3"	 0"}' >> allbadpixels.map
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    rm allbadpixels.txt
    fi
#move any additional pixel list from within root folder
    if [ -f deadpixels.txt ]
    then
    mv deadpixels.txt allbadpixels.map
    cat allbadpixels.map >> "${BASE}_1_$date"/allbadpixels.map
    fi
    fi
    cd "${BASE}_1_$date"
    fi
#mlv_dump settings
#if using the steroid version
    if [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then
    mlv="$(cat ~/Switch/config/"mlv_dump_on_steroids_settings" | perl -p -e 's/^[ \t]*//')"
    else
#Uncompressed setting then
    if [ -f ~/Switch/config/mlv_dump_UNC ]
    then
    rm ~/Switch/config/mlv_dump_settings
    mlv="$(cat ~/Switch/config/"mlv_dump_UNC" | perl -p -e 's/^[ \t]*//')"
    else
    if grep '10\|12' <<< $($mlv_dump -v "$FILE" | grep 'bits_per_pixel' | awk 'FNR == 1 {print $2; }')
    then
    mlv="$(cat ~/Switch/config/"mlv_dump_settings" | perl -pi -e 's/ -c//g' 2>/dev/null | perl -p -e 's/^[ \t]*//')"
    else
    mlv="$(cat ~/Switch/config/"mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"
    fi
    fi
    fi
#when going for dng files only(darkframes)
    if [ -f ~/Switch/config/only_DNG ]
    then
    bit=$($mlv_dump -m -v "$FILE" | awk '/bits_per_pixel/ { print $2; exit }')
    res=$($mlv_dump -m -v "$FILE" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -m -v "$FILE" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -m -v "$FILE" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -m -v "$FILE" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
    fi
#create second output
    if ! [ x"$(cat ~/Switch/config/output)" = x ]
    then
    mkdir -p "$(cat ~/Switch/config/output)"
    O2="$O${BASE}_1_$date"/
#dfort focus pixel list in case you change output
#if not using the steroid version
    if ! [ -f ~/Switch/config/mlv_dump_on_steroids_settings ]
    then 
    if ! grep '5D\|7D\|T1i\|500D\|T2i\|550D\|6D\|T3i\|600D\|50D' <<< $($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" | awk '/Camera Name/ { print $5,$6; exit}')
    then 
    if [ -f ~/Switch/config/tmp/crop_rec ]
    then
    fpm.sh -m crop_rec -o "$O2"allbadpixels.$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE"
    else
    fpm.sh -o "$O2"allbadpixels.$map "$(cat ~/Switch/config/tmp/path_1)"/"$FILE"   
    fi 
    fi
    fi
#enter new output
    cd "$O2"
#extract dng frames
#when going for dng files only(darkframes)new output
#Do criterias match?
    if [ -f ~/Switch/config/only_DNG ] && [ -f "$(cat ~/Switch/config/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" -s "$(cat ~/Switch/config/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    if [ -f ~/Switch/config/only_DNG ] && [ -f "$(cat ~/Switch/config/tmp/path_1)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" -s "$(cat ~/Switch/config/tmp/path_1)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" 
    fi
    fi
    cd "$(cat ~/Switch/config/tmp/path_1)"/
    else
#extract dng frames
#when going for dng files only(darkframes)
#Do criterias match?
    if [ -f ~/Switch/config/only_DNG ] && [ -f "$(cat ~/Switch/config/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" -s "$(cat ~/Switch/config/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    if [ -f ~/Switch/config/only_DNG ] && [ -f ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" -s ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" 
    fi
    fi
    fi
#try to determine if shooting footage with 3x3mv720cropmode
    if [ -f ~/Switch/config/tmp/crop_rec ]
    then
    if [ $(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Default Scale/ { print $5;}') = 1.666666667 ]
    then
    find "$O2". -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 1/1"
    fi
    fi
#grabs the white balance tag and saves it for later  
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }') 
#move mlv originals to folder 
#Check for darkframe workflow
    if [ -f "$O2"avg ]
    then
    mv -i "${BASE}".MLV "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/a_"${BASE}".MLV ;
    rm "$O2"avg
    else
    mkdir -p "$(cat ~/Switch/config/output)"
    if [ x"$(cat ~/Switch/config/output)" = x ]
    then
    mv -i "${BASE}".MLV "${BASE}".mlv "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS ;
    mv -i "${BASE}".M* "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS ;
    else
    mkdir -p "$(cat ~/Switch/config/output)"
    fi
    fi
#Stored cr2hdr settings
    if [ -f ~/Switch/config/A_cr2hdr_settings.txt ]
    then
    set=$(cat ~/Switch/config/"A_cr2hdr_settings.txt" | sed -e 's/^[ \t]*//')
    fi
#disable dualiso automation
    if [ -f ~/Switch/config/dualisodisable ]
    then
#check for imageJ multipoint white balance file
    if [ -f "$BASE".WB ]
    then
    . "$path_2"Contents/awb3.command
#check for new output
    if [ x"$(cat ~/Switch/config/output)" = x ]
    then
    mv "$BASE".WB "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS
    fi
    else
#check if cam was set to auto white balance. Non dualiso
    if [ -f "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" ]
    then
    if [ "$($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2}')" = "0" ]
    then
    . awb.sh
    fi
    fi
#check for new output location
    if [ -f "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" ]
    then
    if [ "$($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2}')" = "0" ]
    then
    . awb.sh
    fi
    fi
    fi
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    else
#Verify dualiso or else continue to next file
    cr2hdr $set "$O2""${BASE}"_1_"$date"_000000.dng | tee ~/Switch/config/tmp/dualiso.txt 
    if ! grep 'look like interlaced ISO' ~/Switch/config/tmp/dualiso.txt
    then
    rm ~/Switch/config/tmp/dualiso.txt
#cr2hdr processing
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P $(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l) -n 1 cr2hdr $set 
#grabs white level
    wle=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.SubImage1.WhiteLevel/ { print $4; }')
#check if cam was set to auto white balance
    if [ -f "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" ]
    then
    if [ "$($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2}')" = "0" ]
    then
    . awb.sh
    fi
    fi
#grabs the white balance tag and saves it for later  
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
#adds back correct white balance tag and also sets the same whitelevel to prevent flicker
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi" -M"set Exif.SubImage1.WhiteLevel $wle"
    else
#check for imageJ multipoint white balance file
    if [ -f "$BASE".WB ]
    then
    . "$path_2"Contents/awb3.command
#check for new output
    if [ x"$(cat ~/Switch/config/output)" = x ]
    then
    mv "$BASE".WB "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS
    fi
    else 
#check for new output location
    if [ -f "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" ]
    then
    if [ "$($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2}')" = "0" ]
    then
    . awb.sh
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    fi
    fi
#check if cam was set to auto white balance. Non dualiso
    if [ -f "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" ]
    then
    if [ "$($mlv_dump -v -m "$(cat ~/Switch/config/tmp/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2}')" = "0" ]
    then
    . awb.sh
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; }')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    fi
    fi
    fi
    fi
    fi
#check output
    if [ x"$(cat ~/Switch/config/output)" = x ]
    then
    cd ..
    fi
#cut to the next name on the list
    echo "$(tail -n +2 ~/Switch/config/tmp/MLVFILESaa)" > ~/Switch/config/tmp/MLVFILESaa
    done
