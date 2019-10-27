    while grep -q 'CR2' /tmp/DUALISO/draglist_01
    do
    one=$(grep 'CR2' /tmp/DUALISO/draglist_01 | awk 'FNR == 1 {print}')
    echo "$(tail -n +2 /tmp/DUALISO/draglist_01)" > /tmp/DUALISO/draglist_01
    raw2mlv $one -o "$(echo $one | cut -d "." -f1)".MLV
    done