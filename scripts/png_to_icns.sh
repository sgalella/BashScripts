#!/bin/bash

# Check dependencies
printf "\e[1;32m%s\e[m\n" "Converting png images to icns"

# ImageMagick
if command -v convert -version > /dev/null 2>&1
then
	printf "\e[0;32m%s\e[m\n" "ImageMagick found!"
else
	printf "\e[0;31m%s\e[m\n"  "ImageMagick not found!"
	exit 1
fi

# Check image has equal width and height
printf "Checking if image is square...\n"
size=$(identify -format "%wx%h" $1)
width="$(cut -d'x' -f1 <<< $size)"
height="$(cut -d'x' -f2 <<< $size)"
if [ $width != $height ]
then
	printf "\e[0;31m%s\e[m\n"  "Input image needs to be square (width = height)"
	exit 1
fi

# Create get iconset folder
printf "Creating iconset folder...\n"
NAME="$(cut -d'.' -f1 <<< $1)"
ICNSNAME=${NAME}.iconset
mkdir $ICNSNAME

# Copy and resize images
printf "Copying and resizing imagaes...\n"
convert $1 -resize 1024 $ICNSNAME/icon_512x512@2x.png
convert $1 -resize 512 $ICNSNAME/icon_512x512.png
convert $1 -resize 512 $ICNSNAME/icon_256x256@2x.png
convert $1 -resize 256 $ICNSNAME/icon_256x256.png
convert $1 -resize 256 $ICNSNAME/icon_128x128@2x.png
convert $1 -resize 128 $ICNSNAME/icon_128x128.png
convert $1 -resize 64 $ICNSNAME/icon_32x32@2x.png
convert $1 -resize 32 $ICNSNAME/icon_32x32.png
convert $1 -resize 32 $ICNSNAME/icon_16x16@2x.png
convert $1 -resize 16 $ICNSNAME/icon_16x16.png

# Convert to icns
printf "Converting to icns...\n"
iconutil -c icns $ICNSNAME

# Remove temporal files
printf "Removing temporal files...\n"
rm -rf $ICNSNAME



