# Project flow with DE10-Nano (Cyclone V SE)

## Prerequistes softwares
- SoC EDS Standard
- Quartus Lite (can be installed with SoCEDS)

## Folder Structure

The main folder is divided in two parts: `utils` and `projects`. The former contains utils that can be used for all the projects to build
the sd card image. Concerning the latter it contains all the projects that are also divided in many sub-folders.

```
de10-nano
├── projects
│   └── project_name
│       ├── hardware
│       ├── report
│       ├── sd_card
│       │   ├── a2
│       │   ├── ext3
│       │   └── fat32
│       └── software
│           ├── application
│           ├── bootloader
│           ├── linux
│           └── preloader
└── utils
```

### Project sub-folder structure

1. **harware**: contains all the quartus related files, that's where the hardware is descripted
2. **report** (optionnal): report files (latex, markdown, ...)
3. **sd_card**: sd_card related files with 
	- **ext3**: ext3 partition
	- **fat32**: fat32 partition
	- **a2**: bootloader folder
4. **software**: 
	- **application**: contains the application that will run on the ARM cpu
	- **bootloader**: contains the linux kernel image, the u-boot image, the u-boot scipt, the device tree, ...
	- **linux**: root filesystem

## Preamble

Go in your de10-nano folder and create an environment variables containing shortcuts for the paths. 

```
export TOP_FOLDER=`pwd`
export PROJECT=$TOP_FOLDER/projects/project_name
```

## Hardware with Quartus

The first step is to [get the DE10-Nano CD-ROM given by Terasic](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=205&No=1046&PartNo=4)
 and unzip it in the `utils` folder.This step can be skipped if the `utils` folder already contains de unzipped CD file.

```
mkdir $TOP_FOLDER/utils/board_cd && cd $TOP_FOLDER/utils/board_cd 
unzip ~/Downloads/DE10-Nano_v.1.3.8_HWrevC_SystemCD.zip
rm ~/Downloads/DE10-Nano_v.1.3.8_HWrevC_SystemCD.zip
```

Then, we need to extract the Golden Hardware Reference Design (GHRD) and store it in the `hardware` folder. This design can be taken as a 
template for the De10-Nano board. It already contains the pin definition, the time constaints, the HPS (Hard Processor System - the ARM 
cpu) definition, ...

```
cp -r $TOP_FOLDER/utils/board_cd/Demonstrations/SoC_FPGA/DE10_NANO_SoC_GHRD/* $PROJECT/hardware/
```

Any modification of the hardware can be done in quartus now. Note that quartus might warn that the ip files are not up to date. 
In that case, just let Quartus update them automaticaly. Once your modifications are done, compile the project. This will modify 
the content of `hardware/hps_isw_handoff` and create a new `hardware/output_files/DE10_NANO_SoC_GHRD.sof` file. You need to convert 
it to a .rbf.

To do so, go in **Quartus > File > Converting Programming Files**. Then chose Raw Binary File (.rbf) and add the sof file in the box.
Finally, click on generate. This file can be moved in the `sd_card/fat32` folder. It will be used by the bootloader script to program the
FPGA side of the chip.

```
cp $PROJECT/hardware/output_files/output_file.rbf $PROJECT/sd_card/fat32/soc_system.rbf
```