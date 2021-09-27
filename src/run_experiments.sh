#!/bin/bash

# first argument is the random seed for the algorithm
# second argument is the maximum time allowed per run
# third argument is the input filename
for (( i=5; i <= 50; i+=5 ))
do
    ../bin/code1 $1 $2 ../data/size_$i.in >> ../data/code1.out
done
for (( i=5; i <= 50; i+=5 ))
do
    ../bin/code2 $1 $2 ../data/size_$i.in >> ../data/code2.out
done
