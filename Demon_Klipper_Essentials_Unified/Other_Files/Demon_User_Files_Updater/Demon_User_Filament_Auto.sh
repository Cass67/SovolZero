#!/bin/bash



U="$USER"
DIR="/home/$U/printer_data/config/Demon_User_Files"
SDIR="/home/$U/printer_data/config/Demon_Klipper_Essentials_Unified/Other_Files/DEMON_User_Files_SOURCE"
DUSFV="demon_user_settings_filament_variables_v*.cfg"

# demon_user_settings_v*.cfg
# demon_user_settings_cleaner_variables_v*.cfg
# demon_user_settings_filament_variables_v*.cfg
# demon_custom_expansion_v*.cfg

# Check directory not exist
if [ ! -d "$DIR" ]; then
    echo "$DIR does not exist, please run the main installer again!"
    exit
     
else
    echo "Directory $DIR exists." 
     
    if [ "$(ls -A $DIR)" ]; then
         echo "Directory $DIR is not empty"
          
         if [ -f $DIR/$DUSFV ]; then
             echo "$DUSFV already exists, exiting!"
             exit

         else 
             echo "No previous version of $DUSFV found, auto extracting from local source $SDIR!"
             cp $SDIR/$DUSFV $DIR
             wait
             sleep 6
             echo "Requesting Klipper to RESTART"
             echo "RESTART" >~/printer_data/comms/klippy.serial
         fi
        
 
    else
        echo "Directory $DIR is empty, please run the main installer again!"
        exit
    fi  
fi

echo "Operations complete."
