#!/bin/bash

cd $(dirname $0)

self 3 1 2 ./STAFF  | LANG=C sort > ./tmp-master
self 3 1 2 ./MEMBER | LANG=C sort > ./tmp-tran

head -n 3 ./tmp*
