#!/bin/sh

# 3DPrintDemon Klipper Essentials Unified DCPR_RAND Script v1.0.0
# https://github.com/3DPrintDemon/Demon_Klipper_Essentials_Unified

# Define
U="$USER"
HDIR="/home/$U"
KOPF="/home/$U/TMP_DCPR.txt"
DUF="/home/$U/printer_data/config/Demon_User_Files/demon_user_settings_cleaner_variables_v*.cfg"
DIR="/home/$U/printer_data/config/Demon_User_Files"



######## Set & find bash variables to search output file for klipper variables ########

var0=$(echo | grep -w $KOPF -e 'variable_random_clean_x:')
var1=$(echo | grep -w $KOPF -e 'variable_random_clean_y:')
var2=$(echo | grep -w $KOPF -e 'variable_start_x:')
var3=$(echo | grep -w $KOPF -e 'variable_start_y:')
var4=$(echo | grep -w $KOPF -e 'variable_start_z:')
var5=$(echo | grep -w $KOPF -e 'variable_clean_min_x:')
var6=$(echo | grep -w $KOPF -e 'variable_clean_max_x:')
var7=$(echo | grep -w $KOPF -e 'variable_clean_min_y:')
var8=$(echo | grep -w $KOPF -e 'variable_clean_max_y:')



######## Trim the found variables down to values only - use for export to target ########

trim_var0="${var0#*:}"
trim_var0="${var0#*[[:space:]]}"

trim_var1="${var1#*:}"
trim_var1="${var1#*[[:space:]]}"

trim_var2="${var2#*:}"
trim_var2="${var2#*[[:space:]]}"

trim_var3="${var3#*:}"
trim_var3="${var3#*[[:space:]]}"

trim_var4="${var4#*:}"
trim_var4="${var4#*[[:space:]]}"

trim_var5="${var5#*:}"
trim_var5="${var5#*[[:space:]]}"

trim_var6="${var6#*:}"
trim_var6="${var6#*[[:space:]]}"

trim_var7="${var7#*:}"
trim_var7="${var7#*[[:space:]]}"

trim_var8="${var8#*:}"
trim_var8="${var8#*[[:space:]]}"

echo Saved Variables:
echo $var0
echo $var1
echo $var2
echo $var3 
echo $var4
echo $var5
echo $var6
echo $var7
echo $var8



######## Set bash variables to search target file ########

var0target=$(echo | grep -w $DUF -e 'variable_random_clean_x:')
var1target=$(echo | grep -w $DUF -e 'variable_random_clean_y:')
var2target=$(echo | grep -w $DUF -e 'variable_start_x:')
var3target=$(echo | grep -w $DUF -e 'variable_start_y:')
var4target=$(echo | grep -w $DUF -e 'variable_start_z:')
var5target=$(echo | grep -w $DUF -e 'variable_clean_min_x:')
var6target=$(echo | grep -w $DUF -e 'variable_clean_max_x:')
var7target=$(echo | grep -w $DUF -e 'variable_clean_min_y:')
var8target=$(echo | grep -w $DUF -e 'variable_clean_max_y:')


######## SET END/PARK POS LINES #########

endpos0=$(echo | grep -w $DUF -e 'variable_end_position_x:')
endpos1=$(echo | grep -w $DUF -e 'variable_end_position_y:')
endpos2=$(echo | grep -w $DUF -e 'variable_park_x:')
endpos3=$(echo | grep -w $DUF -e 'variable_park_y:')




######## OUTPUT LINE BUILDING #########

trim_start0="${var0target%%:*}"
trim_end0="${var0target#*[[:space:]][[:space:]]}"
output0=$(echo "$trim_start0: $trim_var0  $trim_end0")

trim_start1="${var1target%%:*}"
trim_end1="${var1target#*[[:space:]][[:space:]]}"
output1=$(echo "$trim_start1: $trim_var1  $trim_end1")

