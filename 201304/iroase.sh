#!/bin/bash -xv

tmp=/tmp/$$

sed 's/#.*$//' $1	|
tr ' ' '\n'		|
awk 'NF==1'	> $tmp-ppm

head -n 4 $tmp-ppm

tail -n +5 $tmp-ppm	|
yarr -3			|
#1:r 2:g 3:b
awk '{print 0.299*$1 + 0.587*$2 + 0.114*$3,
	-0.14713*$1 - 0.28886*$2 + 0.436*$3,
	0.615*$1 - 0.51499*$2 - 0.10001*$3}'	|
#1:y 2:u 3:v
awk '{print $1,$2*2,$3*2}'			|
awk '{print $1+1.13983*$3,$1-0.39465*$2-0.58060*$3,$1+2.03211*$2}'	|
sed 's/\.[0-9]*//g'				|
tr ' ' '\n'					|
awk '{print ($1>255) ? 255 : ($1 < 0 ? 0 : $1)}'

rm -f $tmp-*
exit 0