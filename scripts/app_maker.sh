#!/bin/bash

# Retrieve name from argument
NAME="$(cut -d'.' -f1 <<< $1)"
APPNAME="${NAME}.app"

# Check if app already exists on directory
if [ -d $APPNAME ]
then
	printf "\e[0;31m%s\e[m\n" "App ${APPNAME} already exists..."
	exit 1
else
	printf "Creating app...\n"
fi

# Create package with folders
mkdir -p "$APPNAME/Contents/MacOS"
mkdir -p "$APPNAME/Contents/Resources"
cp $1 "$APPNAME/Contents/MacOS"
echo "App $1 created!"
