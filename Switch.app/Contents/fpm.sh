#!/usr/bin/env bash

# fpm.sh
#
# http://www.magiclantern.fm/forum/index.php?topic=16054
#
# For removing focus pixels from Magic Lantern raw video
# files shot on on Canon 100D, 650D, 700D and EOSM cameras.
#
# Will create a text file with the focus pixel coordinates in a
# plain text file in either dcraw ".badpixels" format or with just
# the xy coordinates using a Magic Lantern raw video version 2.x
# (MLV) file as the input. Can also be used with DNG and Magic
# Lantern RAW version 1.0 files but requires user input for the
# video mode and in the case of RAW files also the camera model.
#
# Mode          Buffer Size   Notes
#
# mv1080      - 1808x1190  -  Uses full sensor area with a 3x3
#                             line skipping pattern.
#                             Not available on the EOSM.
#                             Canon menu setting 1920x1080 24/25/30.
#
# mv720       - 1808x727   -  Uses full sensor area with a 3x5
#                             line skipping pattern.
#                             Needs to be stretched by 1.67x
#                             vertically - up to 50/60 fps.
#                             Limited to 24/30 on EOSM.
#                             Canon menu setting 1280x720 50/60.
#
# mv640       - 1808x1190  -  Basically the same as mv1080 mode when
#                             shooting MLV/RAW.
#                             Canon menu setting 640x480 25/30.
#
# mv1080crop  - 1872x1060  -  CROP_MODE_HACK
#                             This hack brings video crop mode back to
#                             cameras that initially didn't support it
#                             (e.g. 650D 700D 100D EOSM)
#
# mv640crop   -            -  Not available on these cameras.
#
# zoom        - 2592x1108  -  Same 5x magnification as mv1080crop but
#                             can pan around sensor and achieve
#                             higher resolution than mv1080crop.
#
# crop_rec    - 1808x727   -  Requires crop_rec module.
#                             Uses mv720 raw buffer but records in
#                             3x3 line skipping like mv1080.
#
# With zoom mode a new badpixels file should to be made every time
# that the pan position changes. The may happen when using Digital Dolly.
#
# When zoom mode is used with RAW or DNG files the script assumes that
# the zoom box was centered when the shot was taken which might not be
# correct.
#
# This script does very little error checking and outputs no messages
# unless the -v Verbose option is used.
#
# Copyright (C) 2016 Magic Lantern Team
#
# This program is free software; you can redistribute it and/or
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
#/

##
# usage() function
# Print help message.
#
usage() {
cat << EOF
Usage:
fpm.sh [-hv] [-c cam] [-m mode] [-s size] [-o output] <input_file>
Parameters:
    -h              Show this message
    -m mode         Video Mode [crop_rec, mv1080, mv720, mv1080crop, zoom]
    -c              Camera [EOSM, 100D, 650D, 700D]
    -s WIDTHxHEIGHT Image Size in pixels (no spaces)
    -o filename     Customize Filename
    -f fpm dcraw    Output format - dcraw is in the ".badpixels" format with
                    the UNIX time of death field set to zero
    -n              Do not subtract cropX/Y values from x/y coordinates
                    creates a focus pixel map that covers the full raw buffer
                    usable in MLVFS
    -v              Verbose messages - for debugging
Any spaces in parameters must be quoted i.e., -c "Canon EOS 700D"

example:
    ./fpm.sh -o M21-1747_1_2015-12-06_0001_C0000.txt M21-1747.MLV

    creates a dcraw ".badpixels" formatted file named
    M21-1747_1_2015-12-06_0001_C0000.txt that can be used to remove
    the focus pixels from a Magic Lantern raw video file named M21-1747.MLV

This script will create a focus pixel map file "fpm" or dcraw ".badpixels"
format to remove focus pixels from an MLV file shot with cameras that show
focus pixels in raw video.

EOS Rebel T4i / 650D / Kiss X6i
EOS Rebel T5i / 700D / Kiss X7i
EOS Rebel SL1 / 100D / Kiss X7
EOS M
EOS M2 (not yet implimented)

Works with MLV, RAW (requires -c and -m parameters)
and DNG (requires -m parameter)

EOF
}

