# Master thesis - Polet Quentin

## Tasks

- [ ] 6/4: Adding missing hardware components for read and write operations
- [ ] 7/4: Adding program length counter + hardware interrupt and stop when done
- [ ] 8/4: Figuring how to catch the interrupt and handle it
- [ ] 9/4: Writing C software for writing a program from a file + getting the result when interrupt
- [ ] 10/4: Same as yesterday
- [ ] 11/4: Adding Romain's assembler to the programming flow
- [ ] 12/4: Adding a result comparator: Ram and RF contents
- [ ] 13/4: Same as yesterday

## Tasks to schedule

- [ ] Before end of April: Writing some "verifications" and comparing results with Romain's machine 
- [ ] Before end of April: Writing a graphical demo, + making the mask ROM programmable if time
- [ ] May: Writing hardware benchmarks + simulation + report

## Questions to answer
Nothing

## What's new

**[End of March] __Working on the graphical output__**

**[19th March 2021] __Modifying linux distro__**

The distro that was used seemed to be outdated and not supported anymore. The project
now uses ubuntu.

**[18th March 2021] __Working on communications__**

**[9th March 2021] __Working on the hardware design__**

I designed a 640x480 12bits colors (4bits for each primary color) display controller that hopefuly 
handles HDMI properly. Need to be tested with the CPU.

Notes: gc always add 1 to h and v counts, weird behavior on rgb too.

**[1st March 2021] __Writing report__**

Two first sections of the third chapter are now writen. I decided to start back to zero as what I
previously wrote wasn't totaly OK. The new chaptering looks more logical.

**[28th February 2021] __The base machine is finished__**

The machine is now finished. It still has to be verified (do all operations work properly?). But
a Fibonacci sequence has been computed with success.

**[25th November 2020] __Re-implementing the RAM__**

I finished implementing a very simple "cache" that has only one line containing two 32-bit words because the ACP (Accelerator Coherency Port) works on 64bits. 
I'm currently writing the testbench that is supposed to allow me to simulate and test it. 

