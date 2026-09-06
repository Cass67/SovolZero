#!/bin/sh

U="$USER"
OPF="/home/$U/TMP_DCPR.txt"

#echo "mode is: $1"
echo "variable_random_clean_x: $1" >> "$OPF" #"/home/$USER/test.txt"
wait
echo "variable_random_clean_y: $1" >> "$OPF" #"/home/$USER/test.txt"
wait

