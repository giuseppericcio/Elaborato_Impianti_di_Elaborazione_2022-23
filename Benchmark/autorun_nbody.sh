#!/bin/bash

# Number of times to restart WSL
num_restarts=1

cd nbody/

for  i in $(seq 1 $num_restarts); do
  # Run program
  bash ./launch_nbody.sh -r 5 -n 100000 >> results100000.txt
done