# UART_Communication_Verilog-
This repository contains a Verilog implementation of a UART (Universal Asynchronous Receiver-Transmitter) communication system. 
The design features separate modules for a transmitter (UART_Tx) and a receiver (UART_Rx), both built using a Finite State Machine (FSM) architecture for robust and clear logic. 
The transmitter serializes an 8-bit parallel data byte into a standard UART frame (1 start bit, 8 data bits, 1 stop bit), while the receiver converts the serial stream back into parallel data. A comprehensive loopback testbench is also included to verify the functionality of the end-to-end communication.

