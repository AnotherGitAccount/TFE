# How to compile hardware

1. Download DE10-Nano CD-ROM (rev. C Hardware) on [Terasic website](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4)
2. Open the zip file and copy the folder `Demonstrations/SoC_FPGA/DE10_NANO_SoC_GHRD` anywhere on your system
3. Open the DE10_NANO_SoC_GHRD you just installed and drop all the files contained here in this folder (replace all)
4. Open quartus (quartus 16.0 is advised) and compile

# How to install hardware

1. Convert the .sof file present in the folder `output_files` to a .rbf file. For this, use quartus > file > convert programming files.
2. Copy the .rbf file on the FAT partition of the memory card of the DE10-NANO.