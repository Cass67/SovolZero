#!/bin/sh

# 3DPrintDemon Klipper Essentials Unified Klipper Version Tracker Script v1.0.4
# https://github.com/3DPrintDemon/Demon_Klipper_Essentials_Unified

# Define
U="$USER"
HDIR="/home/$U"
KLDIR="/home/$U/printer_data/logs/klippy.log"
KLIP="klipper"
LKVER="12"
KVER="13"
KNUM="623"

######## KLIPPER VERIONS TRACKER ########

var0=$(echo | tac $KLDIR | grep -m1 "Tracked URL:")
var1=$(echo | tac $KLDIR | grep -m1 "Git version:")

echo $var0
echo $var1

trim_var0="${var0##*/}"
trim_var00="${trim_var0%.*}"

trim_var1="${var1#*.}"
trim_var2="${trim_var1%.*}"

trim_var3="${var1#*-}"
trim_var4="${trim_var3%%-*}"


# echo Source value only = $trim_var0
# echo Source value only = $trim_var2
# echo Source value only = $trim_var4

if [ "$trim_var0" = "$KLIP" ] || [ "$trim_var0" = "$KLIP.git" ]; then
    echo Firmware Type: "$trim_var0"

    if [ "$trim_var0" = "$KLIP.git" ]; then
        echo Non-standard Tracked Klipper URL detected
    fi  

    echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=is_klipper VALUE=True" >~/printer_data/comms/klippy.serial
    echo Requesting Klipper set variable is klipper to True  

    if [ "$trim_var2" != "$KVER" ] && [ "$trim_var2" != "$LKVER" ] ; then
        echo Non-standard versioning detected - Legacy Mode: ON
        echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=legacy_klipper VALUE=True" >~/printer_data/comms/klippy.serial
        echo Requesting Klipper set variable legacy Klipper to True
        
    else
        if [ "$trim_var2" -eq "$KVER" ]; then
        echo Klipper version: Current
    
            if [ "$trim_var4" -lt "$KNUM" ]; then
                echo Legacy Mode: ON
                echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=legacy_klipper VALUE=True" >~/printer_data/comms/klippy.serial
                echo Requesting Klipper set variable legacy Klipper to True
        
            elif [ "$trim_var4" -eq "$KNUM" ] || [ "$trim_var4" -gt "$KNUM" ]; then
               echo Legacy Mode: OFF
               echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=legacy_klipper VALUE=False" >~/printer_data/comms/klippy.serial
               echo Requesting Klipper set variable legacy Klipper to False
            fi

        elif [ "$trim_var2" -lt "$KVER" ]; then
            echo Legacy version of Klipper detected!
            echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=legacy_klipper VALUE=True" >~/printer_data/comms/klippy.serial
            echo Requesting Klipper set variable legacy Klipper to True

        else
        echo Klipper version is higher - someone needs to update this script!
        fi
    fi

else
    echo Firmware type: "$trim_var0"
    echo "SET_GCODE_VARIABLE MACRO=_CORE_VARS VARIABLE=is_klipper VALUE=False" >~/printer_data/comms/klippy.serial
    echo Requesting Klipper set variable is klipper to False
fi