trim_start2="${var2target%%:*}"
trim_end2="${var2target#*[[:space:]][[:space:]]}"
output2=$(echo "$trim_start2: $trim_var2  $trim_end2")

trim_start3="${var3target%%:*}"
trim_end3="${var3target#*[[:space:]][[:space:]]}"
output3=$(echo "$trim_start3: $trim_var3  $trim_end3")

trim_start4="${var4target%%:*}"
trim_end4="${var4target#*[[:space:]][[:space:]]}"
output4=$(echo "$trim_start4: $trim_var4  $trim_end4")

trim_start5="${var5target%%:*}"
trim_end5="${var5target#*[[:space:]][[:space:]]}"
output5=$(echo "$trim_start5: $trim_var5  $trim_end5")

trim_start6="${var6target%%:*}"
trim_end6="${var6target#*[[:space:]][[:space:]]}"
output6=$(echo "$trim_start6: $trim_var6  $trim_end6")

trim_start7="${var7target%%:*}"
trim_end7="${var7target#*[[:space:]][[:space:]]}"
output7=$(echo "$trim_start7: $trim_var7  $trim_end7")

trim_start8="${var8target%%:*}"
trim_end8="${var8target#*[[:space:]][[:space:]]}"
output8=$(echo "$trim_start8: $trim_var8  $trim_end8")


######## END/PARK POS LINE BUILDING #########

trim_endpos0="${endpos0%%:*}"
trim_endpostail0="${endpos0#*[[:space:]][[:space:]]}"
output9=$(echo "$trim_endpos0: $trim_var2  $trim_endpostail0")

trim_endpos1="${endpos1%%:*}"
trim_endpostail1="${endpos1#*[[:space:]][[:space:]]}"
output10=$(echo "$trim_endpos1: $trim_var3  $trim_endpostail1")

trim_endpos2="${endpos2%%:*}"
trim_endpostail2="${endpos2#*[[:space:]][[:space:]]}"
output11=$(echo "$trim_endpos2: $trim_var2  $trim_endpostail2")

trim_endpos3="${endpos3%%:*}"
trim_endpostail3="${endpos3#*[[:space:]][[:space:]]}"
output12=$(echo "$trim_endpos3: $trim_var3  $trim_endpostail3")



######## GET FILE NAME/VERSION & TRIM #########

FILENAME=$(echo | find $DIR -name 'demon_user_settings_cleaner_variables_v*.cfg')
TRIMNAME="${FILENAME##*/}"



######## GET TARGET FILE LINES #########

linetar0=$(echo | grep -nw $DUF -e 'variable_random_clean_x:')
trim_line0="${linetar0%%:*}"

linetar1=$(echo | grep -nw $DUF -e 'variable_random_clean_y:')
trim_line1="${linetar1%%:*}"

linetar2=$(echo | grep -nw $DUF -e 'variable_start_x:')
trim_line2="${linetar2%%:*}"

linetar3=$(echo | grep -nw $DUF -e 'variable_start_y:')
trim_line3="${linetar3%%:*}"

linetar4=$(echo | grep -nw $DUF -e 'variable_start_z:')
trim_line4="${linetar4%%:*}"

linetar5=$(echo | grep -nw $DUF -e 'variable_clean_min_x:')
trim_line5="${linetar5%%:*}"

linetar6=$(echo | grep -nw $DUF -e 'variable_clean_max_x:')
trim_line6="${linetar6%%:*}"

linetar7=$(echo | grep -nw $DUF -e 'variable_clean_min_y:')
trim_line7="${linetar7%%:*}"

linetar8=$(echo | grep -nw $DUF -e 'variable_clean_max_y:')
trim_line8="${linetar8%%:*}"



######## END/PARK POS TARGET LINES #########

linetar9=$(echo | grep -nw $DUF -e 'variable_end_position_x:')
trim_line9="${linetar9%%:*}"

