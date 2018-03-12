#GNU public license
#This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
 # as published by the Free Software Foundation; either version 2
 # of the License, or (at your option) any later version.
 # 
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 # 
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the
 # Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.

#not needed
rm LOG.txt

#if AE project file included
 if ls *.aep >/dev/null 2>&1
 then
 ls *.CR2 > AE_list
 split -l $(( $( wc -l < AE_list ) / 4 + 1 )) AE_list AE_list
 rm AE_list

#build subscripts
 if ls AE_listaa >/dev/null 2>&1
 then
#create tmp1 folder
 mkdir -p tmp1
 mv $(cat AE_listaa) tmp1 
 cp "$(ls *.aep | head -1)" tmp1
 mv AE_listaa tmp1
 cp *.xmp tmp1 
cat <<'EOF' > AE_01.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"
printf '\e[8;6;50t'
printf '\e[3;410;100t'
#enter tmp1 folder
 cd tmp1
 #comp name
 comp=$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 while grep 'CR2' AE_listaa
 do
 if [ -f $comp ]
 then
 cp $comp tmp_$comp
 fi
 cp "$(cat AE_listaa | head -1)" $comp
 mv *.xmp $(echo $comp | cut -d '.' -f1).xmp
/Applications/Adobe\ After\ Effects\ CS6/aerender -comp "$(echo $comp | cut -d '.' -f1)" -output "$(echo $PWD/)""$(cat AE_listaa | head -1 | cut -d '.' -f1)" -project "$(echo $PWD/)""$(ls *.aep | head -1)"
 mv "$(cat AE_listaa | head -1 | cut -d '.' -f1)".*00000 ../$(echo "$(cat AE_listaa | head -1 | cut -d '.' -f1)".*00000 | rev | cut -c 6- | rev)
#move original back to parent folder
 mv $(cat AE_listaa | head -1) ../
 rm $comp
 rm -r "$(echo *Logs)"
 echo "$(tail -n +2 AE_listaa )" > AE_listaa
 done
 rm AE_listaa
 if [ -f tmp_$comp ]
 then
 mv tmp_$comp ../$comp
 fi
 cd ../
#remove tmp1 folder
 rm -r tmp1
 rm AE_01.command
EOF
 fi 

#build subscripts
 if ls AE_listab >/dev/null 2>&1
 then
#create tmp2 folder
 mkdir -p tmp2
 mv $(cat AE_listab) tmp2 
 cp "$(ls *.aep | head -1)" tmp2
 mv AE_listab tmp2
 cp *.xmp tmp2 
cat <<'EOF' > AE_02.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"
printf '\e[8;6;50t'
printf '\e[3;410;100t'
#enter tmp2 folder
 cd tmp2
 #comp name
 comp=$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 while grep 'CR2' AE_listab
 do
 if [ -f $comp ]
 then
 cp $comp tmp_$comp
 fi
 cp "$(cat AE_listab | head -1)" $comp
 mv *.xmp $(echo $comp | cut -d '.' -f1).xmp
/Applications/Adobe\ After\ Effects\ CS6/aerender -comp "$(echo $comp | cut -d '.' -f1)" -output "$(echo $PWD/)""$(cat AE_listab | head -1 | cut -d '.' -f1)" -project "$(echo $PWD/)""$(ls *.aep | head -1)"
 mv "$(cat AE_listab | head -1 | cut -d '.' -f1)".*00000 ../$(echo "$(cat AE_listab | head -1 | cut -d '.' -f1)".*00000 | rev | cut -c 6- | rev)
#move original back to parent folder
 mv $(cat AE_listab | head -1) ../
 rm $comp
 rm -r "$(echo *Logs)"
 echo "$(tail -n +2 AE_listab )" > AE_listab
 done
 rm AE_listab
 if [ -f tmp_$comp ]
 then
 mv tmp_$comp ../$comp
 fi
 cd ../
#remove tmp2 folder
 rm -r tmp2
 rm AE_02.command
EOF
 fi 

#build subscripts
 if ls AE_listac >/dev/null 2>&1
 then
#create tmp3 folder
 mkdir -p tmp3
 mv $(cat AE_listac) tmp3 
 cp "$(ls *.aep | head -1)" tmp3
 mv AE_listac tmp3
 cp *.xmp tmp3 
