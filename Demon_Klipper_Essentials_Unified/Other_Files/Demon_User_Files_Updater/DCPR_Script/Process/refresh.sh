#!/bin/sh

U="$USER"
OPF="/home/$U/TMP_DCPR.txt"

if [ ! -f "$OPF" ]; then
    echo "Creating DCPR Output file"
else
    echo "refreshing DCPR Output file"

    rm $OPF

fi
