#!/bin/bash
BIKES=("splendor" "glamour" "FZ" "Unicorn")

echo "First Bike ${BIKES[1]}"
echo "Second Bike ${BIKES[2]}"
echo "Third Bike ${BIKES[3]}"

echo "All Bikes ${BIKES[@]}"
echo "All Bikes ${BIKES[*]}"