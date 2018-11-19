# ELD-Mini-Project
## PN Sequence Generator

The functionality of PN Sequence Generator block in MATLAB is implemented on verilog and tested on Basys3 FPGA. It generates maximal length pseudo-random sequences of variable length (2-12 bits). 

### Input Parameters
<b>[3:0] num</b>: 4-bit input for the length of the sequence. Valid lengths are 2-12  
<b>[5:0] init</b>: 6-bit input for the initial value of the sequence. The initial value should be non-zero  
<b>[5:0] mask</b>: 6-bit input for the output mask. If mask = 0, then then the normal sequence is displayed otherwise the mask is applied and a pseudo-random binary sequence is displayed of the given length   
<b>next</b>: Left push button (W19) is used to display the next number in the sequence  
<b>rst</b>: Right push button (T17) is used to reset the sequence to initial value  
<b>clk</b>: 100MHz board clock  

### Output Parameters
The current number is displayed on the on-board Seven Segment Display using the cathode and anode outputs.

### How it works
For a n-bit input length the sequence is 2<sup>n</sup>-1 numbers long and displays the numbers from 1 to 2<sup>n</sup>-1 randomly. To generate the sequence of maximal length (2<sup>n</sup>-1) characteristic polynomials of degree n are stored in a Block ROM. The sequence generator is implemented using shift registers and feedback taps. The output mask is used to convert the sequence into a random binary sequence.

### How to use the code
top_init.v file contains the code for the PN sequence generator. Download all the files and import into vivado project. Import the block ram IP (.xci file) from the blk_mem_gen_0 folder. Add pn.xdc as the constraint file and generate the bitstream. top_init.bit is also given if the code needs to be directly used on the Basys3 Board.
