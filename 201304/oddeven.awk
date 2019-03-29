#!/usr/bin/awk -f

START{even=0;odd=0}
$1%2==0{even++}
$1%2==1{odd++}
END{print "奇数:",odd;print "偶数:",even}
