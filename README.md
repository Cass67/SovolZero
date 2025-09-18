# This repo is my current live Zero config i use... The readme explains how i get to the latest version of Kalico.. 
# 
# Guide to Flash Kalico Firmware on Sovol Zero 

This guide assumes you have completed the initial setup from [Kalico on the Sovol Zero wiki](https://github.com/vvuk/printer-configs/wiki/Kalico-on-the-Sovol-Zero) and have Kalico installed and working.

## Prerequisites
- Ensure you are on the `sovol-zero` branch of your Kalico repository
- Confirm your remotes are set up correctly (origin and upstream)

## Update Kalico to Latest Version

### NOTE .. the merging of Kalico latest could break your working system, take care. 

Navigate to your Kalico directory and update to the latest firmware.

```bash
cd ~/klipper

# Check current branch (should be sovol-zero)
git branch

# Switch to sovol-zero if necessary
git checkout sovol-zero

# Check remotes
git remote -v

# If upstream is not present, add it
git remote add upstream https://github.com/KalicoCrew/kalico.git

# Fetch upstream changes
git fetch upstream

# Merge upstream main into current branch
git merge upstream/main
```

## Prepare System

Stop Klipper and reboot for a fresh start.

```bash
# Stop Klipper
sudo systemctl stop klipper
sudo systemctl disable klipper

# Reboot
sudo reboot
```

After reboot, navigate back to Klipper and query CAN bus.

```bash
cd ~/klipper

# Query CAN bus
~/klippy-env/bin/python3 ~/klipper/scripts/canbus_query.py can0
```

Confirm the CAN bus UUIDs in your `printer.cfg`:
- Main MCU: `e5093890c14e`
- Extruder MCU: `62b63a8995c1`

## Flash Mainboard

Compile and flash the mainboard firmware.

```bash
# Configure and build
make KCONFIG_CONFIG=main.mcu menuconfig
make KCONFIG_CONFIG=main.mcu clean
make KCONFIG_CONFIG=main.mcu -j4

# Attempt CAN flash (may fail)
~/klippy-env/bin/python3 lib/canboot/flash_can.py -i can0 -u e5093890c14e -f out/klipper.bin

# If CAN flash fails, use USB
ls /dev/serial/by-id/
# Replace with your mainboard's USB ID
make KCONFIG_CONFIG=main.mcu FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h750xx_1C0028000451333138373234-if00 flash
```

## Flash Toolboard

Compile and flash the toolboard firmware.

```bash
# Configure and build
make KCONFIG_CONFIG=toolboard.mcu menuconfig
make KCONFIG_CONFIG=toolboard.mcu clean
make KCONFIG_CONFIG=toolboard.mcu -j4

# Query CAN bus again to find Katapult UUID
~/klippy-env/bin/python3 ~/klipper/scripts/canbus_query.py can0
# Example output: Found canbus_uuid=61755fe321ac for Katapult

# Attempt CAN flash
~/klippy-env/bin/python3 lib/canboot/flash_can.py -i can0 -u 61755fe321ac -f out/klipper.bin

# If CAN flash fails, use USB (ensure it's not the mainboard's ID)
ls /dev/serial/by-id/
# Replace with your toolboard's USB ID
make KCONFIG_CONFIG=toolboard.mcu FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32h750xx_<toolboard_id>-if00 flash
```

## Restore System

Restart Klipper.

```bash
# Start Klipper
sudo systemctl start klipper
sudo systemctl enable klipper
```

You are now done! Your Sovol Zero should be running the latest Kalico firmware.

At some point the hope is that the Zero will be fully supported by both Kalico and Klipper and we can dispense with the initial part of this ... 

