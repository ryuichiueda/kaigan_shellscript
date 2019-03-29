#!/bin/bash

tmp=/tmp/$$

FILE=$tmp-file
cat < /dev/stdin > $FILE

HMAX=$(tail -n 1 $FILE | awk '{print $1}')
WMAX=$(awk '$1==0{print $2}' $FILE | tail -n 1)

#右の座標値
awk '$2!=0{$2--;print}' $FILE > $tmp-right
#左の座標値
awk -v w=$WMAX '$2!=w{$2++;print}' $FILE > $tmp-left

#下の座標値
awk '$1!=0{$1--;print}' $FILE > $tmp-bottom
#上の座標値
awk -v h=$HMAX '$1!=h{$1++;print}' $FILE > $tmp-top

n=0
for f in $FILE $tmp-{left,right,top,bottom} ; do
	awk '{print sprintf("%04d",$1),sprintf("%04d",$2),$3}' $f > $tmp-$n
	n=$((n+1))
done

loopj num=2 $tmp-{0,1,2,3,4}

rm -f $tmp-*
exit 0
