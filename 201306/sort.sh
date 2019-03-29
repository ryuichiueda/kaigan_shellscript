#!/bin/bash -xv

scp -P 10022 ./TESTDATA10M usp@demo1.usp-lab.com:~/
ssh -p 10022 usp@demo1.usp-lab.com "msort -p 8 key=1 ~/TESTDATA10M > ~/ueda.tmp"
scp -P 10022 usp@demo1.usp-lab.com:~/ueda.tmp ./TESTDATA10M.sort
