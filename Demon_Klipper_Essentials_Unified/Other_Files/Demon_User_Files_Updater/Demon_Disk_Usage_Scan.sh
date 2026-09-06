#!/bin/bash

# 3DPrintDemon Demon Disk Usage Scan v1.0.1

DDIR="/home/$USER/printer_data/config/Demon_Klipper_Essentials_Unified"
CDIR="/home/$USER/printer_data/config"
LDIR="/home/$USER/printer_data/logs"
GCDIR="/home/$USER/printer_data/gcodes"
TLDIR="/home/$USER/printer_data/timelapse"




echo "Starting DISK USAGE SCAN!"

sleep 0.5
echo "SCANNING DISK....."

sleep 2

df -h / --output=source,size,used,avail,pcent

sleep 2

echo "Checking Disk Usage for $CDIR"
echo "Excluding $DDIR from scan"

sleep 2

du -h --max-depth=1 --exclude=$CDIR/.git --exclude=$DDIR $CDIR


sleep 0.5 

echo "Checking Disk Usage for $LDIR"

sleep 2

du -h --max-depth=1 $LDIR

sleep 0.5

echo "Checking Disk Usage for $GCDIR"

sleep 2

du -h --max-depth=0 $GCDIR

sleep 0.5

echo "Checking Disk Usage for $TLDIR"

sleep 2

if [ ! -d "$TLDIR" ]; then
    echo "Directory $TLDIR does not exist."

else
    du -h --max-depth=1 $TLDIR
fi

sleep 0.5

echo "DISK USAGE SCAN COMPLETE!"

sleep 0.5

echo "Please locate any high disk usage directories with purgable data to free up some space.
DO NOT DELETE IMPORTANT STUFF!!"
echo "...You might break the printer!"
