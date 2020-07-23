#!/bin/bash

# Check dependencies
# ImageMagick
if command -v convert -version > /dev/null 2>&1
then
	echo "ImageMagick found!"
else
	echo "ImageMagick not found!"
	exit 1
fi

# Check image has equal width and height
echo "Checking if image is square..."
size=$(identify -format "%wx%h" $1)
width="$(cut -d'x' -f1 <<< $size)"
height="$(cut -d'x' -f2 <<< $size)"
if [ $width != $height ]
then
	echo -e "\033[0;31mInput image needs to be square (width = height)\033[0m"
	exit 1
fi

# Create get iconset folder
echo "Creating iconset folder..."
NAME="$(cut -d'.' -f1 <<< $1)"
ICNSNAME=${NAME}.iconset
mkdir $ICNSNAME

# Copy and resize images
echo "Copying and resizing imagaes..."
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
echo "Converting to icns..."
iconutil -c icns $ICNSNAME

# Remove temporal files
echo "Removing temporal files..."
rm -rf $ICNSNAME