##
# get_camera_info() function
# Sync various possible camera names and ID codes.
#
get_camera_info() {
  if [ -z "$camera_model" ]; then
    if  [[ "$camera" == *"650D" || "$camera" == *"T4i" || "$camera" == *"X6i" ]]; then
      camera_model=80000301
      camera="650D"
    elif [[ "$camera" == *"700D" || "$camera" == *"T5i" || "$camera" == *"X7i" ]]; then
      camera_model=80000326
      camera="700D"
    elif [[ "$camera" == *"M" ]]; then
      camera_model=80000331
      camera="EOSM"
    elif [[ "$camera" == *"100D" || "$camera" == *"SL"* || "$camera" == *"X7" ]]; then
      camera_model=80000346
      camera="100D"
    else usage
    fi
  fi

  if [ -z "$camera" ]; then
    if   [[ "$camera_model" == 80000301 ]]; then camera="650D"
    elif [[ "$camera_model" == 80000326 ]]; then camera="700D"
    elif [[ "$camera_model" == 80000331 ]]; then camera="EOSM"
    elif [[ "$camera_model" == 80000346 ]]; then camera="100D"
    fi
  fi
}

##
# output_row() function
# Write a row of focus pixel coordinates to the output file.
#
output_row() {
  for i in $(seq 72 $((raw_width - 1)) ); do # 0-71 is out of bounds
    if (( (($i + $skip)) % x_rep == 0 )); then
      if [[ "$cropXY" == no ]]; then
        ((x = $i))
        ((y = $j))
       if (( "$x" >= 0 )) && (( "$y" >= 0 )); then
         if [[ "$format" == fpm ]]; then
            echo -e "$x \t $y" >> "$output"
         else
            echo -e "$x \t $y \t 0" >> "$output"
          fi
        fi
      else
        ((x = $i - $cropX))
        ((y = $j - $cropY))
      if (( "$x" >= 0 )) && (( "$y" >= 0 )); then
        if (( "$x" < "$width" )) && (( "$y" < "$height" )); then
          if [[ "$format" == fpm ]]; then
            echo -e "$x \t $y" >> "$output"
          else echo -e "$x \t $y \t 0" >> "$output"
          fi
        fi
      fi
    fi
  fi
  done
}

##
# mv720() function
# Draw the focus pixel pattern for mv720 video mode.
#
mv720() {
  if   [ $pattern == "A" ]; then fp_start=28; fp_end=726; x_rep=8; y_rep=12
  elif [ $pattern == "B" ]; then fp_start=28; fp_end=726; x_rep=8; y_rep=12
  else exit 1
  fi

  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if   (( (($j +  3)) % y_rep == 0 )); then skip=7
    elif (( (($j +  4)) % y_rep == 0 )); then skip=6
    elif (( (($j +  9)) % y_rep == 0 )); then skip=3
    elif (( (($j + 10)) % y_rep == 0 )); then skip=2
    else continue
    fi
    output_row
  done
}

##
# mv1080() function
# Draw the focus pixel pattern for mv1080 video mode.
#
mv1080() {
  if   [ $pattern == "A" ]; then fp_start=28; fp_end=1189; x_rep=8; y_rep=10
  elif [ $pattern == "B" ]; then fp_start=28; fp_end=1189; x_rep=8; y_rep=10
  else exit 1
  fi

  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if   (( (($j +  0)) % y_rep == 0 )); then skip=0
    elif (( (($j +  1)) % y_rep == 0 )); then skip=1
    elif (( (($j +  5)) % y_rep == 0 )); then skip=5
    elif (( (($j +  6)) % y_rep == 0 )); then skip=4
    else continue
    fi
    output_row
  done
}

