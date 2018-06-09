#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    mlv_dump=$(printf "%s\n" mlv_dump_on_steroids)
    map=$(printf "%s\n" fpm)
    else
    mlv_dump=$(printf "%s\n" mlv_dump)
    map=$(printf "%s\n" map)
    fi
#Processing MLV files into folders with dng files
    while ! [ x"$(cat /tmp/DUALISO/MLVFILESaa)" = x ]
    do 
    FILE=$(cat /tmp/DUALISO/"MLVFILESaa" | head -1 | grep -v 'avg_\|ft_')
    date=$($mlv_dump -v "$FILE" | grep 'Date' | head -1 | awk 'FNR == 1 {print $2; exit}')
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
#check for proxy file part 1
    if ls *.MOV >/dev/null 2>&1;
    then
    MOV=$(echo "${BASE}" | tail -c 5).MOV
    num=$(echo "${BASE}" | tail -c 5)
    if [ -f *$MOV ]
    then
#check for sequenced MOV files
    if [ -f *$(($num + 1)).MOV ]
    then
    echo *$MOV > /tmp/MOVtmp01
    echo *$(($num + 1)).MOV >> /tmp/MOVtmp01
    mv "$O""${BASE}_1_$date""$MOV" ./
    rm catlist01.txt
    rm /tmp/catlist01
    while [ "$(exiftool *$MOV | awk '/Modification/ { print $6; exit}')" = "$(exiftool "$(cat /tmp/MOVtmp01 | awk 'FNR == 2')" | awk '/Modification/ { print $6; exit}')" ] 
    do 
    echo file "$(cat "/tmp/MOVtmp01" | head -1)" >> catlist01.txt
    echo -n " $(cat "/tmp/MOVtmp01" | head -1)" >> /tmp/catlist01
#check for file
    if [ -f *$(($num + 2)).MOV ]
    then
    echo *$(($num + 2)).MOV >> /tmp/MOVtmp01
    fi
    echo "$(tail -n +2 /tmp/MOVtmp01)" > /tmp/MOVtmp01
    done
    if [ -f catlist01.txt ]
    then 
    echo file "$(cat "/tmp/MOVtmp01" | head -1)" >> catlist01.txt
    echo -n " $(cat "/tmp/MOVtmp01" | head -1)" >> /tmp/catlist01
    ffmpeg -f concat -i catlist01.txt -c copy "n${BASE}".mov 
    mv -i $(cat /tmp/catlist01 | head -1) A_ORIGINALS
    mv "n${BASE}".mov "${BASE}".MOV
    rm catlist01.txt
    rm /tmp/catlist01
    cat=$(echo do erase)
    else
    mv "$O""${BASE}_1_$date""$MOV" "$O""${BASE}_1_$date"
    cat=
    fi 
    fi 
#check for output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv *"$MOV" "$O""${BASE}_1_$date"
    fi
    fi
    fi
#check for output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv "$FILE" "${BASE}_1_$date"
    mv "$BASE".M* "${BASE}_1_$date"
#check for white balance(WB) file
    mv "$BASE".WB "${BASE}_1_$date"
#allbadpixel.map handling
    if ls *"$BASE".$map 
    then
#if using the steroid version
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
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
    if [ -f /tmp/mlv_dump_on_steroids_settings ]
    then
    mlv="$(cat /tmp/"mlv_dump_on_steroids_settings" | perl -p -e 's/^[ \t]*//')"
    else
#Uncompressed setting then
    if [ -f /tmp/mlv_dump_UNC ]
    then
    rm /tmp/mlv_dump_settings
    mlv="$(cat /tmp/"mlv_dump_UNC" | perl -p -e 's/^[ \t]*//')"
    else
    if grep '10\|12' <<< $($mlv_dump -v "$FILE" | grep 'bits_per_pixel' | awk 'FNR == 1 {print $2; exit }')
    then
    mlv="$(cat /tmp/"mlv_dump_settings" | perl -pi -e 's/ -c//g' 2>/dev/null | perl -p -e 's/^[ \t]*//')"
    else
    mlv="$(cat /tmp/"mlv_dump_settings" | perl -p -e 's/^[ \t]*//')"
    fi
    fi
    fi
#when going for dng files only(darkframes)
    if [ -f /tmp/only_DNG ] || [ -f /tmp/webstorage ]
    then
