#!/bin/bash

# Check dependencies are installed
printf "\e[1;32m%s\e[m\n" "Converting mov video to gif"

# FFmpeg
if command -v ffmpeg > /dev/null 2>&1
then
	printf "\e[0;32m%s\e[m\n" "fmmpeg found!"
else
	printf "\e[0;31m%s\e[m\n" "ffmpeg not found!"
	exit 1
fi

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

# Get name of the file
NAME="$(cut -d'.' -f1 <<< $1)"

# Transform mov into pngs using ffpeg
printf "Creating pngs...\n"
mkdir ./pngs
ffmpeg -i $1 -r 10 ./pngs/out%04d.png > /dev/null 2>&1

# Transform pngs into individual gif files
printf "Creating gifs...\n"
mkdir ./gifs
sips -s format gif ./pngs/*.png --out ./gifs > /dev/null 2>&1

# Assemble gifs into one
printf "Merging gifs...\n"
cd gifs
gifsicle --optimize=3 --delay=10 --loopcount *.gif > $NAME.gif

# Move gif to current directory and remove temporal files
printf "Removing temporal files...\n"
mv $NAME.gif ../
cd ..
rm -rf ./pngs
rm -rf ./gifs
