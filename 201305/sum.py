#!/usr/bin/python

import sys

key = ""
n = 1
s = 0.0

for line in sys.stdin:
	token = line.rstrip().split(" ")
	k = " ".join(token[0:2])

	if n != 1 and key != k:
		print key, s
		s = 0.0

	s += float(token[2])
	key = k
	n += 1

print key, s
