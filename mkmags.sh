#!/bin/bash

# name of font to use
# Replace "JFR2-eroded" with your own valid font name 
# must be in ImageMagick's type.xml file
FONT=JFR2-eroded

# output format of first-pass 2d image
# PNG is fine
# I can't think of any reason to change this.
OUT=PNG				

# Font size
# I had to use a large one to get around some gap issues.
# Don't change this unless you know what you're doing.
SIZE=240

# size of subsets
# This determines how many characters will be in each image/part
N=5

# text to turn into individual image files per $N chars
TEXT=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789

# character length of full set
LEN=${#TEXT}

# Variable to be used to build each image's text
LABEL=""

# New directory to put files in
# THIS WILL BE MOVED/DELETED IF IT EXISTS!
DIR=/Users/farris/git/frijmags/images/$FONT-magnets

# Path to online-convert.sh
# See: <https://github.com/onlineconvert/onlineconvert-api-example-codes/blob/master/Bash/online-convert.sh>
OCPATH=/Users/farris/git/frijmags/bin/

# Don't use this.
# Use a ~/.online-convert config file instead
# See online-convert.com for details
#OCAPIKEY=

mv $DIR $DIR.bak
rm -rf $DIR
mkdir $DIR

for i in $(seq 1 $LEN)
do
  echo "Item # $i is ${TEXT:$i-1:1}"
  LABEL="$LABEL${TEXT:$i-1:1}"
  if (( ${#LABEL} % $N == 0 )); then
    convert -fill black -font $FONT -pointsize $SIZE label:" $LABEL " $DIR/$FONT-$LABEL.$OUT
    echo "LOOP LABEL=' $LABEL '"
    LABEL=""
  fi
done

if (( ${#LABEL} % $N != 0 )); then
  convert -fill black -font $FONT -pointsize $SIZE label:" $LABEL " $DIR/$FONT-$LABEL.$OUT
  echo "REMAINDER LABEL=' $LABEL '"
fi

cd $DIR
for img in *$OUT; do
  $OCPATH/online-convert.sh -F $img
done
