#!/bin/bash

mkfifo /tmp/pipe 
chmod a+w /tmp/pipe

echo "Content-type: text/html"
echo ""
cat /tmp/pipe
rm /tmp/pipe
