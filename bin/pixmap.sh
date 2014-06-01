#!/usr/local/bin/bash

# -----------------------------------------------------------------------------------------
#
# Program:     pixmap.sh
# Author:      Vitor Britto
# Description: Collection of Shell Scripts for image tasks.
#
# Important:
#       First of all, make this script executable to easily run it.
#       $ chmod u+x pixmap.sh
#
# Usage:
#       ./pixmap.sh [command] [options]
#
# Commands:
#
#       convert [input] [output]            - Convert images format
#       datauri [file name]                 - Create a data URI from a file
#       sprite [output] [name] [extension]  - Generate a Sprite Map
#       optimize [path] [extension]         - Optimize a bunch of image files
#
# Options:
#
#       -h, --help          Display help information about PixMap
#       -V, --version       Display Pixmap version number
#
#
# Alias:
#       alias pixmap="bash ~/path/to/script/pixmap.sh"
#
# -----------------------------------------------------------------------------------------


# Program Version
VERSION=0.1.0

# Include libs
source "./lib/utils.sh";
source "./lib/convert.sh";
source "./lib/datauri.sh";
source "./lib/sprite.sh";
source "./lib/optimize.sh";


# Conversion Generator
if [[ "${1}" == "-c" || "${1}" == "--convert" ]]; then
  pixmap_convert $@
  exit
fi

# DataURI Generator
if [[ "${1}" == "-d" || "${1}" == "--datauri" ]]; then
  pixmap_datauri $@
  exit
fi

# Sprite Generator
if [[ "${1}" == "-s" || "${1}" == "--sprite" ]]; then
  pixmap_sprite $@
  exit
fi

# Help
if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
  cat "./data/help.txt"
  exit
fi

# Version
if [[ "${1}" == "-V" || "${1}" == "--version" ]]; then
  echo "pixmap version: ${VERSION}"
  exit
fi