- [Creating a Qsys IP](https://www.youtube.com/watch?v=v6rhbVABlo8)
- [Section 30 : simulating the hps](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_54001.pdf)
- [Example on youtube (not sure that it is the way to go)](https://www.youtube.com/watch?v=tFLaiqIdDlQ)

**[18 - 19th and 23rd November 2020] __Thinking on how to re-implement the RAM__**

As the ram I was using was partly a black box provided by Terasic (the card manufacturer), I prefer to rebuild it myself (only the communication part). 
The goal is to be able to manage the protocol (AXI4) and thus choose how the data is transferred. Moreover, it makes it easier for me to understand how 
everything works and to be able to integrate it into the complete system including linux (to link it to the preloader and correctly configure the device tree).

The idea is to create a simple memory access on the FPGA side that will communicate with the ACP (Accelerator Coherency Port) as a master. 
The ACP allows hidden memory access by 64-bit lines. 

- [Physical Page Allocation on linux](https://www.kernel.org/doc/gorman/html/understand/understand009.html)
- How to access devices from FPGA -> ftp://ftp.intel.com/pub/fpgaup/pub/Teaching_Materials/current/Tutorials/Accessing_HPS_Devices_from_FPGA.pdf
- [Accelerator Coherency Port](https://developer.arm.com/documentation/ddi0434/c/snoop-control-unit/about-the-scu/accelerator-coherency-port)
- [3.6 Managing Coherency for FPGA Accelerators](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/an/an-cv-av-soc-ddg.pdf)
  I must use the AXI protocol instead of the Avalon one because the Avalon protocol doesn't support cached operations.
- [Level 2 Cache Controller Technical Reference Manual](https://developer.arm.com/documentation/ddi0246/h)
- [A video on AXI protocol (theoretical aspects)](https://www.youtube.com/watch?v=Vw2_1pqa2h0)
- [The AXI protocol reference](http://www.gstitt.ece.ufl.edu/courses/fall15/eel4720_5721/labs/refs/AXI4_specification.pdf)
- [Another playlist of 5 videos on AXI protocol (practical aspects)](https://www.youtube.com/watch?v=1zw1HBsjDH8&list=PLaSdxhHqai2_7WZIhCszu5PLSbZURmibN)
- [Understanding AXI addressing](https://zipcpu.com/blog/2019/04/27/axi-addr.html)
- [Building a basic AXI Master](https://zipcpu.com/blog/2020/03/23/wbm2axisp.html)


**[14 - 17th November 2020] __Preloader / Bootloader / Linux Kernel / System file__**

It took me 4 days but I'm now able to create custom preloader / bootloader / linux kernel
and system file and boot them all on the ARM side. The preloader also boot the FPGA and set
its content on the way.

-> I'm happy

**Links that helped (a lot)**
- Embedded Linux Beginners Guide from RocketBoards.org -> ftp://ftp.intel.com/pub/fpgaup/pub/Teaching_Materials/current/Tutorials/Accessing_HPS_Devices_from_FPGA.pdf
- [FPGA/Linux co-design with Cyclone V tutorial from aignacio's](https://blog.aignacio.com/hardware-software-design-in-cyclone-v-de10-nano/)
- [Bitlog's tutorial on Building embedded Linux for the Terasic DE10-Nano (and other Cyclone V SoC FPGAs)](https://bitlog.it/20170820_building_embedded_linux_for_the_terasic_de10-nano.html)

**[13th November 2020] __Working on the report and register file__**

Register file is now ready and I added register file and on-chip memory sections to the report.

**[4th November 2020] _Reading stuff about on-chip memory_**

**Documentation** :
- https://www.studocu.com/en-us/document/university-of-alabama/digital-systems-design/lecture-notes/lec-6-memory-implementation-on-altera-cyclone-v-devices/1064914/view
- http://www.ee.ic.ac.uk/pcheung/teaching/ee2_digital/Lecture%2014%20-%20FPGA%20Embedded%20Memory.pdf
- And the Cyclone V datasheet obviously : [Overview](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_51001.pdf) and [Handbook volume I](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_5v2.pdf)

**[3rd November 2020] _Getting ready for the meeting_**

I finished the test for reading and writing in the memory and completed the report.
I also modified the counters. Finally, I checked foralready existing machines available on the board that I use.

**[2nd November 2020] _Completing the report_**

I added the sections related to the communication between ARM and FPGA sides.

**Important documentations**

- [Avalon documentation](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/manual/mnl_avalon_spec.pdf)
- [Cyclone V HPS documentation](https://www.intel.com/content/dam/www/programmable/us/en/pdfs/literature/hb/cyclone-v/cv_54001.pdf)

**[29th October 2020] _Working on the memory_**

I created the memory driver module that makes the link between FPGA memory and
the physical memory - still need to test it. Code of the memory driver module is available in `quartus/simple_memory`.

**[27th October 2020] _Working on the memory_**

I created the memory module, I still have to write the memory driver to drive
the DDR3. Code of the memory module is available in `quartus/simple_memory`.

**[11th October 2020] _Adding code and first draft report on git_**

The report is available in `latex/report.tex` and `latex/report.pdf`. Feel free
to
anotate the .tex file and push it on the repository.

Simple counter project is available in `quartus/simple_counter`. This can be
opened
from Quartus Prime Lite 20.1 (click open project then select .qpf file). The
project
can be compiled. To visualize the generated "schematics" go in Tools/Netlist
Viewers/RTL viewer (after compilation has terminated). Code files are available
in .v files under `quartus/simple_counter` directory.

**[23rd September 2020] _Continuing the work on DDR3 RAM acces_**

Found new interesting stuff here https://github.com/robertofem/CycloneVSoC-examples/tree/master/Baremetal-applications/DMA_transfer_FPGA_DMAC.

**[11th September 2020] _Figuring out how to access the DDR3 RAM_**

The DDR3 RAM (1Go) is only accessible from the ARM side but a bridge exists
between
the two sides of the chip. How to use it?

**Links that might help**
- https://stackoverflow.com/questions/57525000/altera-de10-standard-writing-to-ddr-using-fpga
- https://community.intel.com/t5/FPGA-SoC-And-CPLD-Boards-And/How-to-directly-access-linux-s-RAM-with-FPGA-on-de10-nano/td-p/636169
- https://zipcpu.com/blog/2018/11/03/soc-fpga.html
- https://digibird1.wordpress.com/playing-with-the-cyclone-v-soc-system-de0-nano-soc-kitatlas-soc/
- [Cornell university lectures on SoC+FPGA ships](https://www.youtube.com/watch?v=sKhvMhTiuM4&list=PLKcjQ_UFkrd7UcOVMm39A6VdMbWWq-e_c)

In brief, one first need to create a program on the ARM side that maps the
physical
RAM to virtual RAM that is used in a bus that interconnects the ARM and FPGA
sides.
Then, a bus controller must be implemented on the FPGA side to communicate
through
the Avalon bus. The controller can be designed using QSys, a quartus tool that
ease
that kind of development, using a visual programming language. More over, QSys
comes
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
