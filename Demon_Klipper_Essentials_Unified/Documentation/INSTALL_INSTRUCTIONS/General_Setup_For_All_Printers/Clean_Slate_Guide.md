# CLEAN SLATE INSTALL GUIDE!

How to install DKEU from a blank SD card! 

Sometimes you want (or need) to just start fresh! It's cool, sometimes we all gotta do it, but man ain't it a hassle though!

Not anymore! You got everything you'll need to do take you from a blank SD card to a working system ready for you to upload your backed up data or create new all right here on a single page!!!
You will also be at the stage where you can build & flash your MCU firmware directly.

Welcome to this quick-fire guide!

<br>

# :gift: SUPPORT YOUR FRIENDLY 3DPrintDemon! :gift:

>[!TIP]
>Please consider supporting this project…. Even if it’s for a single donation!
>
>It really does make a difference & any amount you send is greatly appreciated!

This macro pack is the cumulation of 3 years of work by one person alone, there have been countless late nights, missed family time, bottomless cups of coffee, as well as a boat load of effort & dedication. There’s been endless weeks of writing code & then probably that amount of time again at least thoroughly testing the files so that you can rest assured that they work & these macros will NOT damage or harm your printer in any way! Not counting any improper setup of course…

Plus I provide the DEMON DISCORD to help anyone with getting DKEU working on their system!

All of this is given away to the community for FREE.

However I would like to kindly ask that if you gain any sort of benefit, joy, improved quality of life using your printer, or maybe if you use these macros as part of your side or regular business, for example in your print farm or to help make your craft fair items please consider making a pledge on the 3DPrintDemon Patreon page for however much you feel these macros are worth to your printing life & your business income! You can choose the amount of your donation & how long you are an active donating supporter!

You can stay a supporter on the 3DPrintDemon Patreon sending donations of your choosing for as long as you like. Maybe it’s for just a month or two for single private users that would like to show your gratitude, or maybe you could consider ongoing support if you’re a business owner & make regular use of my work to aid your business.

Active supporters have a special channel on the Demon Discord server & are provided with a higher level of support over non supporting members. Just make your discord user name known & you’ll be granted “supporter” privileges.

