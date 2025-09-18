# Guide to flash Kalico firmware on Sovol Zero with Katapult toolboard
# assumes you completed - https://github.com/vvuk/printer-configs/wiki/Kalico-on-the-Sovol-Zero
# and have kalico installed and working

# The following keep you up to date with latest kalico firmware.

# git stuff

cd ~/klipper

# check branch, make sure we are on sovol-zero branch
git branch
#   main
# * sovol-zero

# if * is next to main, we need to switch branch
git checkout sovol-zero

# if * is next to sovol-zero, we are good to go

# check remotes
git remote -v

# origin	git@github.com:Cass67/sovol_zero_kalico.git (fetch)
# origin	git@github.com:Cass67/sovol_zero_kalico.git (push)
# upstream	https://github.com/KalicoCrew/kalico.git (fetch)
# upstream	https://github.com/KalicoCrew/kalico.git (push)

# if not upstream in place

# add upstream
git remote add upstream https://github.com/KalicoCrew/kalico.git

# fetch upstream changes
git fetch upstream

# merge upstream main into current branch, in this case sovol-zero
git merge upstream/main

# we should be up to date now with latest kalico

# lets go .....

# prepare system

# stop klipper
sudo systemctl stop klipper
sudo systemctl disable klipper

# reboot, start fresh
sudo reboot

# after reboot

# cd klipper
cd ~/klipper

# lets see what we have

# canbus query
~/klippy-env/bin/python3 ~/klipper/scripts/canbus_query.py can0

# check printer.cfg for canbus_uuids to confirm

# [mcu]
# canbus_uuid: e5093890c14e

# [mcu extruder_mcu]
# canbus_uuid: 62b63a8995c1

# compile and flash

# mainboard

make KCONFIG_CONFIG=main.mcu menuconfig
make KCONFIG_CONFIG=main.mcu clean
make KCONFIG_CONFIG=main.mcu -j4

# main.mcu
~/klippy-env/bin/python3 lib/canboot/flash_can.py -i can0 -u e5093890c14e -f out/klipper.bin

# fails 100% of the time for me, so usb it is .....
ls /dev/serial/by-id/

# use the correct id from mainboard
make KCONFIG_CONFIG=main.mcu FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h750xx_1C0028000451333138373234-if00 flash

# toolboard

make KCONFIG_CONFIG=toolboard.mcu menuconfig
make KCONFIG_CONFIG=toolboard.mcu clean
make KCONFIG_CONFIG=toolboard.mcu -j4

# canbus query
~/klippy-env/bin/python3 ~/klipper/scripts/canbus_query.py can0

# finds, in my case
# [can0] Found canbus_uuid=e5093890c14e, Application: Kalico, Unassigned
# [can0] Found canbus_uuid=61755fe321ac, Application: Katapult, Unassigned

# We want 61755fe321ac as its katapult id

# toolboard.mcu, this likely works
~/klippy-env/bin/python3 lib/canboot/flash_can.py -i can0 -u 61755fe321ac -f out/klipper.bin

# if fails
ls /dev/serial/by-id/

# use the correct id from not from mainboard
make KCONFIG_CONFIG=toolboard.mcu FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h750xx_<whatever_id_not_from_mainboard>-if00 flash

# restore system

# start klipper
sudo systemctl start klipper
sudo systemctl enable klipper

# we are done
