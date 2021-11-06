#!/bin/bash

# first argument is the probability (p) that each 
# pair of exams will have a student in common, 
# second argument is the random seed
for (( i=10; i <= 50; i+=10 ))
do
    for j in 0.005 0.01 0.02 0.025 0.033
    do
        python gen.py $i $j $(($i/10)) "../data/input/$i-$j.in"
    done
done