:red_circle: [JOIN THE 3DPRINTDEMON PATREON](https://patreon.com/3dprintdemon) as an active donating member & show your support for my work!

Your donations are used to feed my printers & give them the latest fancy pants new parts so I can continue adding new features, fixing bugs & providing time for helping you all to get the macros running & fixing issues you might experience!

Be sure to use the website not the IOS app, it's cheaper!

<br>
<br>


## :warning: MAKE A BACKUP!

Make a backup of your current system now! Be sure you at least download your current `/config` folder BEFORE YOU DO ANYTHING ELSE!! You want have a set of UNTOUCHED files to refer back to if needed! Once a backup is saved on your computer you can use it to drop files back into this fresh install once you finish the guide! Also be sure to use a new SD card or SSD - this will leave your old system safe & completely untouched!

<br>

## LETS GET STARTED!

These instructions are based on a user flashing Trixie on a Raspberry Pi SBC!

## :red_circle: STEP 1 - SYSTEM FLASHING

We need to choose & flash your new system to your SBC (Single Board Computer) after specifying user details & wifi details.

<br>

1. Download & open Raspberry Pi Imager
2. select your RPi
3. Scroll down to Raspberry Pi OS (other)
4. select Raspberry Pi OS Lite (64-bit)
5. Enter your chosen names & wifi creds
6. Flash image
7. Insert media to Pi & boot!

<br>

>[!NOTE]
>For users with other systems please flash your chosen image as your system dictates. You can select either `Other specific-purpose OS` or `Use custom` at the bottom of the `OS` list. If you don't have a Raspberry Pi you can use Balena Etcher to flash your system too.

<br>

## :red_circle: STEP 2 - UPDATES & SETUP

Here we need to finish login to your SBC & do some setup, check for & install updates & install git & serial.

<br>

1. Check your router or your KlipperScreen Network page to find your printer's IP address if you don't know it. 

2. Log into your printer via SSH

<br>

>[!IMPORTANT]
>When trying to log in for the first time with this newly flashed system you will probably get a "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!" message & any good SSH client will block the connection as your `Host Key` will have changed!
>
>You will need to delete the old `Host Key` from your computer's `known_hosts` file! The message in your terminal should tell you where that file is located on your computer. Once the old `Host Key` is deleted & the `known_hosts` file is saved the system will allow the connection on your approval, try to login again.

<br>

Once logged in...

<br>

3. Raspberry Pi users send...

```
sudo raspi-config
```

- Interface options, enable spi & i2c
- Advanced options, expand file system
- Exit & reboot now

<br>

4. Now log in again & run each one of these commands in the order shown below working from the top downwards.

<br>

>[!TIP]
>Use the double box icon on the right side of the text to instantly copy each command ready for you to paste into your SSH terminal!



```
sudo apt update && sudo apt upgrade -y
```
```
sudo apt autoremove -y
```
```
sudo apt install git -y
```
```
sudo apt install python3-serial
```
```
sudo reboot now
```
<br>

5. OPTIONAL! Once restarted SSH back in & send...

>[!NOTE]
>The below commands are optional! One disables the rainbow splash screen & the other drives GPIO pin high as an output for use with a printer power control device that requires a "keep-alive" signal from the host like the BTT Power Relay.

<br>

```
sudo nano /boot/firmware/config.txt
```

6. Move the cursor to the bottom of the file & at the very end under the `[all]` section header add...

<br>

>[!CAUTION]
>Be sure NOT to change anything else in the file unless you know what you're doing, & do NOT mess up the formatting of the file!

```
# Disable Rainbow Boot Splash Screen
disable_splash=1

# GPIO pin on boot, choose a GPIO pin to control power device at first boot
gpio=16=op,dh
```

Once you have made sure all is correct press `ctrl+X` then press `return` to save the file & exit.

<br>

## :red_circle: STEP 3 - INSTALL KATAPULT

1. Clone the Katapult repo by using...

```
git clone https://github.com/Arksine/katapult
```

Repo link: https://github.com/Arksine/katapult

<br>

## :red_circle: STEP 4 - INSTALL KIAUH

1. Clone the Kiauh repo by using...

```
cd ~ && git clone https://github.com/th33xitus/kiauh.git
```

2. Run Kiauh with this command…

```
./kiauh/kiauh.sh
```

Repo link: https://github.com/th33xitus/kiauh

<br>

3. Main menu - Once at the Main menu choose...

- Option 1. [Install]

Complete one by one until all are installed

- Option 1 [Klipper]
- Option 2 [Moonraker]
- Option 3 [Mainsail] - set 1 instances & default port (80), Install recommended config .cfg file!
- Option 7 [KlipperScreen]
- Option 8 [Crowsnest]

<br>

4. Back to the Main menu

- Option 4. - Extra Dependencies
- Option 5. [Input Shaper] - Do you want to install the required packages? YES

<br>

5. Back to main menu again

- Option E. [Extensions]
- Option 1. G-Code Shell Command
- Option 1. Install - Create an example shell command? NO!

<br>

6. When finished exit Kiauh &...

```
sudo reboot now
```

<br>

## :red_circle: STEP 5 - INSTALL EDDY NG - OPTIONAL!!

If you want to use Eddy NG software heres how to install it. If not SKIP this section!

<br>

1. Clone the Eddy NG repo by using...

```
cd ~
git clone https://github.com/vvuk/eddy-ng
```

2. Install the Eddy NG software into Klipper - This will make the Update Manager system read Klipper as "Dirty". This is normal & expected!
```
cd ~/eddy-ng
./install.sh
```

Repo Link: https://github.com/vvuk/eddy-ng?tab=readme-ov-file

<br>

>[!TIP]
>You will need to build & flash new MCU firmware once Eddy NG is installed! You can do this after you're finished here.

<br>

## :red_circle: STEP 6 - SETTING UP YOUR CANBUS NETWORK

1. Follow the instructions on this page: https://canbus.esoterical.online/Getting_Started.html

<br>

>[!WARNING]
>The commands below are copied directly from the above link for your convenience without the extra ones checking it actually worked or not! Follow the link above for the FULL guide!

>[!TIP]
>Use the double box icon on the right side of the text to instantly copy each command ready for you to paste into your SSH terminal!

<br>

Run each one of these commands in the order shown below working from the top downwards.


```
sudo systemctl enable systemd-networkd
```
```
sudo systemctl start systemd-networkd
```
```
sudo systemctl disable systemd-networkd-wait-online.service
```
```
echo -e 'SUBSYSTEM=="net", ACTION=="change|add", KERNEL=="can*"  ATTR{tx_queue_len}="128"' | sudo tee /etc/udev/rules.d/10-can.rules > /dev/null
```
```
echo -e "[Match]\nName=can*\n\n[CAN]\nBitRate=1M\n\n[Link]\nRequiredForOnline=no" | sudo tee /etc/systemd/network/25-can.network > /dev/null

```
```
sudo reboot now
```

<br>

## :red_circle: STEP 7 - ADDING HOST GPIO PIN CONTROL

This allows us to make use of the SBC's GPIO pins so we can add sensors & control things outside of your MCUs.

<br>

1. Run this to start...

```
cd ~/klipper/
sudo cp ./scripts/klipper-mcu.service /etc/systemd/system/
sudo systemctl enable klipper-mcu.service
```

2. Open the Klipper MCU firmware configuration menu

```
cd ~/klipper/
make menuconfig
```

3. Select 'Linux Process" from the Micro-controller Architecture list. Exit & save the settings.

4. Send these commands to create the Linux process on your SBC

```
sudo service klipper stop
make flash
```
```
sudo service klipper start
```

Full instructions: https://github.com/Klipper3d/klipper/blob/master/docs/RPi_microcontroller.md

<br>

## :red_circle: STEP 8 - INSTALL DKEU

Finally! Phew glad you got here!

1. To start the Install send...

```
cd ~/ && wget https://raw.githubusercontent.com/3DPrintDemon/Demon_Klipper_Essentials_Unified/refs/heads/main/Other_Files/Demon_Install_Script/Demon_Klipper_Essentials_Installer.sh && bash Demon_Klipper_Essentials_Installer.sh
```

2. BE SURE TO FOLLOW THE [FULL INSTALL INSTRUCTIONS HERE!](https://github.com/3DPrintDemon/Demon_Klipper_Essentials_Unified/blob/main/Documentation/INSTALL_INSTRUCTIONS/General_Setup_For_All_Printers/INSTALL_INSTRUCTIONS.md)

<br>

****************************************************************************************************************************

<br>

# :gift: SUPPORT 3DPrintDemon! :gift:

You can stay a supporter on the 3DPrintDemon Patreon sending donations of your choosing for as long as you like. Maybe it’s for just a month or two for single private users that would like to show your gratitude, or maybe you could consider ongoing support if you’re a business owner & make regular use of my work to aid your business.

Active supporters have a special channel on the Demon Discord server & are provided with a higher level of support over non supporting members. Just make your discord user name known & you’ll be granted “supporter” privileges.

:red_circle: [JOIN THE 3DPRINTDEMON PATREON](https://patreon.com/3dprintdemon) as an active donating member & show your support for my work!

<br>
<br>
<br>
