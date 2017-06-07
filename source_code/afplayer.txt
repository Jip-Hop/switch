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
 # Free Software Foundation, Inc,
 # 51 Franklin Street, Fifth Floor,
 # Boston, MA  02110-1301, USA.


printf '\e[8;19;37t'
printf '\e[3;5;0t'
bold="$(tput bold)"
normal="$(tput sgr0)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"
green="$(tput setaf 2)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"


cd $(cat /tmp/"afplay_path")
mkdir -p A_ORIGINALS
export PATH="$(cat /tmp/DUALISO/"path_2")":$PATH

#check for files to convert
    for f in *; do [[ -f "$f" ]] && ls "$f" | grep -v 'mp3\|MP3\|list\|LOG.txt\|MLV\|RAW\|CR2\|mov\|MOV\|current_songs\|playlistB\|playlist' >> list
    done
#do files exist or not
    if ! [ x"$(cat list)" = x ]
    then
#split into 4 chunks
    split -l $(( $( wc -l < list ) / 4 + 1 )) list list
    fi
rm list

    if ! [ x"$(cat listaa)" = x ]
    then 
    printf '\e[8;19;37t'
    printf '\e[3;5;0t'
    clear
echo "


${bold}$(tput setaf 2)Converting to mp3$(tput sgr0)"
sleep 2

#mp3 multithreading engine
    . "$(cat /tmp/DUALISO/path_2)"mp3_01.command & 
    . "$(cat /tmp/DUALISO/path_2)"mp3_02.command & 
    . "$(cat /tmp/DUALISO/path_2)"mp3_03.command & 
    . "$(cat /tmp/DUALISO/path_2)"mp3_04.command & 
sleep 1
#trap
    while [ `ls -1 /tmp/DUALISO/mp3_TRAP* 2>/dev/null | wc -l ` -gt 0 ];
    do
    sleep 2
    done
    fi

#shuffle list
    if [ x"$(cat playlist)" = x ]
    then 
    rm playlist
    ls *.mp3 | perl -MList::Util=shuffle -e 'print shuffle<STDIN>' >> playlist
    sleep 0.2
    fi
 
#if somehow playlistB is present upon start
    if ls playlistB
    then
    mv playlistB playlist
    fi
#"pl" afplay
    if ls /tmp/afplay_path
    then 
    while grep -q 'mp3' playlist
    do 
    afplay "$(cat "playlist" | head -1)"
    if ls playlist
    then
    echo "$(tail -n +2 playlist)" > playlist
    sleep 0.5
    clear
    printf '\e[8;19;37t'
    printf '\e[3;5;0t'
    cat<<EOF
    --------
    $(tput bold)afplayer$(tput sgr0)
    --------

$(tput bold)Playing: $(tput setaf 2)$(cat "playlist" | head -1 | cut -d "." -f1)

    $(tput bold)$(tput setaf 1)(q) Quit afplayer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(n) Next song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(s) Shuffle$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p) Pause/continue$(tput sgr0)
    $(tput bold)$(tput setaf 1)(f) Save current song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E) Erase current song list$(tput sgr0)
    $(tput bold)$(tput setaf 1)(c) Toggle current/shuffle list$(tput sgr0)
    $(tput bold)$(tput setaf 1)(o) Open audio folder$(tput sgr0)
    $(tput bold)$(tput setaf 1)(X) Completely remove this song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(M) Move mp3 to A_ORIGINALS$(tput sgr0)
	(except current list)


EOF
    fi
    done &


#short wait for playlist to get tailed or shuffle list to be built
    sleep 0.5

while :
do 

    clear
    cat<<EOF
    --------
    $(tput bold)afplayer$(tput sgr0)
    --------

$(tput bold)Playing: $(tput setaf 2)$(cat "playlist" | head -1 | cut -d "." -f1)

    $(tput bold)$(tput setaf 1)(q) Quit afplayer$(tput sgr0)
    $(tput bold)$(tput setaf 1)(n) Next song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(s) Shuffle$(tput sgr0)
    $(tput bold)$(tput setaf 1)(p) Pause/continue$(tput sgr0)
    $(tput bold)$(tput setaf 1)(f) Save current song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(E) Erase current song list$(tput sgr0)
    $(tput bold)$(tput setaf 1)(c) Toggle current/shuffle list$(tput sgr0)
    $(tput bold)$(tput setaf 1)(o) Open audio folder$(tput sgr0)
    $(tput bold)$(tput setaf 1)(X) Completely remove this song$(tput sgr0)
    $(tput bold)$(tput setaf 1)(M) Move mp3 to A_ORIGINALS$(tput sgr0)
	(except current list)

EOF
    read -n1
    case "$REPLY" in

#go back to prores menu
    "q") 
rm /tmp/DUALISO/afplayON
echo "$(tail -n +2 playlist)" > playlist
mv playlistB playlist
sleep 0.5
mv playlist listtemp
killall afplay
sleep 2 && mv listtemp playlist &
osascript -e 'tell application "Terminal" to close first window' & exit
;;

    "n")
killall afplay 
;;

    "s")
rm playlist
rm mv playlistB 
killall afplay 
sleep 0.5
ls *.mp3 | perl -MList::Util=shuffle -e 'print shuffle<STDIN>' >> playlist
. "$(cat /tmp/DUALISO/path_2)"afplayer.command 
;;

    "p")
if ! ls /tmp/DUALISO/pause
then
echo > /tmp/DUALISO/pause
kill -STOP $(ps aux | pgrep afplay)
else
rm /tmp/DUALISO/pause
kill -CONT $(ps aux | pgrep afplay)
fi
;;

    "f")
if ! grep "$(cat "playlist" | head -1)" current_songs
then
echo "$(cat "playlist" | head -1)" >> current_songs
fi
;;

    "E")
rm current_songs
;;

    "c")
    if ls playlistB
    then
    if ! [ -n "$(pgrep afplay </dev/null)" ];
    then
    mv playlistB playlist
    sleep 0.5
    . "$(cat /tmp/DUALISO/path_2)"afplayer.command
    else
    killall afplay
    sleep 0.5
    mv playlistB playlist
    fi
else
    if ! ls playlistB
    then
    cp playlist playlistB
    sleep 0.5
    if ls current_songs
    then 
    if ! [ -n "$(pgrep afplay </dev/null)" ];
    then
    cat current_songs | perl -MList::Util=shuffle -e 'print shuffle<STDIN>' > playlist
    . "$(cat /tmp/DUALISO/path_2)"afplayer.command
    else
    killall afplay    
    sleep 0.5
    cat current_songs | perl -MList::Util=shuffle -e 'print shuffle<STDIN>' > playlist
    fi
    fi
    fi
    fi
;;

    "o")
open $(cat /tmp/"afplay_path")
;;

    "M")
mkdir -p A_ORIGINALS
    if ! [ x"$(cat current_songs)" = x ]
    then
    while IFS= read -r file; do mv "$file" A_ORIGINALS; done <<< "$(ls *.mp3 | grep -v "$(cat current_songs)")" 
    else
    mv *.mp3 A_ORIGINALS
    fi
;;

    "X")
rm "$(cat "playlist" | head -1)"
killall afplay 
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done
else
rm /tmp/DUALISO/afplayON
osascript -e 'tell application "Terminal" to close first window' & exit
fi


#Copyright Danne