#let´s check for lossless files
  if grep '0x00000021' <<< $($mlv_dump -v "$FILE" | awk '/Class Video/ { print $4; exit }')
    then
    white=$($mlv_dump -v "$FILE" | awk '/white_level/ { print $2; exit }')
    if (( $white > 14500 ))
    then 
    bit=$(echo 14L)
    elif (( $white < 14500 && $white > 4000 ))
    then 
    bit=$(echo 12L)
    elif (( $white < 4000 && $white > 3000 ))
    then 
    bit=$(echo 11L)
    elif (( $white < 3000 && $white > 2600 ))
    then 
    bit=$(echo 10L)
    elif (( $white < 2600 && $white > 2300 ))
    then 
    bit=$(echo 9L)
    fi
  else
    bit=$($mlv_dump -v "$FILE" | awk '/bits_per_pixel/ { print $2; exit }')
  fi
    res=$($mlv_dump -v "$FILE" | awk '/Res/ { print $2; exit }')
    iso=$($mlv_dump -v "$FILE" | awk '/ISO:/ { print $2; exit }')
    fra=$($mlv_dump -v "$FILE" | awk '/FPS/ { print $3; exit }')
    cn=$($mlv_dump -v "$FILE" | awk '/Camera Name/ { print $4,$5,$6,$7; exit }' | cut -d "'" -f1 | tr -d ' ')
