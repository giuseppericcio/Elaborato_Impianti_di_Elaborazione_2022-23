#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -r ripetirions -n bodies"
   echo -e "\t-r Number of ripetitions"
   echo -e "\t-n Number of bodies - size of the problem"
   exit 1 # Exit script after printing help
}

while getopts "r:n:" opt
do
   case "$opt" in
      r ) parameterA="$OPTARG" ;;
      n ) parameterB="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$parameterA" ] || [ -z "$parameterB" ] 
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

for (( counter=$parameterA; counter>0; counter-- ))
do
./nbodySim $parameterB
done
printf "\n"

