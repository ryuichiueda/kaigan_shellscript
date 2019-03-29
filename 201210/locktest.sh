#!/bin/bash

exec 2> /dev/null

for n in {1..1000} ; do
{
	mkdir ./LOCK && touch ./LOCK/$n 
} &
done