cat <<'EOF' > AE_03.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"
printf '\e[8;6;50t'
printf '\e[3;410;100t'
#enter tmp3 folder
 cd tmp3
 #comp name
 comp=$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 while grep 'CR2' AE_listac
 do
 if [ -f $comp ]
 then
 cp $comp tmp_$comp
 fi
 cp "$(cat AE_listac | head -1)" $comp
 mv *.xmp $(echo $comp | cut -d '.' -f1).xmp
/Applications/Adobe\ After\ Effects\ CS6/aerender -comp "$(echo $comp | cut -d '.' -f1)" -output "$(echo $PWD/)""$(cat AE_listac | head -1 | cut -d '.' -f1)" -project "$(echo $PWD/)""$(ls *.aep | head -1)"
 mv "$(cat AE_listac | head -1 | cut -d '.' -f1)".*00000 ../$(echo "$(cat AE_listac | head -1 | cut -d '.' -f1)".*00000 | rev | cut -c 6- | rev)
#move original back to parent folder
 mv $(cat AE_listac | head -1) ../
 rm $comp
 rm -r "$(echo *Logs)"
 echo "$(tail -n +2 AE_listac )" > AE_listac
 done
 rm AE_listac
 if [ -f tmp_$comp ]
 then
 mv tmp_$comp ../$comp
 fi
 cd ../
#remove tmp3 folder
 rm -r tmp3
 rm AE_03.command
EOF
 fi  

#build subscripts
 if ls AE_listad >/dev/null 2>&1
 then
#create tmp4 folder
 mkdir -p tmp4
 mv $(cat AE_listad) tmp4 
 cp "$(ls *.aep | head -1)" tmp4
 mv AE_listad tmp4
 cp *.xmp tmp4 
cat <<'EOF' > AE_04.command
#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"
printf '\e[8;6;50t'
printf '\e[3;410;100t'
#enter tmp4 folder
 cd tmp4
 #comp name
 comp=$(LC_ALL=C cat -v "$(ls *.aep | head -1)" | grep -o -m 1 '[^ ]*CR2' | rev | cut -d '/' -f1 | rev)
 while grep 'CR2' AE_listad
 do
 if [ -f $comp ]
 then
 cp $comp tmp_$comp
 fi
 cp "$(cat AE_listad | head -1)" $comp
 mv *.xmp $(echo $comp | cut -d '.' -f1).xmp
/Applications/Adobe\ After\ Effects\ CS6/aerender -comp "$(echo $comp | cut -d '.' -f1)" -output "$(echo $PWD/)""$(cat AE_listad | head -1 | cut -d '.' -f1)" -project "$(echo $PWD/)""$(ls *.aep | head -1)"
 mv "$(cat AE_listad | head -1 | cut -d '.' -f1)".*00000 ../$(echo "$(cat AE_listad | head -1 | cut -d '.' -f1)".*00000 | rev | cut -c 6- | rev)
#move original back to parent folder
 mv $(cat AE_listad | head -1) ../
 rm $comp
 rm -r "$(echo *Logs)"
 echo "$(tail -n +2 AE_listad )" > AE_listad
 done
 rm AE_listad
 if [ -f tmp_$comp ]
 then
 mv tmp_$comp ../$comp
 fi
 cd ../
#remove tmp4 folder
 rm -r tmp4
 rm AE_04.command
EOF
 fi
 fi

#set silent mode
    mode=$(echo .)

if [ -f AE_01.command ]
then
  chmod u=rwx AE_01.command
  $mode AE_01.command & pid1=$! 
fi

if [ -f AE_02.command ]
then  
  chmod u=rwx AE_02.command
  $mode AE_02.command & pid2=$! 
fi

if [ -f AE_03.command ]
then  
  chmod u=rwx AE_03.command
  $mode AE_03.command & pid3=$! 
fi

if [ -f AE_04.command ]
then  
  chmod u=rwx AE_04.command
  $mode AE_04.command & pid4=$! 
fi

while ls AE_0*.command >/dev/null 2>&1
do 
sleep 2
done
#tmp disable xmp file
 mv $(ls *.xmp | head -1) $(ls *.xmp | head -1)tmp  
#extract metadata info
 exiv2 -e X extract *.{cr2,CR2}
#insert metadata recursively
 exiv2 -i X insert *.jpg *.tif
#We are done, thanks exiv2
 rm *.xmp
#restore tmp disable xmp file
 mv *.xmptmp $(ls *.xmptmp | head -1 | rev | cut -c 4- | rev)
 mv $(ls *.xmp | head -1) A_ORIGINALS
EOF
