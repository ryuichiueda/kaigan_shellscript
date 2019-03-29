#!/bin/bash -xv

ssh -p 21922 www.araibo.com "nc -l 10000 > TESTDATA" &

while ! cat TESTDATA > /dev/tcp/www.usptomo.com/10000 ; do
	sleep 0.1
done
