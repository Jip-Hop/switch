workingDir=`dirname "$0"`
cd "${workingDir}"

for i in *.PPM ; do
    ffmpeg -i "$i" -pix_fmt rgb24 -vf scale=500:-1 $(basename "${i/.PPM}").tif
done