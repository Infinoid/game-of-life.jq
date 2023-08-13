#!/bin/bash

jq . in.json >cur.json

for T in `seq 1 40`; do
    clear
    echo T=$T
    # print the board in a readable way (insert newlines in the right places)
    cat cur.json | jq -c . | perl -pe 's/(\],?)/\1\n/g; s/\[\[/[\n[/'
    sleep 0.15
    # evolve the board
    jq -f gol.jq cur.json > new.json

    mv new.json cur.json
done
