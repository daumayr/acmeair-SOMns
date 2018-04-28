#!/bin/bash
for i in $(seq 1 10)
do
  F="AcmeAir_AT$i.jtl"
  awk -v i="$i" -v vm="Traced" 'NR==1{print $0 ",Iteration,VM"} NR>1{print $0 "," i "," vm}' $F > temp.data
  if [[ $i -eq 1 ]] ; then 
    head -1  temp.data > acme.data # Copy header if it is the first file
  fi
  tail -n +2  temp.data >>  acme.data # Append from the 2nd line each file
done

for i in $(seq 1 6)
do
  F="AcmeAir_UT$i.jtl"
  awk -v i="$i" -v vm="Untraced" 'NR==1{print $0 ",Iteration,VM"} NR>1{print $0 "," i "," vm}' $F > temp.data
  tail -n +2  temp.data >>  acme.data # Append from the 2nd line each file
done

tar -cvjSf acme.data.tar.bz2 acme.data