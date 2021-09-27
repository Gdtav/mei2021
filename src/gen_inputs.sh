#!/bin/bash

# first argument isthe probability (p) that each 
# pair of exams will have a student in common, 
# second argument is the random seed
for (( i=5; i <= 50; i+=5 ))
do
    python gen.py $i $1 $2 ../data/size_$i.in
done
