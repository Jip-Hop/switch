#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

#changes size of terminal window
#tip from here http://apple.stackexchange.com/questions/33736/can-a-terminal-window-be-resized-with-a-terminal-command
#Will move terminal window to the left corner

printf '\e[8;20;95t'
printf '\e[3;410;100t'

open -a Terminal

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

clear


#check for dependencies:
if ! [ -f "`which hg`" ]
then 
clear
echo $(tput bold)"
Checking for mercurial, please wait..."
sleep 2
read -p $(tput bold)"
mercurial(hg) is not installed would you like to install it?
(this action might install homebrew as well)$(tput setaf 1)

Y/N?"$(tput sgr0) -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
clear
echo "Follow instructions in terminal window"
sleep 2
[ ! -f "`which brew`" ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install mercurial
fi
fi
#Did we run hgrc changes?:
    cd ../
    dir=$PWD
    cd source_code

    if ! [ -f "$dir"/.hg/hgrc_orig ]
    then
    cp "$dir"/.hg/hgrc "$dir"/.hg/hgrc_orig
    fi

#what´s added and not
    password="$(grep '@bitbucket.org' "$dir"/.hg/hgrc | cut -d ":" -f3 | cut -d "@" -f1)"
    username="$(grep 'username' "$dir"/.hg/hgrc)"

#Check for password
    if [ x"$password" = x ]
    then 
    password=$red$(echo "MISSING")
    else
    password="$bold$blue$(echo "password added$(tput sgr0)(not shown)")"
    fi

#Check for username
    if [ x"$username" = x ]
    then 
    username=$red$(echo "MISSING")
    else
    if grep 'username = Jane Doe' "$dir"/.hg/hgrc
    then
    username=$red$(echo "MISSING")
    else
    username="$bold$blue$(grep 'username' "$dir"/.hg/hgrc)"
    fi
    fi

while :
do 

    clear
    cat<<EOF
    $(tput sgr0)====================			   
    ${bold}$(tput setaf 1)hg automation script$(tput sgr0)
    --------------------
 
    $(tput bold)(01) add password, username and email to your hgrc file 
    $(tput bold)(RE) reset hgrc to default settings$(tput sgr0)
    $(tput bold)(c)  pull, update, commit$(tput sgr0)(skips push and dmg creation)
    $(tput bold)(p)  pull, update, commit, push$(tput sgr0)(skips dmg creation)
    $(tput bold)(dm) create only the Switch.dmg file$(tput sgr0)
    $(tput bold)$(tput setaf 4)(s)  pull and update from Switch main source$(tput sgr0)(fork,branch developer)
    $(tput bold)$(tput setaf 2)(r)  pull, update, commit, push and Switch.dmg upload$(tput sgr0)
    $(tput bold)$(tput setaf 1)(q)  exit from this menu$(tput sgr0)

    	 $(tput sgr0)$(tput smul)Your password:$(tput sgr0)$(tput setaf 2) $password$(tput sgr0)
    $(tput sgr0)$(tput smul)Username and email:$(tput sgr0)$(tput setaf 2) $username$(tput sgr0)


Please enter your selection number below:
EOF
    read -n2
    case "$REPLY" in

    "01") 
#if rerun on file already set 
    if ! [ "$username" = $(tput setaf 1)MISSING ]
    then 
clear
   echo $(tput bold)$(tput setaf 1)"Please reset your hgrc file before proceeding"
   sleep 2
   else

#Add this to get password:

clear
   echo $(tput bold)"Write your bitbucket password:$(tput sgr0) then press enter"
   read password

clear
   echo $(tput bold)"Write your username:$(tput sgr0) then press enter"
   read user

clear
   echo $(tput bold)"Write your email adress:$(tput sgr0) then press enter"
   read email

#password replacement:
   end="$(grep '@bitbucket.org' "$dir"/.hg/hgrc | cut -d "@" -f2)"
   begin="$(grep '@bitbucket.org' "$dir"/.hg/hgrc | cut -d "@" -f1)"
   pass="$(echo :"$password"@)"

#Check for password
    if [ x"$pass" = x ]
    then 
    clear
    echo "Password is missing and upload automation won´t work"
    sleep 2
    exit 0
    fi

#Replace bitbucket hgrc info
    sed -i".bak" "$(grep -n '@bitbucket.org' "$dir"/.hg/hgrc | cut -d ":" -f1)"d "$dir"/.hg/hgrc
    sed -i".bak1" "$(grep -n '\[paths\]' "$dir"/.hg/hgrc | cut -d ":" -f1)"d "$dir"/.hg/hgrc
    sed -i".bak2" "$(grep -n '# username' "$dir"/.hg/hgrc | cut -d ":" -f1)"d "$dir"/.hg/hgrc
    sed -i".bak3" "$(grep -n '\[ui\]' "$dir"/.hg/hgrc | cut -d ":" -f1)"d "$dir"/.hg/hgrc

