    while grep -q 'CR2' /tmp/DUALISO/draglist_04
    do
    four=$(grep 'CR2' /tmp/DUALISO/draglist_04 | awk 'FNR == 1 {print}')
    echo "$(tail -n +2 /tmp/DUALISO/draglist_04)" > /tmp/DUALISO/draglist_04
    raw2mlv $four -o "$(echo $four | cut -d "." -f1)".MLV
    done