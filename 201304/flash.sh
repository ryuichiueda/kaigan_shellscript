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

### ビール瓶から国民に光を与える
tail -n +5 $tmp-ppm	|
awk -v w=$W -v h=$H -v d=$D \
	'NR%3==1{n=(NR-1)/3;r[n%w,int(n/w)] = $1}
	NR%3==2{n=(NR-2)/3;g[n%w,int(n/w)] = $1}
	NR%3==0{n=(NR-3)/3;b[n%w,int(n/w)] = $1}
	END{
		print "P3",w,h,d;
		for(y=0;y<h;y++){
			for(x=0;x<w;x++){
				ex = x - w*0.87;
				ey = y - h*0.32;
				deg = atan2(ey,ex)*360/3.141592 + 360;
				weight = (int(deg/15)%2) ? 1 : 4;
	
				p(r[x,y]*weight);
				p(g[x,y]*weight);
				p(b[x,y]);
			}
		}
	}
	function p(n){ print (n>d)?d:n }'	

rm -f $tmp-*
exit 0
