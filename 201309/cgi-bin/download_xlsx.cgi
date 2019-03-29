#!/bin/bash -xv

FILE=/tmp/book1.xlsx
LENGTH=$(wc -c $FILE | awk '{print $1}')

echo "Content-Type: application/octet-stream"
echo 'Content-Disposition: attachment; filename="hoge.xlsx"'
echo "Content-Length: $LENGTH"
echo 
cat $FILE