linetar10=$(echo | grep -nw $DUF -e 'variable_end_position_y:')
trim_line10="${linetar10%%:*}"

linetar11=$(echo | grep -nw $DUF -e 'variable_park_x:')
trim_line11="${linetar11%%:*}"

linetar12=$(echo | grep -nw $DUF -e 'variable_park_y:')
trim_line12="${linetar12%%:*}"



######## MAKE A MESS OF FILES #########

cd $HDIR
wait
awk -v where="$trim_line0" -v what="$output0" 'FNR==where {print what; next} 1' $DUF > $HDIR/tmp_file0.cfg
wait
awk -v where="$trim_line1" -v what="$output1" 'FNR==where {print what; next} 1' $HDIR/tmp_file0.cfg > $HDIR/tmp_file1.cfg
wait
rm -f $HDIR/tmp_file0.cfg
awk -v where="$trim_line2" -v what="$output2" 'FNR==where {print what; next} 1' $HDIR/tmp_file1.cfg > $HDIR/tmp_file2.cfg
wait
rm -f $HDIR/tmp_file1.cfg
awk -v where="$trim_line3" -v what="$output3" 'FNR==where {print what; next} 1' $HDIR/tmp_file2.cfg > $HDIR/tmp_file3.cfg
wait
rm -f $HDIR/tmp_file2.cfg
awk -v where="$trim_line4" -v what="$output4" 'FNR==where {print what; next} 1' $HDIR/tmp_file3.cfg > $HDIR/tmp_file4.cfg
wait
rm -f $HDIR/tmp_file3.cfg
awk -v where="$trim_line5" -v what="$output5" 'FNR==where {print what; next} 1' $HDIR/tmp_file4.cfg > $HDIR/tmp_file5.cfg
wait
rm -f $HDIR/tmp_file4.cfg
awk -v where="$trim_line6" -v what="$output6" 'FNR==where {print what; next} 1' $HDIR/tmp_file5.cfg > $HDIR/tmp_file6.cfg
wait
rm -f $HDIR/tmp_file5.cfg
awk -v where="$trim_line7" -v what="$output7" 'FNR==where {print what; next} 1' $HDIR/tmp_file6.cfg > $HDIR/tmp_file7.cfg
wait
rm -f $HDIR/tmp_file6.cfg
awk -v where="$trim_line8" -v what="$output8" 'FNR==where {print what; next} 1' $HDIR/tmp_file7.cfg > $HDIR/tmp_file8.cfg
wait



######## ADD END/PARK POS #########

rm -f $HDIR/tmp_file7.cfg
awk -v where="$trim_line9" -v what="$output9" 'FNR==where {print what; next} 1' $HDIR/tmp_file8.cfg > $HDIR/tmp_file9.cfg
wait
rm -f $HDIR/tmp_file8.cfg
awk -v where="$trim_line10" -v what="$output10" 'FNR==where {print what; next} 1' $HDIR/tmp_file9.cfg > $HDIR/tmp_file10.cfg
wait
rm -f $HDIR/tmp_file9.cfg
awk -v where="$trim_line11" -v what="$output11" 'FNR==where {print what; next} 1' $HDIR/tmp_file10.cfg > $HDIR/tmp_file11.cfg
wait
rm -f $HDIR/tmp_file10.cfg
awk -v where="$trim_line12" -v what="$output12" 'FNR==where {print what; next} 1' $HDIR/tmp_file11.cfg > $HDIR/tmp_file12.cfg
wait

rm -f $HDIR/tmp_file11.cfg
rm -f $KOPF

mv -f tmp_file12.cfg $TRIMNAME
mv -f $TRIMNAME $DIR
wait 

sleep 3
echo "RESPOND TYPE=command MSG="action:prompt_end"" >~/printer_data/comms/klippy.serial
sleep 1
echo "Requesting Klipper to RESTART"
sleep 3

echo "RESTART" >~/printer_data/comms/klippy.serial
    
echo "Operations complete."







