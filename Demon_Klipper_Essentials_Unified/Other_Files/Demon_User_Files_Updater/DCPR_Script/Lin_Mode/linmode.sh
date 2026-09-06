#!/bin/sh

U="$USER"
OPF="/home/$U/TMP_DCPR.txt"

#echo "linmode is: $1"
echo "variable_random_clean_x: $1" >> "$OPF"
wait
echo "variable_random_clean_y: $1" >> "$OPF"
wait

