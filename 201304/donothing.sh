#!/bin/bash -xv

tmp=/tmp/$$

### 画像の変換
convert -compress none "$1" $tmp-i.ppm

### データを縦一列に並べる

#コメント除去
sed 's/#.*$//' $tmp-i.ppm	|
tr ' ' '\n'			|
#空行を除去
awk 'NF==1'	> $tmp-ppm

### ヘッダ情報取り出し
W=$(head -n 2 $tmp-ppm | tail -n 1)
H=$(head -n 3 $tmp-ppm | tail -n 1)
D=$(head -n 4 $tmp-ppm | tail -n 1)

### 画素の値を配列に
tail -n +5 $tmp-ppm	|
awk -v w=$W -v h=$H -v d=$D \
	'NR%3==1{n=(NR-1)/3;r[n%w,int(n/w)] = $1}
	NR%3==2{n=(NR-2)/3;g[n%w,int(n/w)] = $1}
	NR%3==0{n=(NR-3)/3;b[n%w,int(n/w)] = $1}'

rm -f $tmp-*
exit 0
