#!/bin/bash

# first argument is the probability (p) that each 
# pair of exams will have a student in common, 
# second argument is the random seed
for (( i=10; i <= 50; i+=10 ))
do
    for j in 0.05 0.1 0.25 0.33 0.5
    do
        python gen.py $i $j $(($i/10)) "../data/input/$i-$j.in"
    done
done
