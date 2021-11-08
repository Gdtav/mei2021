#!/bin/bash

# first argument is the random seed for the algorithm
# second argument is the maximum time allowed per run
# third argument is the input filename
sh gen_inputs.sh
for (( i=10; i <= 50; i+=10 ))
do
    for j in 0.05 0.1 0.2 0.25 0.33
    do
        echo "probability: $j" >> ../data/code1/size_$i.out
        echo "probability: $j" >> ../data/code2/size_$i.out
        for (( k=1; k <= 5; k+=1 ))
        do
            ../bin/code1 $(($i/5)) $1 ../data/input/$i-$j.in >> ../data/code1/size_$i.out &
            ../bin/code2 $(($i/5)) $1 ../data/input/$i-$j.in >> ../data/code2/size_$i.out &
        done
        wait
    done
done

python3 convertTables.py