##
# mv1080crop() function
# Draw the focus pixel pattern for mv1080crop video mode.
#
# This is a 2-pass map. First the regular map file and then
# shift everything one pixel to the right for pattern A cameras
# and eight pixels to the right for pattern B cameras to cover those
# focus pixels that show up on 8...12-bit lossless compression.
#
mv1080crop_shifted() {
  if   [ $pattern == "A" ]; then fp_start=28;  fp_end=1058; x_rep=8;  y_rep=60
  elif [ $pattern == "B" ]; then fp_start=28;  fp_end=1058; x_rep=12; y_rep=6
  else exit 1
  fi
  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if [ $pattern == "A" ]; then
      if   (( (($j +   7)) % $y_rep == 0 )); then skip=2
      elif (( (($j +  11)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  12)) % $y_rep == 0 )); then skip=1
      elif (( (($j +  26)) % $y_rep == 0 )); then skip=7
      elif (( (($j +  29)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  37)) % $y_rep == 0 )); then skip=6
      elif (( (($j +  41)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  42)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  44)) % $y_rep == 0 )); then skip=3
      elif (( (($j +  56)) % $y_rep == 0 )); then skip=7
      elif (( (($j +  59)) % $y_rep == 0 )); then skip=0
      else continue
      fi
    elif [ $pattern == "B" ]; then
      if   (( (($j +  2)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  5)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  6)) % $y_rep == 0 )); then skip=10
      elif (( (($j +  7)) % $y_rep == 0 )); then skip=11
      else continue
      fi
    fi
    output_row
  done
  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if [ $pattern == "A" ]; then
      if (( (($j +  14)) % $y_rep == 0 )); then skip=3
      else continue
      fi
    elif [ $pattern == "B" ]; then break
    fi
    output_row
  done
}

mv1080crop() {
  if   [ $pattern == "A" ]; then fp_start=28;  fp_end=1058; x_rep=8;  y_rep=60
  elif [ $pattern == "B" ]; then fp_start=28;  fp_end=1058; x_rep=12; y_rep=6
  else exit 1
  fi
  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if [ $pattern == "A" ]; then
      if   (( (($j +   7)) % $y_rep == 0 )); then skip=3
      elif (( (($j +  11)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  12)) % $y_rep == 0 )); then skip=2
      elif (( (($j +  26)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  29)) % $y_rep == 0 )); then skip=1
      elif (( (($j +  37)) % $y_rep == 0 )); then skip=7
      elif (( (($j +  41)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  42)) % $y_rep == 0 )); then skip=6
      elif (( (($j +  44)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  56)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  59)) % $y_rep == 0 )); then skip=1
      else continue
      fi
    elif [ $pattern == "B" ]; then
      if   (( (($j +  2)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  5)) % $y_rep == 0 )); then skip=1
      elif (( (($j +  6)) % $y_rep == 0 )); then skip=6
      elif (( (($j +  7)) % $y_rep == 0 )); then skip=7
      else continue
      fi
    fi
    output_row
  done

  ##
  # This row needs to be run in a separate pass in order to
  # support applications that average adjacent diagonal pixels
  if [ $pattern == "A" ]; then
    for j in $(seq $((fp_start)) $((fp_end)) ); do
      if (( (($j +  14)) % $y_rep == 0 )); then skip=4
      else continue
      fi
      output_row
    done
  fi

  ##
  # Here we could test for 8...12-bit lossless compression
  # to see if we need to run a second pass offset by 1-pixel
  # for the pattern A or 8-pixels for pattern B cameras.
  #
  mv1080crop_shifted;
}

##
# zoom() function
# Draw the focus pixel pattern for zoom video mode.
#
zoom() {
  if   [ $pattern == "A" ]; then fp_start=28; fp_end=1107; x_rep=8;  y_rep=60
  elif [ $pattern == "B" ]; then fp_start=28; fp_end=1107; x_rep=12; y_rep=6
  else exit 1
  fi
  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if [ $pattern == "A" ]; then
      if   (( (($j +   7)) % $y_rep == 0 )); then skip=3
      elif (( (($j +  11)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  12)) % $y_rep == 0 )); then skip=2
      elif (( (($j +  26)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  29)) % $y_rep == 0 )); then skip=1
      elif (( (($j +  37)) % $y_rep == 0 )); then skip=7
      elif (( (($j +  41)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  42)) % $y_rep == 0 )); then skip=6
      elif (( (($j +  44)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  56)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  59)) % $y_rep == 0 )); then skip=1
      else continue
      fi
    elif [ $pattern == "B" ]; then
      if   (( (($j +  2)) % $y_rep == 0 )); then skip=0
      elif (( (($j +  5)) % $y_rep == 0 )); then skip=1
      elif (( (($j +  6)) % $y_rep == 0 )); then skip=6
      elif (( (($j +  7)) % $y_rep == 0 )); then skip=7
      else continue
      fi
    fi
    output_row
  done

  ##
  # This row needs to be run in a separate pass in order to
  # support applications that average adjacent diagonal pixels
  if [ $pattern == "A" ]; then
    for j in $(seq $((fp_start)) $((fp_end)) ); do
      if (( (($j +  14)) % $y_rep == 0 )); then skip=4
      else continue
      fi
      output_row
    done
  fi

  ##
  # The 100D in 8...12bit lossless mode has the focus pixels
  # shifted 8 pixels to the right (or 4 to the left).
  # Is this consistant or something that might happen on occasion?
  # Since we don't know we'll always cover them in a second pass.
  # This is another place to check for 8..12bit lossless compression.
  if [ $pattern == "B" ]; then
    for j in $(seq $((fp_start)) $((fp_end)) ); do
      if   (( (($j +  2)) % $y_rep == 0 )); then skip=4
      elif (( (($j +  5)) % $y_rep == 0 )); then skip=5
      elif (( (($j +  6)) % $y_rep == 0 )); then skip=10
      elif (( (($j +  7)) % $y_rep == 0 )); then skip=11
      else continue
      fi
      output_row
    done
  fi
}