#path with password
    echo "[paths]" >> "$dir"/.hg/hgrc
    echo "$begin""$pass""$end" >> "$dir"/.hg/hgrc

#remove bak files
    rm "$dir"/.hg/hgrc.bak
    rm "$dir"/.hg/hgrc.bak1
    rm "$dir"/.hg/hgrc.bak2
    rm "$dir"/.hg/hgrc.bak3

#write username and email
    echo "[ui]" >> "$dir"/.hg/hgrc
    echo "username = "$user" <"$email">" >> "$dir"/.hg/hgrc

fi

. Build_dmg_package.command
;;

   "RE")  
mv "$dir"/.hg/hgrc_orig "$dir"/.hg/hgrc
rm "$dir"/.hg/hgrc_orig
clear
echo $(tput bold)"

$(tput sgr0)$(tput bold)$(tput setaf 1) 
hgrc file is now reset"$(tput sgr0) ; sleep 2

. Build_dmg_package.command
;;

   "c")  
#commit and push in one swoop
#if username is missing 
    if [ "$username" = $(tput setaf 1)MISSING ]
    then 
clear
   echo $(tput bold)$(tput setaf 1)"Please add password, username and email before proceeding"
   sleep 2
. Build_dmg_package.command
   else
   cd "$dir"/
clear
   echo $(tput bold)"Write a commit message$(tput sgr0) then press enter"
   read commit
   hg pull
   hg update
   hg commit -m "$(echo $commit)"
   
   cd source_code
. Build_dmg_package.command
    fi
;;

   "dm")  
#let´s build the dmg file
  cd "$dir"/source_code
clear
#A MAKE like solution which copies changes made in source txt files and migrates the changes into Switch.app and at the end creates a dmg package
#simple command to rename txt scripts to .command and copy these to Switch.app content folder.
xattr -d com.apple.quarantine ../Switch.app
for file in *.command; do
    mv "$file" "`basename $file .command`.txt" 
done
for file in *.txt; do
    mv "$file" "`basename $file .txt`.command"
yes | cp *.command  ../Switch.app/Contents
done
for file in *.command; do
    mv "$file" "`basename $file .command`.txt" 
done
mv Build_dmg_package.txt Build_dmg_package.command
rm ../Switch.app/Contents/Build_dmg_package.command
rm ../Switch.app/Contents/Switch_MAIN.command
cd ../
#Script originally for MLVFS
#https://bitbucket.org/dmilligan/mlvfs/src/9f8191808407bb49112b9ab14c27053ae5022749/build_installer.sh?at=master&fileviewer=file-view-default
# A lot of this script came from here:
# http://stackoverflow.com/questions/96882/how-do-i-create-a-nice-looking-dmg-for-mac-os-x-using-command-line-tools
source="install_temp"
title="Switch"
finalDMGName="Switch.dmg"
size=150000

mkdir "${source}"
cp -R Switch.app "${source}"
cp -R source_code "${source}"
cp LICENSE "${source}"
cp HOWTO.txt "${source}"

#remove any previously existing build
rm -f "${finalDMGName}"

hdiutil create -srcfolder "${source}" -volname "${title}" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${size}k pack.temp.dmg
device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')
sleep 2
chmod -Rf go-w /Volumes/"${title}"
sync
sync
hdiutil detach ${device}
hdiutil convert "pack.temp.dmg" -format UDZO -imagekey zlib-level=9 -o "${finalDMGName}"
rm -f pack.temp.dmg
rm -R "${source}"

#back to start
    cd "$dir"/source_code
. Build_dmg_package.command
;;

   "s")  
#pull from source
   cd "$dir"/
clear
   hg pull https://Dannephoto@bitbucket.org/Dannephoto/switch
   hg update

   cd source_code
. Build_dmg_package.command
;;

   "p")  
#commit and push in one swoop
#if username is missing 
    if [ "$username" = $(tput setaf 1)MISSING ]
    then 
clear
   echo $(tput bold)$(tput setaf 1)"Please add password, username and email before proceeding"
   sleep 2
. Build_dmg_package.command
   else
   cd "$dir"/
clear
   echo $(tput bold)"Write a commit message$(tput sgr0) then press enter"
   read commit
   hg pull
   hg update
   hg commit -m "$(echo $commit)"
   hg push
   
   cd source_code
