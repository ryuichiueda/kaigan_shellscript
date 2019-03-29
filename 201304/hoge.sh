#!/bin/bash 

echo $1 $2	|
awk 'BEGIN{
	a["グー","チョキ"] = "グー";
	a["パー","チョキ"] = "チョキ";
	}
      END{print a[$1,$2] "の勝ち"}'
