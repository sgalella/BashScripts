#!/bin/bash

# Check if arguments given
# Images folder
if [ -z "$1" ]
then
	echo -e "\033[0;31mImages directory not provided! Run script as ./png_to_gif.sh image_dir delay\033[0m"
	exit 1
fi
# Gif delay
if [ -z "$2" ]
then
	echo -e "\033[0;31mGif delay not provided! Run script as ./png_to_gif.sh image_dir delay\033[0m"
	exit 1
fi

# Check dependencies are installed
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

# Transform pngs into individual gif files
echo "Creating gifs..."
mkdir ./gifs
sips -s format gif $1/*.png --out ./gifs > /dev/null 2>&1

# Assemble gifs into one
echo "Merging gifs..."
cd gifs
gifsicle --optimize=3 --delay=$2 --loopcount *.gif > ../animation.gif

# Move gif to current directory and remove temporal files
echo "Removing temporal files..."
cd ..
rm -rf ./gifs
