    while grep -q 'CR2' /tmp/DUALISO/draglist_03
    do
    three=$(grep 'CR2' /tmp/DUALISO/draglist_03 | awk 'FNR == 1 {print}')
    echo "$(tail -n +2 /tmp/DUALISO/draglist_03)" > /tmp/DUALISO/draglist_03
    raw2mlv $three -o "$(echo $three | cut -d "." -f1)".MLV
    done