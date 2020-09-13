# Master thesis - Polet Quentin

## Tasks

- [x] Look for previous related works and read them
- [x] Find a way to access the DDR3 RAM from the FPGA side
- [ ] Try to set / load data to the RAM from the FPGA side

## What's new

**[11th September 2020] _Figuring out how to access the DDR3 RAM_**

The DDR3 RAM (1Go) is only accessible from the ARM side but a bridge exists between
the two sides of the chip. How to use it?

**Links that might help**
- https://stackoverflow.com/questions/57525000/altera-de10-standard-writing-to-ddr-using-fpga
- https://community.intel.com/t5/FPGA-SoC-And-CPLD-Boards-And/How-to-directly-access-linux-s-RAM-with-FPGA-on-de10-nano/td-p/636169
- https://zipcpu.com/blog/2018/11/03/soc-fpga.html
- https://digibird1.wordpress.com/playing-with-the-cyclone-v-soc-system-de0-nano-soc-kitatlas-soc/
- [Cornell university lectures on SoC+FPGA ships](https://www.youtube.com/watch?v=sKhvMhTiuM4&list=PLKcjQ_UFkrd7UcOVMm39A6VdMbWWq-e_c)

In brief, one first need to create a program on the ARM side that maps the physical
RAM to virtual RAM that is used in a bus that interconnects the ARM and FPGA sides.
Then, a bus controller must be implemented on the FPGA side to communicate through
the Avalon bus. The controller can be designed using QSys, a quartus tool that ease
that kind of development, using a visual programming language. More over, QSys comes
with libraries that already contains this kind of controller.


**[27th August 2020] _Currently reading several documents and watching videos_**

**Documents**
- [The Design of a RISC Architecture and its Implementation with an FPGA](https://people.inf.ethz.ch/wirth/FPGA-relatedWork/RISC.pdf)
- [Design and FPGA-Based Implementation of A High Performance 64-Bit DSP Processor](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiI6sunu7vrAhWKT8AKHW7BC0YQFjAWegQIBRAB&url=https%3A%2F%2Fwww.ijecs.in%2Findex.php%2Fijecs%2Farticle%2Fdownload%2F3823%2F3561%2F&usg=AOvVaw2u86vhoApdszJ7nbjaadRv)
- [An FPGA-based integrated environment for computer architecture](https://www.researchgate.net/publication/229883966_An_FPGA-based_integrated_environment_for_computer_architecture)
- [A median filter FPGA with Harvard Architecture](https://ieeexplore.ieee.org/document/5765209)
- [FPGA Harvard Architecture](https://www.kdsglobal.com/datas/files/doc/fpga.pdf)
- [Using FPGA for Computer Architecture/Organization Education](https://projects.ncsu.edu/wcae//WCAE2/li.pdf)
- [A scratch-built RISC-V CPU in an FPGA](https://hackaday.com/2019/11/19/emulating-risc-v-on-an-fpga/)
- [Sharf: An FPGA-based customizable processor architecture](https://ieeexplore.ieee.org/abstract/document/5272447)
- [FPGA Implementation of Low Power Pipelined 32-BIT RISC Processor](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.685.5326&rep=rep1&type=pdf)
- [Pipelined 8-bit RISC processor design using Verilog HDL on FPGA](https://ieeexplore.ieee.org/abstract/document/7808194)
- [A PIC compatible RISC CPU core Implementation for FPGA based Configurable SOC platform for Embedded Applications](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.670.9479&rep=rep1&type=pdf)
- [A basic processor for teaching digital circuits and systems design with FPGA](https://ieeexplore.ieee.org/abstract/document/6211804)

**Videos**
- [FPGA Design using VHDL Lectures](https://www.youtube.com/watch?v=BDq8-QDXmek&list=PLZv8x7uxq5XY-IQfQFb6mC6OXzz0h8ceF)
- [FPGA Design for Embedded Systems](https://www.youtube.com/watch?v=0y3rX_7fYpg&list=PL2jykFOD1AWbl91wO_iW33QdDkxdLT1Ep)
- [Bit by bit - How to fit 8 RISC V cores in a $38 FPGA board](https://www.youtube.com/watch?v=xjIxORBRaeQ)
- [RISCV CPU on an FPGA: OpenSource and size optimized!](https://www.youtube.com/watch?v=k2rN8FE1jWM)
- [MeganWachs - Keynote RISC-V and FPGAs: Open Source Hardware Hacking](https://www.youtube.com/watch?v=vCG5_nxm2G4)