##
# crop_rec() function
# Draw the focus pixel pattern for crop_rec video mode.
#
# EOSM always requires a two passes that basically combines the
# mv1080 and mv720 focus pixel patterns.
#
# When selecting the -n "no crop" option we could assume that
# we're making a map file to be used in MLVFS which doesn't
# differentiate between mv720 and crop_rec so the script
# creates a 2-pass map that can be used with either video mode.
#
crop_rec() {
  if [ $camera == "EOSM" ] || [ $cropXY == "no" ]; then mv720; fi
  if   [ $pattern == "A" ]; then fp_start=28;  fp_end=726;  x_rep=8; y_rep=10
  elif [ $pattern == "B" ]; then fp_start=28;  fp_end=726;  x_rep=8; y_rep=10
  else exit 1
  fi

  for j in $(seq $((fp_start)) $((fp_end)) ); do
    if   (( (($j +  0)) % y_rep == 0 )); then skip=0
    elif (( (($j +  1)) % y_rep == 0 )); then skip=1
    elif (( (($j +  5)) % y_rep == 0 )); then skip=5
    elif (( (($j +  6)) % y_rep == 0 )); then skip=4
    else continue
    fi
    output_row
  done
}

##
# Start of main section
#

workingDir=`dirname "$0"`
cd "${workingDir}"

##
# Initialize variables.
#
MLP=
RAW=
DNG=
VERBOSE=
output=
format="fpm"
output_file_ext=
cropXY="yes"
camera=
camera_model=
video_mode=
width=
height=
resolution=
sampling=

##
# Allow for upper or lower case user input
# and read the command line options.
#
shopt -s nocasematch

while getopts "c:f:nhm:o:s:v" OPTION; do
  case $OPTION in
  c)camera="$OPTARG"
    get_camera_info
    ;;
  f)format="$OPTARG"
    ;;
  n)cropXY="no"
    ;;
  h)usage
    exit 0
    ;;
  m)video_mode="$OPTARG"
    ;;
  o)output="$OPTARG"
    ;;
  s)resolution="$OPTARG"
    ;;
  v)VERBOSE=1
    ;;
  :)echo "Error: -$OPTARG requires an argument"
    usage
    exit 1
    ;;
  ?)usage
    exit 1
    ;;
  esac
done

shift $((OPTIND - 1))

##
# Can't find the input file.
# Print help file.
#
if [[ -z $1 ]]; then
  usage
  exit 1
fi

filename=$(basename "$1")
extension="${filename##*.}"

##
# Use plain x [tab] y formatted output
# or dcraw format.
#
if [ "$format" == "fpm" ]; then
  output_file_ext=".fpm"
elif [ "$format" == "dcraw" ]; then
  output_file_ext=".txt"
else
  usage
  exit 1
fi

##
# Determine file type using the
# file extension.
#
case $extension in
  MLV)
    filetype=mlv
    ;;
  RAW)
    filetype=raw
    ;;
  DNG)
    filetype=dng
    ;;
  *) exit 1
    ;;
esac

