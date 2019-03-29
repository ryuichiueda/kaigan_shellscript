#!/bin/bash 

echo $1 |
awk '	{print scream($1,10)}
	function scream(a,n){return n==1?a:(scream(a,n-1) a)}'
