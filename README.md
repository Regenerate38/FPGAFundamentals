# FPGA Fundamentals

This repository contains practice projects and experiments with FPGA development, focusing on fundamental digital design concepts and modules implemented in Verilog. It is intended for learning and hands-on experience with FPGA programming and design.

## Projects

- **8-bit CPU**  
  A simple 8-bit CPU implementation demonstrating fundamental concepts of processor design such as ALU, registers, instruction decoding, and clocking.  
  Source file: [`CPU.v`](https://github.com/<Username>/FPGAFundamentals/blob/main/FPGAFundamentals.srcs/sources_1/new/CPU.v)

- **Sequence Detector**  
  Finite state machine detecting specific bit patterns in a serial input stream.  
  Source file: [`seq_detector.v`](https://github.com/<Username>/FPGAFundamentals/blob/main/FPGAFundamentals.srcs/sources_1/new/seq_detector.v)

- **Clock Divider**  
  Module to generate a slower clock signal from a faster system clock, useful for timing and control.  
  Source file: [`clock_divider.v`](https://github.com/<Username>/FPGAFundamentals/blob/main/FPGAFundamentals.srcs/sources_1/new/clock_divider.v)

- **UART (Universal Asynchronous Receiver/Transmitter)**  
  UART module implementing serial communication protocol for data transmission and reception.  
  Source file: [`uart.v`](https://github.com/<Username>/FPGAFundamentals/blob/main/FPGAFundamentals.srcs/sources_1/new/uart.v)


## Directory Structure

All Verilog source files are located under:  
`FPGAFundamentals.srcs/sources_1/new/`

All Testbench files are located under:  
`FPGAFundamentals.srcs/sim_1/new/`

## Usage

Clone this repository and open the project in your preferred FPGA development environment (e.g., Xilinx Vivado, Intel Quartus) to simulate or synthesize each module. Each file is self-contained for the respective functionality.