#check for file on bitbucket
    if ! [ -f ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    if grep "avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV" <<< $(curl  --head --silent https://bitbucket.org/Dannephoto/darkframes/downloads/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV)
    then 
    curl -L https://bitbucket.org/Dannephoto/darkframes/downloads/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV -o ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    fi  
    fi
    fi
#create second output
    if ! [ x"$(cat /tmp/output)" = x ]
    then
    mkdir -p "$(cat /tmp/output)"
    O2="$O${BASE}_1_$date"/
#dfort focus pixel list in case you change output
#if not using the steroid version
    if ! [ -f /tmp/mlv_dump_on_steroids_settings ]
    then 
    if ! grep '5D\|7D\|T1i\|500D\|T2i\|550D\|6D\|T3i\|600D\|50D' <<< $($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/"$FILE" | awk '/Camera Name/ { print $5,$6; exit}')
    then 
    if [ -f /tmp/DUALISO/crop_rec ]
    then
    fpm.sh -m crop_rec -o "$O2"allbadpixels.$map "$(cat /tmp/DUALISO/path_1)"/"$FILE"
    else
#if your file includes RAWC metadata
    if grep 'sampling 3x3 (read 1 line, skip 2, bin 3 columns)' <<< $($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/"$FILE" | awk '/sampling/ { print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10; exit}')
    then
    fpm.sh -m crop_rec -o "$O2"allbadpixels.$map "$(cat /tmp/DUALISO/path_1)"/"$FILE"
    else
    fpm.sh -o "$O2"allbadpixels.$map "$(cat /tmp/DUALISO/path_1)"/"$FILE"   
    fi 
    fi
    fi
    fi
#enter new output
    cd "$O2"
#extract dng frames
#when going for dng files only(darkframes)new output
#Do criterias match?
    if [ -f /tmp/only_DNG ] && [ -f "$(cat /tmp/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat /tmp/DUALISO/path_1)"/"$FILE" -s "$(cat /tmp/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    if [ -f /tmp/only_DNG ] && [ -f "$(cat /tmp/DUALISO/path_1)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat /tmp/DUALISO/path_1)"/"$FILE" -s "$(cat /tmp/DUALISO/path_1)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$(cat /tmp/DUALISO/path_1)"/"$FILE" 
    fi
    fi
    cd "$(cat /tmp/DUALISO/path_1)"/
    else
#extract dng frames
#when going for dng files only(darkframes)
#Do criterias match?
    if [ -f /tmp/only_DNG ] && [ -f "$(cat /tmp/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" -s "$(cat /tmp/DARK_FOLDER)"/avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    if [ -f /tmp/only_DNG ] || [ -f /tmp/webstorage ] && [ -f ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV ]
    then
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" -s ../avg_"$bit"bit_"$cn"_res_"$res"_iso_"$iso"_fps_"$fra".MLV
    else
    $mlv_dump --dng $mlv -o "$O2""${BASE}_1_$date"_ "$FILE" 
    fi
    fi
    fi
#tail the MLVprogress_bar list
    echo "$(tail -n +2 /tmp/DUALISO/MLVprogress_bar)" > /tmp/DUALISO/MLVprogress_bar
#try to determine if shooting footage with 3x3mv720cropmode
    if [ -f /tmp/DUALISO/crop_rec ]
    then
    if [ $(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Default Scale/ { print $5;}') = 1.666666667 ]
    then
    find "$O2". -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 1/1"
    fi
    fi
#extra check for crop_rec in RAWC
    if ! grep '5D\|7D\|T1i\|500D\|T2i\|550D\|6D\|T3i\|600D\|50D' <<< $($mlv_dump -v "$FILE" | awk '/Camera Name/ { print $5,$6; exit}')
    then 
#if your file includes RAWC metadata
    if grep 'sampling 3x3 (read 1 line, skip 2, bin 3 columns)' <<< $($mlv_dump -v "$FILE" | awk '/sampling/ { print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10; exit}')
    then
    if [ $(exiftool "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Default Scale/ { print $5;}') = 1.666666667 ]
    then
    find "$O2". -maxdepth 1 -mindepth 1 -iname '*.dng' -print0 | xargs -0 exiv2 -M"set Exif.Image.DefaultScale Rational 1/1 1/1"
    fi
    fi
    fi
#check for proxy file part 2
    if [ -f *$MOV ]
    then
    duration=$(exiftool *"$MOV" -b -MediaDuration)
    if (( $(echo "$duration < 5" |bc -l) )); then
    snippet=$(echo 2)
    else
    snippet=$(echo 5)
    fi
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.02" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    if [ x"$first_black" = x ]; then
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.04" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    if [ x"$first_black" = x ]; then
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.08" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    fi
    fi
#grab amount of dng frames from MLV metadata
    frct=$(mlv_dump "$FILE" | awk '/Processed/ { print $2; exit}')
#extract audio
    if ! ls "$O2"*.wav >/dev/null 2>&1;
    then
#proxy audio
    ffmpeg -ss 0$first_black -i *"$MOV" -c copy -map 0:a "$O2""${BASE}_1_$date"_.wav
    fi
    ffmpeg -ss 0$first_black -i *"$MOV" -vframes $frct -vcodec copy -acodec copy -timecode 00:00:00:00 n"${BASE}".MOV
#check for output
    if ! [ x"$(cat /tmp/output)" = x ]
    then
    mv -i n"${BASE}".MOV "$(cat /tmp/output)"/"${BASE}_1_$date".MOV
    else
#move transcoded proxy to parent folder
    mv -i n"${BASE}".MOV "$(cat /tmp/DUALISO/path_1)"/"${BASE}_1_$date".MOV
    mv -i *"$MOV" "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS
    fi
    fi
#if already created a cat file erase instead of keep(4gb limit)
    if ! [ x"$cat" = x ]
    then
    rm "${BASE}".MOV
    fi 
#syncs audio to amount of dng frames
    frct=$(mlv_dump "$FILE" | awk '/Processed/ { print $2; exit}')
    FPS=$(mlv_dump "$FILE" | awk '/Processed/ { print $6; exit}')      
    frct_result=$(echo $frct/$FPS | bc -l | awk 'FNR == 1 {print}')
    audf=$(mlv_dump -v "$FILE" | grep -A6 'Block: AUDF' | awk 'FNR == 5 {print $2}' | cut -d "." -f1)
    vidf=$(mlv_dump -v "$FILE" | grep -A6 'Block: VIDF' | awk 'FNR == 5 {print $2}' | cut -d "." -f1)
    audio=$(echo $vidf - $audf | bc -l)
#cut audio  
    ffmpeg -ss 00:00:00.$audio -i "$O2""${BASE}_1_$date"_.wav -t $frct_result -acodec copy "$O2""${BASE}_1_$date".wav ;
    rm "$O2""${BASE}_1_$date"_.wav
#if mlv_dump_on_steroids
    if [ $mlv_dump = mlv_dump_on_steroids ]
    then
#cut audio  
    ffmpeg -ss 00:00:00.$audio -i "$O2""${BASE}_1_$date".wav -t $frct_result -acodec copy "$O2""${BASE}_1_$date"tmp.wav ;
    mv "$O2""${BASE}_1_$date"tmp.wav "$O2""${BASE}_1_$date".wav
    fi
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
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}') 
#move mlv originals to folder 
#Check for darkframe workflow
    if [ -f "$O2"avg ]
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
    if [ -f /tmp/dualisodisable ]
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
    if [ "$($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
#check for new output location
    if [ "$($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
    fi
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
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
    wle=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.SubImage1.WhiteLevel/ { print $4; exit}')
#check if cam was set to auto white balance
    if [ "$($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
    fi
#grabs the white balance tag and saves it for later  
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.DNG | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
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
    if [ "$($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
    find "$O2". -maxdepth 1 -mindepth 1 -name '*.dng' -print0 | xargs -0 -P 8 -n 1 exiv2 -M"set Exif.Image.AsShotNeutral Rational $wi"
    fi
#check if cam was set to auto white balance. Non dualiso
    if [ "$($mlv_dump -v "$(cat /tmp/DUALISO/path_1)"/A_ORIGINALS/"$FILE" | grep -A6 'Block: WBAL' | awk 'FNR == 6 {print $2; exit}')" = "0" ]
    then
    . "$path_2"Contents/awb.command
#rename DNG to dng fix 
    mv "$O2""${BASE}"_1_"$date"_000000.DNG "$O2""${BASE}"_1_"$date"_000000.dng
#grabs the white balance tag and saves it for later. Non dualiso
    wi=$(exiv2 -pt "$O2""${BASE}"_1_"$date"_000000.dng | awk '/Exif.Image.AsShotNeutral/ { print $4,$5,$6; exit}')
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
    echo "$(tail -n +2 /tmp/DUALISO/MLVFILESaa)" > /tmp/DUALISO/MLVFILESaa
    done