#!/bin/bash

# Retrieve name from argument
NAME="$(cut -d'.' -f1 <<< $1)"
APPNAME="${NAME}.app"

# Check if app already exists on directory
if [ -d $APPNAME ]
then
	echo "App $APPNAME already exists ..."
	exit 1
else
	echo "Creating app ..."
fi

# Create package with folders
mkdir -p "$APPNAME/Contents/MacOS"
mkdir -p "$APPNAME/Contents/Resources"
cp $1 "$APPNAME/Contents/MacOS"
echo "App $1 created!"
