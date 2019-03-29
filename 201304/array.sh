#!/bin/bash

cat << FIN > ./hoge
東京 ビッグサイト
名古屋 撃ち
大阪 球場
FIN

#配列のインデックスに文字列を指定
cat ./hoge			|
awk '{a[$1]=$2}END{print "大阪" a["大阪"]}'

#配列のインデックスに文字列を指定
cat ./hoge			|
awk '{a[$1]=$2}END{for(i in a){print i a[i]}}'
