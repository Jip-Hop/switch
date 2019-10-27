    while grep -q 'CR2' /tmp/DUALISO/draglist_02
    do
    two=$(grep 'CR2' /tmp/DUALISO/draglist_02 | awk 'FNR == 1 {print}')
    echo "$(tail -n +2 /tmp/DUALISO/draglist_02)" > /tmp/DUALISO/draglist_02
    raw2mlv $two -o "$(echo $two | cut -d "." -f1)".MLV
    done