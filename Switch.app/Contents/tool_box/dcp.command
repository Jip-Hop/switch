#!/bin/bash
workingDir=`dirname "$0"`
cd "${workingDir}"

export PATH="${workingDir}":$PATH

echo "<?xml version="\"1.0"\" encoding="\"UTF-8"\"?>
<dcpData>
  <ProfileName>"$(ls *.cube | head -1 | cut -d "." -f1)"</ProfileName>
  <CalibrationIlluminant1>17</CalibrationIlluminant1>
  <CalibrationIlluminant2>21</CalibrationIlluminant2>
  <ColorMatrix1 Rows="\"3"\" Cols="\"3"\">
    <Element Row="\"2"\" Col="\"2"\">0.643700</Element>
    <Element Row="\"2"\" Col="\"1"\">0.133500</Element>
    <Element Row="\"2"\" Col="\"0"\">-0.038200</Element>
    <Element Row="\"1"\" Col="\"2"\">0.285000</Element>
    <Element Row="\"1"\" Col="\"1"\">1.115000</Element>
    <Element Row="\"1"\" Col="\"0"\">-0.363100</Element>
    <Element Row="\"0"\" Col="\"2"\">-0.060000</Element>
    <Element Row="\"0"\" Col="\"1"\">-0.141300</Element>
    <Element Row="\"0"\" Col="\"0"\">0.723400</Element>
  </ColorMatrix1>
  <ColorMatrix2 Rows="\"3"\" Cols="\"3"\">
    <Element Row="\"2"\" Col="\"2"\">0.566800</Element>
    <Element Row="\"2"\" Col="\"1"\">0.216200</Element>
    <Element Row="\"2"\" Col="\"0"\">-0.090800</Element>
    <Element Row="\"1"\" Col="\"2"\">0.202800</Element>
    <Element Row="\"1"\" Col="\"1"\">1.246000</Element>
    <Element Row="\"1"\" Col="\"0"\">-0.428700</Element>
    <Element Row="\"0"\" Col="\"2"\">-0.096300</Element>
    <Element Row="\"0"\" Col="\"1"\">-0.063500</Element>
    <Element Row="\"0"\" Col="\"0"\">0.672200</Element>
  </ColorMatrix2>
  <ForwardMatrix1 Rows="\"0"\" Cols="\"0"\"/>
  <ForwardMatrix2 Rows="\"0"\" Cols="\"0"\"/>
  <ReductionMatrix1 Rows="\"0"\" Cols="\"0"\"/>
  <ReductionMatrix2 Rows="\"0"\" Cols="\"0"\"/>
  <EmbedPolicy>0</EmbedPolicy>
  <ToneCurve Size="\""$(grep 'LUT_1D_SIZE' *.cube | head -1 | awk '{print $2}')""\">" > test.xml
cut -c3-8 *.cube | awk 'NR>=4' > v.txt
echo "    <Element N=\""0"\" h=\""0.000000"\" v=\""0.$(cat v.txt | head -1)"\"/>" >> test.xml

echo "$(tail -n +2 v.txt)" > v.txt

while IFS= read -r lineA; do
var=$((var + 1))
echo "    <Element N=\""$var"\" h=\""0$(echo $var / $(echo "$(grep 'LUT_1D_SIZE' *.cube | awk '{print $2}')" - 1 | bc -l) | bc -l | awk '{print substr($0,0,7)}')"\" v=\""0.$lineA"\"/>" >> test.xml
done <v.txt

echo "</ToneCurve>
  <UniqueCameraModelRestriction>Canon EOS 5D Mark III</UniqueCameraModelRestriction>
  <ProfileLookTableEncoding>0</ProfileLookTableEncoding>
  <BaselineExposureOffset>-3.300000</BaselineExposureOffset>
  <DefaultBlackRender>0</DefaultBlackRender>
</dcpData>" >> test.xml

dcpTool -c test.xml ~/Library/Application\ Support/Adobe/CameraRaw/CameraProfiles/"$(ls *.cube | head -1 | cut -d "." -f1)".dcp

rm v.txt
rm test.xml

open *.dng

exit 0