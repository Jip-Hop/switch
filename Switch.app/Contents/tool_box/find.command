workingDir=`dirname "$0"`
cd "${workingDir}"
find . -maxdepth 2 -name '*.MLV' -exec mv {} "${workingDir}" \;