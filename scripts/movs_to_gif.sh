#!/bin/bash

# Check dependencies are installed
printf "\e[1;32m%s\e[m\n" "Converting mov videos to gif"

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
    printf "Processing ${filename}...\n"
    mov_to_gif ${filename}
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

