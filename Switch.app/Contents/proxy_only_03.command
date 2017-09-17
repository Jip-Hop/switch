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
    while ! [ x"$(cat /tmp/DUALISO/MLVFILESac)" = x ]
    do 
    FILE=$(cat /tmp/DUALISO/"MLVFILESac" | head -1 | grep -v 'avg_\|ft_')
    date=$($mlv_dump -m -v "$FILE" | grep 'Date' | head -1 | awk 'FNR == 1 {print $2}')
    date_01=$(echo "$date" | head -c2)
    date_02=$(echo "$date" | cut -c4-5)
    date_03=$(echo "$date" | cut -c7-10)
    date=$(echo "$date_03"-"$date_02"-"$date_01""_0001_C0000")
    BASE=`echo "$FILE" | cut -d "." -f1`;
#check for output
    if ! [ x"$(cat /tmp/output)" = x ]
    then
    mkdir -p "$(cat /tmp/output)"
    out=$(cat /tmp/output)/
    fi
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
    echo *$MOV > /tmp/MOVtmp03
    echo *$(($num + 1)).MOV >> /tmp/MOVtmp03
    rm catlist03.txt
    rm /tmp/catlist03
    while [ "$(exiftool *$MOV | awk '/Modification/ { print $6; exit}')" = "$(exiftool "$(cat /tmp/MOVtmp03 | awk 'FNR == 2')" | awk '/Modification/ { print $6; exit}')" ] 
    do 
    echo file "$(cat "/tmp/MOVtmp03" | head -1)" >> catlist03.txt
    echo -n " $(cat "/tmp/MOVtmp03" | head -1)" >> /tmp/catlist03
#check for file
    if [ -f *$(($num + 2)).MOV ]
    then
    echo *$(($num + 2)).MOV >> /tmp/MOVtmp03
    fi
    echo "$(tail -n +2 /tmp/MOVtmp03)" > /tmp/MOVtmp03
    done
    if [ -f catlist03.txt ]
    then 
    echo file "$(cat "/tmp/MOVtmp03" | head -1)" >> catlist03.txt
    echo -n " $(cat "/tmp/MOVtmp03" | head -1)" >> /tmp/catlist03
    ffmpeg -f concat -i catlist03.txt -c copy "n${BASE}".mov 
    mv -i $(cat /tmp/catlist03 | head -1) A_ORIGINALS
    mv "n${BASE}".mov "${BASE}".MOV
    rm catlist03.txt
    rm /tmp/catlist03
    else
    cat=
    fi 
    fi  
#Straight proxy making
    duration=$(exiftool *"$MOV" -b -MediaDuration)
    if (( $(echo "$duration < 5" |bc -l) )); then
    snippet=$(echo 2)
    else
    snippet=$(echo 5)
    fi
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.01" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    if [ x"$first_black" = x ]; then
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.04" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    if [ x"$first_black" = x ]; then
    first_black=$(ffmpeg -i *"$MOV" -to $snippet -vf "blackdetect=d=0.1:pix_th=0.08" -an -f null - 2>&1 | grep -o "black_duration:.*" | cut -d ":" -f2)
    fi
    fi
#grab amount of dng frames from MLV metadata
    frct=$(mlv_dump "$FILE" | awk '/Processed/ { print $2; }')
    FPS=$(mlv_dump "$FILE" | awk '/Processed/ { print $6; }')     
    trimmed=$(echo $frct/$FPS | bc -l | awk 'FNR == 1 {print}') 
    ffmpeg -ss 0$first_black -i *"$MOV" -t $trimmed -vcodec copy -acodec copy -timecode 00:00:00:00 "$out"n"${BASE}".MOV
    mv -i "$out"n"${BASE}".MOV "$out""${BASE}_1_$date".MOV
#move transcoded proxy to parent folder
#if already created a cat file erase instead of keep(4gb limit)
    if ! [ x"$cat" = x ]
    then
    rm "${BASE}".MOV
    else
#check for output
    if [ x"$(cat /tmp/output)" = x ]
    then
    mv -i n"${BASE}".MOV "${BASE}_1_$date".MOV
    mv -i *"$MOV" A_ORIGINALS
    fi
    fi
    fi
    fi
#tail the MLVprogress_bar list
    echo "$(tail -n +2 /tmp/DUALISO/MLVprogress_bar)" > /tmp/DUALISO/MLVprogress_bar
#cut to the next name on the list
    echo "$(tail -n +2 /tmp/DUALISO/MLVFILESac)" > /tmp/DUALISO/MLVFILESac
done


