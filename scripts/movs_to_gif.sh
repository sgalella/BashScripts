#!/bin/bash

# Check dependencies are installed
printf "Checking dependencies...\n"

# FFmpeg
if command -v ffmpeg > /dev/null 2>&1
then
	printf "fmmpeg found!\n"
else
	printf "ffmpeg not found!\n"
	exit 1
fi

# sips
if command -v sips > /dev/null 2>&1
then
	printf "sips found!\n"
else
	printf "sips not found!\n"
	exit 1
fi

# Gifsicle
if command -v gifsicle > /dev/null 2>&1
then
	printf "gisicle found!\n"
else
	printf "gisicle not found!\n"
	exit 1
fi

printf "All dependencies found!\n\n"

# Define function to convert each mov to gif
if [ -d "./pngs" ]; then
    rm -rf ./pngs
fi

if [ -d "./gifs" ]; then
    rm -rf ./gifs
fi

mov_to_gif() {
    mkdir ./pngs
    NAME="$(cut -d'.' -f1 <<< $1)"
    ffmpeg -i $1 -r 10 ./pngs/out%04d.png > /dev/null 2>&1
    mkdir ./gifs
    sips -s format gif ./pngs/*.png --out ./gifs > /dev/null 2>&1
    cd gifs
    gifsicle --optimize=3 --delay=10 --loopcount *.gif > $NAME.gif
    mv $NAME.gif ../
    cd ..
    rm -rf ./pngs
    rm -rf ./gifs
}

# Convert all .mov into .gif
for filename in *.mov; do
    printf "Processing ${filename}\n"
    mov_to_gif ${filename}
    printf "Conversion of ${filename} completed!\n\n"
done

if [ $# -eq 0 ]; then
    gifname="animation.gif"
else
    gifname="$1.gif"
fi

# Merge all gifs into one
if [ -f $gifname ]; then
    rm $gifname
fi

gifsicle *.gif > $gifname


printf "Merged gifs saved as ${gifname}\n"