##
# Read metadata from MLV file
#
if [ "$filetype" == "mlv" ]; then
  MLV="$1"

  if [ -z "$camera_model" ]; then
    camera_model=`mlv_dump -v "$MLV" | grep Camera"[[:space:]]"Model | head -1 | sed -e 's/^[ Camera \s Model: \s 0x]*//'`
  fi

  get_camera_info

  if [[ -z $resolution ]]; then
    resolution=`mlv_dump -v "$MLV" | grep Res | head -1 | sed -e 's/^[ Res:]*//'`
  fi

  raw_width=`mlv_dump -v "$MLV" | grep width | head -1 | sed -e 's/^[ width]*//'`
  raw_height=`mlv_dump -v "$MLV" | grep height | head -1 | sed -e 's/^[ height]*//'`
  raw_buffer=$raw_width"x"$raw_height

  sampling=`mlv_dump -v "$MLV" | grep -w sampling | head -1 | sed -e 's/^[ sampling]*//'`

  pan=`mlv_dump -v "$MLV" | grep Pan | head -1 | sed -e 's/^[ Pan:]*//'`

  IFS='x'
    read -r panPosX panPosY <<< "$pan"
  unset IFS

  bits_per_pixel=`mlv_dump -v "$MLV" | grep bits_per_pixel | head -1 | sed -e 's/^[ bits_per_pixel]*//'`
  black_level=`mlv_dump -v "$MLV" | grep black_level | head -1 | sed -e 's/^[ black_level]*//'`
  white_level=`mlv_dump -v "$MLV" | grep white_level | head -1 | sed -e 's/^[ white_level]*//'`
fi

##
# Read metadata from RAW file
#
if [ "$filetype" == "raw" ]; then
  RAW="$1"

  if [[ -z $camera_model || -z $video_mode ]]; then
    if [ $VERBOSE ]; then
      echo RAW files require  -c [EOSM, 100D, 650D, 700D] and
      echo -m [crop_rec, mv1080, mv720, mv1080crop, zoom] options
    fi
    exit 1
  fi

  if [[ -z $resolution ]]; then
    width=`xxd -s -0xbc -l 2 -p "$RAW"`
    width="${width:2:2}${width:0:2}"
    width=$((16#$width))
    height=`xxd -s -0xba -l 2 -p "$1"`
    height="${height:2:2}${height:0:2}"
    height=$((16#$height))
    resolution=$width"x"$height
  fi
fi

##
# Read metadata from DNG file
#
if [ "$filetype" == "dng" ]; then
  DNG="$1"

  if [[ -z $video_mode ]]; then
    if [ $VERBOSE ]; then
      echo DNG files require -m [crop_rec, mv1080, mv720, mv1080crop, zoom] option
    fi
    exit 1
  fi

  if [[ -z $camera_model ]]; then
    camera=`exiftool -s -s -s -UniqueCameraModel "$DNG"`
    if [ $camera == "Canikon" ]; then
      if [ $VERBOSE ]; then
        echo This DNG file requires the -c [EOSM, 100D, 650D, 700D] option
      fi
    exit 1
    fi
    get_camera_info
  fi

  if [[ -z $resolution ]]; then
    resolution=`exiftool -s -s -s -ImageSize "$DNG"`
    width=`exiftool -s -s -s -ImageWidth "$DNG"`
    height=`exiftool -s -s -s -ImageHeight "$DNG"`
  fi
fi

##
# In cases where the width and height were not found
# parse it from the -s WIDTHxHEIGHT option.
#
IFS='x'
  if [[ -z $width || -z $height ]]; then
    read -r width height <<< "$resolution"
  fi
unset IFS

##
# RAW and DNG files don't have
# pan or crop metadata so we'll
# figure it out from the image size.
# Assume zoom video mode was shot with
# the zoom box centered.
#
if [ "$filetype" != "mlv" ]; then
  case $video_mode in
  mv1080)
    raw_width=1808
    raw_height=11**
    raw_buffer=1808x11**
    panMinX=616; panMinY=543
    ;;
  mv720)
    raw_width=1808
    raw_height=72*
    raw_buffer=1808x72*
    if   [ "$camera" == "650D" ] || [ "$camera" == "EOSM" ]; then
      panMinX=618; panMinY=335
    elif [ "$camera" == "700D" ] || [ "$camera" == "100D" ]; then
      panMinX=616; panMinY=336
    fi
    ;;
  mv1080crop)
    raw_width=1872
    raw_height=10**
    raw_buffer=1872x10**
    if   [ "$camera" == "650D" ] || [ "$camera" == "EOSM" ]; then
      panMinX=650; panMinY=477
    elif [ "$camera" == "700D" ] || [ "$camera" == "100D" ]; then
      panMinX=648; panMinY=480
    fi
    ;;
  zoom)
    raw_width=2592
    raw_height=110*
    raw_buffer=2592x110*
    if   [ "$camera" == "650D" ] || [ "$camera" == "EOSM" ]; then
      panMinX=905; panMinY=631
    elif [ "$camera" == "700D" ] || [ "$camera" == "100D" ]; then
      panMinX=904; panMinY=631
    fi
    ;;
  crop_rec)
    raw_width=1808
    raw_height=72*
    raw_buffer=1808x72*
    panMinX=618; panMinY=335
    ;;
  *) usage
    ;;
  esac

  panPosX=$((panMinX-(($width-640)/32)*16))

  # Assume the image is centered on the raw buffer.
  if [ $video_mode == mv720 ];then
    panPosY=$((panMinY-(($height-78)/2)))
  else panPosY=$((panMinY-(($height-128)/2)))
  fi
