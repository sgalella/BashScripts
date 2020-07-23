#!/bin/bash

# Check dependencies are installed
# ffmpeg
if command -v ffmpeg > /dev/null 2>&1
then
	echo "fmmpeg found!"
else
	echo "ffmpeg not found!"
	exit 1
fi
# sips
if command -v sips > /dev/null 2>&1
then
	echo "sips found!"
else
	echo "sips not found!"
	exit 1
fi
#gifsicle
if command -v gifsicle > /dev/null 2>&1
then
	echo "gisicle found!"
else
	echo "gisicle not found!"
	exit 1
fi
echo "All dependencies found!"

# Transform mov into pngs using ffpeg
echo "Creating pngs..."
mkdir ./pngs
ffmpeg -i $1 -r 10 ./pngs/out%04d.png > /dev/null 2>&1

# Transform pngs into individual gif files
echo "Creating gifs..."
mkdir ./gifs
sips -s format gif ./pngs/*.png --out ./gifs > /dev/null 2>&1

# Assemble gifs into one
echo "Merging gifs..."
cd gifs
gifsicle --optimize=3 --delay=10 --loopcount *.gif > animation.gif

# Move gif to current directory and remove temporal files
echo "Removing temporal files..."
mv animation.gif ../
cd ..
rm -rf ./pngs
rm -rf ./gifs