# [Windows 10] Project flow with DE10-Nano (Cyclone V SE) 

## Prerequistes softwares
- balenaEtcher - used to flash image files (.iso) to sdcard
- PuTTY - tool to connect using SSH and Serial connections
- Quartus Prime Lite 16.0 (note that the version is important to work well with Terasic preconfigured projects) - used to describe FPGA side hardware logic

## Installing linux

### Step 1. Download the linux image 

* The linux console image is available [here](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4)
* Unzip it

### Step 2. Flash the linux image on the SD card

* Place the SD card in your SD card reader
* Open balenaEtcher, select the iso file and the sd card
* Flash the sd card

### Step 3. Connecting to the board to the computer

* Place the sd card in you de10 nano sd card reader
* Set the boot switches (from 1 to 6) to ON ON ON ON ON X
* Plug the J4 USB port to your computer
* Power the de10 nano board

### Step 4. Getting the serial USB drivers

* Follow the steps described on this [website](https://www.usb-drivers.org/ft232r-usb-uart-driver.html).

### Step 5. Verify the SD card content

* Open your device manager and look for the DE10 nano in the ports, note the COM number
* Open PuTTY and select Serial, use COMx (where x is the number you just noted) and set the baud rate (speed) to 115200
* Click open, a new window should pops. Click on it and press enter if nothing appears
* You are now asked to log in to anström, simply enter "root"
* You are now logged

## Creating your own hardware description for the FPGA side

### Step 1. Get the GHRD project

* Download the CD-ROM corresponding to your revision of the board on the [Terasic website](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4)
* Unzip it and get x_SystemCD/Demonstrations/SoC_FPGA/DE10_NANO_SoC_GHRD. This folder contains all the configurations for the board (RAM timings, GPIOs, ... are set for you).
* Open this project with Quartus Prime Lite 16.0 and modify it as you wish.

### Step 2. Save the project

* Once all your modifications are done, you have to compile the whole project (and correct your errors if any)
* The compilation process will output a .sof file in the project sub-folder "output_files"

### Step 3. Compress the sof file

* Open Quartus Prime lite 16.0
* Open File > Convert Programming File
* In "Programming file type" select Raw Binary File (.rbf)
* Modify the file name to soc_system.rbf, I advise to put it in the same folder as your .sof file to make it easier to find it afterward
* In the bottom-most field "Input files to convert", click on SOF Data and then "Add File..." on the right side of the field
* Browse your files and select your .sof file
* Click generate

### Step 4. Configuring the FPGA

* The FPGA is configured by the bootloader (u-boot). It simply sets the FPGA up while booting. Thus, we need to put the .rbf file in the sd card
* Place the sd card in your computer
* Open the FAT partition (do not format the others if windows suggest it!!!). If the partition doesn't appear use "repair device" and it should appear. Once again, do not format if asked
* Place your .rbf file in the fat partition
* Place it back in your board and reboot it
* Your hardware is now ready on the FPGA

## Creating your own software on the ARM side

### W.I.P