fi

##
# Allow for legacy MLV files with cropX, cropY bug
#
cropX=$((panPosX + 7 & ~7))
cropY=$((panPosY & ~1))

##
# Determine which pattern group, A or B
# to use depending on the camera.
# If the EOSM2 gets ported to ML it would
# probably belong to the pattern B group.
#
if ! [[ "$camera" =~ ^(100D|650D|700D|EOSM)$ ]]; then
  echo "Camera is not supported in this application."; exit 1
elif [ $camera == 650D ] || [ $camera == 700D ] || [ $camera == EOSM ]; then
  pattern="A"
elif [ $camera == 100D ]; then
  pattern="B"
fi

##
# Determine the video mode using the
# full raw buffer size. This is only
# available in MLV metadata.
# Special case for crop_rec because
# it uses the same raw buffer as mv720
#
case $raw_buffer in
  1808x11**)
    video_mode=mv1080
    ;;
  1808x72*)
    # mv_720 and crop_rec use the same buffer size
    # if the video_mode isn't defined, see if we can
    # determine it using sampling. Default to crop_rec
    # if auto detection fails because the crop_rec map
    # works with mv720 but not vice versa.
    if [ -z "$video_mode" ]; then
      if [[ "$sampling" == "5x3"* ]]; then video_mode=mv720; fi
    fi
    if [ "$video_mode" != "mv720" ]; then video_mode=crop_rec; fi
    # When selecting the -n "no crop" option we could assume that
    # we're making a map file to be used in MLVFS which doesn't
    # differentiate between mv720 and crop_rec so the script
    # creates a 2-pass map that can be used with either video mode.
    if [ "$video_mode" == "mv720" ] && [ "$cropXY" == "no" ]; then video_mode=crop_rec; fi
    ;;
  1872x10**)
    video_mode=mv1080crop
    ;;
  2592x110*)
    video_mode=zoom
    ;;
  *) exit 1
    ;;
esac

##
# Use the output file from the -o filename option
# or default to using the input filename.
# When outputting a full raw buffer map file
# use the MLVFS naming convention.
#
if [ -z "$output" ]; then
  if [[ "$cropXY" == no ]]; then
	output=$camera_model"_"$raw_buffer"$output_file_ext"
  else output=${filename%.*}_$resolution$output_file_ext
  fi
fi

##
# Non-error verbose statements are here.
#
if [ $VERBOSE ]; then
  echo
  echo Input File:"           $filename"
  echo Camera:"               $camera"
  echo Camera Model:"         $camera_model"
  echo Resolution:"           $resolution"
  echo Sampling:"             $sampling"
  echo Video Mode:"           $video_mode"
  echo Full Raw Buffer Size: "$raw_buffer"
  echo Pan:"                  $panPosX"x"$panPosY"
  echo Crop:"                 $cropX"x"$cropY"
  echo Bits Per Pixel:"       $bits_per_pixel"
  echo Black Level:"          $black_level"
  echo White Level:"          $white_level"
  if [ $bits_per_pixel -eq 14 ] && [ $white_level -lt 15000 ]; then echo "Detected a 12 or lower logical bit depth lossless compressed file"; fi
  echo Output File:"          $output"
  echo File Format:"          $format"
fi

if test -f "$output"; then
  if [ $VERBOSE ]; then echo Removing previous version; fi
  rm "$output"
fi

if [ $VERBOSE ]; then echo Writing file; fi

# Wait until file is fully written.
eval ${video_mode}

if [ $VERBOSE ]; then echo Finished; fi

exit 0
