workingDir=`dirname "$0"`
cd "${workingDir}"
find . -maxdepth 2 -name '*.M*' -exec mv {} "${workingDir}" \;
rm *.fpm
rm -r *0001_C0000
osascript -e 'tell application "Terminal" to close first window' & exit