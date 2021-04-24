# Beta Assembler

This tool allows you to easily write programs for the beta machine. 

## Installation

1. Download Romain Mormont's cli-beta-assembler tool from [this repo](https://github.com/waliens/cli-beta-assembler)
2. Install it with `python3 -m pip install -e .` in the folder cli-beta-assembler
3. Download the `beta_assembler.py`file present in this repo

## Usage

First you need to write an assembler file, examples are given in the folder asm of this repo. As can be seen, these
files include `beta.uasm`. Please use the one present in the folder asm of this repo and not the one that comes with
Romain Mormon's tool. The later is not compatible with the FPGA version of the beta machine.

When you have an asm file, you can assemble it with `python3 beta_assembler --filepath <file_path>` where file_path 
is a relative path to your file (path must contain file extension). This will parse your file, then assemble it and
output a binary file named `out.bin` that you can use to program the machine.

## Notes on registers

Some registers should be used with caution

* R0, is the 0 register which means that it should always contain `0x00000000` to make sure that all the shortcut 
operators will work properly. To know which operators are concerned, you can `CTRL + F` "r0" and "R0" in `beta.uasm`
(the version of this repo -> `asm/beta.uasm`).
* R28, is the Linkage register, it holds the return adr
* R29, is the Frame pointer, itpoints to the base of the frame
* R31, is used to store `PC + 4` during branch and jump operations

## Credits

All credits go to [Mormont Romain](https://people.montefiore.uliege.be/rmormont/) who kindly accepted to give me access 
to his assembler. I only modified `beta.uasm` and created `beta_assembler.py` which is basicaly his file `test_program.py` 
without the simulation and with the bin file export added.