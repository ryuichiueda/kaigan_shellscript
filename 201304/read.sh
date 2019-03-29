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
	'{n=NR-1;p[n%w,int(n/w)] = $1}
	END{
		for(y=1;y<h-1;y++){
			for(x=1;x<w-1;x++){
				a = p[x-1,y-1]*2 + p[x-1,y] + p[x,y-1] - p[x,y+1] - p[x+1,y] - 2*p[x+1,y+1];
				if(a < 0){print 0}else if(a > 255){print 255}else{print a}
			}
		}
	}'	> $tmp-work

cat $tmp-work > ./aho

#	END{for(y=0;y<h;y++){for(x=0;x<w;x++){print b[x,y]}}}'	> $tmp-work

cat - $tmp-work << FIN
P2
$((W - 2))
$((H - 2))
$D
FIN

rm -f $tmp-*
exit 0
