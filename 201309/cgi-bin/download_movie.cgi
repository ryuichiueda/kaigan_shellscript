#!/bin/bash -xv

exec 2> /tmp/aho

FILE=/tmp/japanopen2006_keeper.mpeg
LENGTH=$(wc -c $FILE | awk '{print $1}')

echo "Content-Type: video/mpeg"
#echo 'Content-Disposition: attachment; filename="hoge.mpeg"'
echo "Content-Length: $LENGTH"
echo 
cat $FILE
