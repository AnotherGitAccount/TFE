# Master thesis - Polet Quentin

## How to setup the DE10 Nano Board

1. Download [DE10-Nano Linux SD Card Image](https://software.intel.com/content/www/us/en/develop/topics/fpga-academic/)
2. Flash the image on the sd card of the DE10 nano board
3. Follow the steps of the README file in the hardware folder of this repo

## How to setup the programming tools

1. Download the content of the `software/beta_utils`
2. Put it on the FAT partition of the sd card
3. Plug your card and plug the board
4. On linux, copy the files from `/media` to `/home/Documents`
5. Follow the steps in the readme of `software/beta_utils` to intall and use

NOTE: steps 2 -> 4 can be done using ssh / scp