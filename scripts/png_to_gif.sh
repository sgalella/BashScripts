#!/bin/bash

# Check if arguments given
printf "\e[1;32m%s\e[m\n" "Converting png images to gif"

# Images folder
if [ -z "$1" ]
then
	printf "\e[0;31m%s\e[m\n" "Images directory not provided! Run script as ./png_to_gif.sh image_dir delay"
	exit 1
fi
# Gif delay
if [ -z "$2" ]
then
	printf "\e[0;31m%s\e[m\n" "Gif delay not provided! Run script as ./png_to_gif.sh image_dir delay"
	exit 1
fi

# Check dependencies are installed
# sips
if command -v sips > /dev/null 2>&1
then
	printf "\e[0;32m%s\e[m\n" "sips found!"
else
	printf "\e[0;31m%s\e[m\n" "sips not found!"
	exit 1
fi

# Gifsicle
if command -v gifsicle > /dev/null 2>&1
then
	printf "\e[0;32m%s\e[m\n" "gisicle found!"
else
	printf "\e[0;31m%s\e[m\n" "gisicle not found!"
	exit 1
fi
printf "\e[0;32m%s\e[m\n" "All dependencies found!"

# Transform pngs into individual gif files
printf "Creating gifs...\n"
mkdir ./gifs
sips -s format gif $1/*.png --out ./gifs > /dev/null 2>&1

# Assemble gifs into one
printf  "Merging gifs...\n"
cd gifs
gifsicle --optimize=3 --delay=$2 --loopcount *.gif > ../animation.gif

# Move gif to current directory and remove temporal files
printf "Removing temporal files...\n"
cd ..
rm -rf ./gifs