. Build_dmg_package.command
    fi
;;

   "q")  
osascript -e 'tell application "Terminal" to close first window' & exit
;;

   "r")  
#commit, push and upload in one swoop
#if username is missing 
    if [ "$username" = $(tput setaf 1)MISSING ]
    then 
clear
   echo $(tput bold)$(tput setaf 1)"Please add password, username and email before proceeding"
   sleep 2
. Build_dmg_package.command
   else
   cd "$dir"/
clear
   echo $(tput bold)"Write a commit message$(tput sgr0) then press enter"
   read commit
   hg pull
   hg update
   hg commit -m "$(echo $commit)"
   hg push


#let´s build the dmg file
  cd source_code
clear
#A MAKE like solution which copies changes made in source txt files and migrates the changes into Switch.app and at the end creates a dmg package
#simple command to rename txt scripts to .command and copy these to Switch.app content folder.
xattr -d com.apple.quarantine ../Switch.app
for file in *.command; do
    mv "$file" "`basename $file .command`.txt" 
done
for file in *.txt; do
    mv "$file" "`basename $file .txt`.command"
yes | cp *.command  ../Switch.app/Contents
done
for file in *.command; do
    mv "$file" "`basename $file .command`.txt" 
done
mv Build_dmg_package.txt Build_dmg_package.command
rm ../Switch.app/Contents/Build_dmg_package.command
rm ../Switch.app/Contents/Switch_MAIN.command
cd ../
#Script originally for MLVFS
#https://bitbucket.org/dmilligan/mlvfs/src/9f8191808407bb49112b9ab14c27053ae5022749/build_installer.sh?at=master&fileviewer=file-view-default
# A lot of this script came from here:
# http://stackoverflow.com/questions/96882/how-do-i-create-a-nice-looking-dmg-for-mac-os-x-using-command-line-tools
source="install_temp"
title="Switch"
finalDMGName="Switch.dmg"
size=150000

mkdir "${source}"
cp -R Switch.app "${source}"
cp -R source_code "${source}"
cp LICENSE "${source}"
cp HOWTO.txt "${source}"

#remove any previously existing build
rm -f "${finalDMGName}"

hdiutil create -srcfolder "${source}" -volname "${title}" -fs HFS+ -fsargs "-c c=64,a=16,e=16" -format UDRW -size ${size}k pack.temp.dmg
device=$(hdiutil attach -readwrite -noverify -noautoopen "pack.temp.dmg" | egrep '^/dev/' | sed 1q | awk '{print $1}')
sleep 2
chmod -Rf go-w /Volumes/"${title}"
sync
sync
hdiutil detach ${device}
hdiutil convert "pack.temp.dmg" -format UDZO -imagekey zlib-level=9 -o "${finalDMGName}"
rm -f pack.temp.dmg
rm -R "${source}"

clear

#create the upload automation script
    cd ../
    user="#$(grep 'bitbucket.org' "$dir"/.hg/hgrc | cut -d "." -f2 | cut -d "/" -f2)"
    password="$(grep '@bitbucket.org' "$dir"/.hg/hgrc | cut -d ":" -f3 | cut -d "@" -f1)"
    downloads="/"$(grep 'bitbucket.org' "$dir"/.hg/hgrc | cut -d "." -f2 | cut -d "/" -f2,3)"/downloads"
    item="$(echo " "$dir"/Switch.dmg")"

#print password to external upload script
    echo "$user"" $password"" $downloads""$item" > switch_upload

#external upload script. Will be placed in home folder
cat <<'EOF' >> switch_upload

#!/bin/bash
    usr=$1; pwd=$2; pge=$3; fil=$4

    echo "actual upload progress should appear right now as a progress bar, be patient:"
    curl --progress-bar           `# print the progress visually                                                                          ` \
         --location               `# follow redirects if we are told so                                                                 ` \
         --fail                   `# ensure that we are not succeeding when the server replies okay but with an error code             ` \
         --user "$usr:$pwd"       `# basic auth so that it lets us in                                                                ` \
         --form files=@"$fil" "https://api.bitbucket.org/2.0/repositories/${pge#/}" 1> tmp1 #
    rm tmp1 

EOF
    

#run the upload automation script
. switch_upload $(cat switch_upload | head -1 | tr -d '#')
rm switch_upload
rm "$dir"/Switch.dmg

#back to start
    cd "$dir"/source_code
. Build_dmg_package.command
    fi
;;

    "Q")  echo "case sensitive!!"   ;;
     * )  echo "invalid option"     ;;
    esac
    sleep 0.5
done






