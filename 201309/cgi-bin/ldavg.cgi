#!/bin/bash -xv
exec 2> /tmp/log

PATH=/usr/local/bin:$PATH

tmp=/tmp/$$

dd bs=${CONTENT_LENGTH}	|
cgi-name -i_ -d_	> $tmp-name

host=$(nameread host $tmp-name)
port=$(nameread port $tmp-name)

ssh "$host" -p "$port" 'LANG=C sar -q'	|
grep "^..:..:.."			|
sed 's/^\(..\):\(..\):../\1時\2分/'	|
grep -v ldavg				|
tail -r					|
awk '{print NR*20+20,$1,int($4*100),$4,\
     NR*20+7,NR*20+19}'	> $tmp-sar
#1:文字y位置 2:時刻 3:棒グラフ幅 4:ldavg
#5:棒グラフy位置 6:ldavg文字y位置

cat << FIN > $tmp-svg
<svg style="width:300px;height:600px">
  <text x="0" y="20" font-size="20">$(echo $host | sed 's/.*@//')</text>
<!-- RECORDS -->
  <text x="0" y="%1" font-size="14">%2</text>
  <rect x="68" y="%5" width="%3" height="15"
    fill="navy" stroke="black" />
  <text x="70" y="%6" font-size="10" fill="white">%4</text>
<!-- RECORDS -->
</svg>
FIN

echo "Content-Type: text/html"
echo
mojihame -lRECORDS $tmp-svg $tmp-sar

rm -f $tmp-*
exit 0
