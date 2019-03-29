#!/bin/bash -xv

tmp=/tmp/$$

sed 's/#.*$//' $1	|
tr ' ' '\n'		|
awk 'NF==1'	> $tmp-ppm

W=$(head -n 2 $tmp-ppm | tail -n 1)
H=$(head -n 3 $tmp-ppm | tail -n 1)
D=$(head -n 4 $tmp-ppm | tail -n 1)

tail -n +5 $tmp-ppm	|
awk -v w=$W -v h=$H \
	'NR%3==1{n=(NR-1)/3;r[n%w,int(n/w)] = $1}
	NR%3==2{n=(NR-2)/3;g[n%w,int(n/w)] = $1}
	NR%3==0{n=(NR-3)/3;b[n%w,int(n/w)] = $1}
	END{
		for(y=0;y<h;y++){
			for(x=0;x<w;x++){
				print r[x,y]
			}
		}
	}'	> $tmp-work

cat $tmp-work > ./aho

cat - $tmp-work << FIN
P2
$W
$H
$D
FIN

rm -f $tmp-*
exit 0
