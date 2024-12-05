/* Name: Shyam Venkatesan */
/* Date: Nov-27-2024 */
/* Description: Main CPU design file that brings together controller, registerfile, ALU, memory, muxes, and programcounter. Returns the data from memory and takes in clock and reset signals.*/

// Includes all the CPU component files
`include "controller.sv" 
`include "registerfile.sv" 
`include "ALU.sv" 
`include "memories.sv"
`include "parameterized_mux.sv"

// Main CPU module
module top_CPU(clk,reset,D_rd_data);
  // Clock and reset are input signals
  input clk, reset;
  // Return data is an 8 bit output
  output [7:0] D_rd_data;
  
  // 4 bit register program counter, up to 16 instructions
  reg [3:0] Counter;
  // 12 bit wire to transmit the current instruction
  wire [11:0] Instruction;
  // 8 bit wires for data in R1/R2 registers, ALU result, and mux outputs
  wire [7:0] R1_data, R2_data, ALU_result, Mux_out_M0, Mux_out_M1;
  // 3 bit wires for R1 and R2 register addresses
  wire [2:0] R1_addr, R2_addr;
  // 2 bit wire for ALU control
  wire [1:0] ALUcontrol;
  // 1 bit wires for write enable state and mux selectors
  wire RF_W_we, DMEM_we, Mux_select_M0, Mux_select_M1;
  
  // New instruction fetched on each positive edge of clock cycle
  always @(posedge clk) begin
    // Resets counter to 0
    if(reset) begin
      Counter <= 0;
    end
    // Increments counter by 1
    else begin 
      Counter <= Counter + 3'b001;
    end
  end
  
  // Creates an imem instance with the current count as input and Instruction as output
  imem instruction_memory(.addr(Counter), .rd_data(Instruction));
  
  // Creates a controller instance with 3 MSB of Instruction as input and ALU control, write enable states, and Mux states as outputs. 
  controller CPU_controller(.Instruction(Instruction[11:9]), .ALUcontrol(ALUcontrol), .RF_W_we(RF_W_we), .DMEM_we(DMEM_we), .Mux_select_M0(Mux_select_M0), .Mux_select_M1(Mux_select_M1));
  
  // Creates a Mux2x1 instance with two Instruction subsets that are sign extended for the two options. Mux selection M1 is used to select an output to Mux out M1. 
  Mux2x1 mux_M1(.in1({2'b00, Instruction[8:3]}), .in0({2'b00, Instruction[5:0]}), .sel(Mux_select_M1), .out(Mux_out_M1));
  
  // Creates a register_file instance that takes in the CPU clock, register write enable and reset signals as well as the address for R1/R2/Write (derived from Instruction) and their data. 
  register_file register(.clk(clk), .reset(reset), .R1_addr(Instruction[5:3]), .R1_data(R1_data), .R2_addr(Instruction[2:0]), .R2_data(R2_data), .W_addr(Instruction[8:6]), .W_data(Mux_out_M0), .W_we(RF_W_we));
  
  // Created an ALU instance that takes in R1 and R2 data as inputs along with the ALU control. Returns the ALU result, other outputs are ignored. 
  ALU alu(.Result(ALU_result), .N(), .Z(), .C(), .V(), .A(R1_data), .B(R2_data), .ALUcontrol(ALUcontrol));
  
  // Creates a dmem instance taking in the clk and memory write enable signals as well as the memory address from the Mux out M1 and the write data. In the case that data is read, it is returned to the D_rd_data output. 
  dmem data_memory(.clk(clk), .we(DMEM_we), .addr(Mux_out_M1[5:0]), .wr_data(R1_data), .rd_data(D_rd_data));
  
  // Creates a Mux2x1 instance with memory data read and ALU result as options. Mux selection M0 is used to select an output to Mux out M0. 
  Mux2x1 mux_M0(.in1(D_rd_data), .in0(ALU_result), .sel(Mux_select_M0), .out(Mux_out_M0));

// End of the Module
endmodule