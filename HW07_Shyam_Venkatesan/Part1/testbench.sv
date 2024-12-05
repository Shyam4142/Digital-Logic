/* Name: Shyam Venkatesan */
/* Date: Nov-27-2024 */
/* Description: Testbench to determine CPU controller behavior based on each of the 6 possible instruction inputs.*/

// Timescale is 1 nanosecond with error of 1 picosecond
`timescale 1ns/1ps

// Module to test the controller
module ControllerTest();
  // 3 bit input register that uses 3 MSB of Instruction
  reg [11:9] Instruction;
  // 2 bit ALU control output wire
  wire [1:0] ALUcontrol;
  // 1 bit output wires for write enable states and mux selections
  wire RF_W_we, DMEM_we, Mux_select_M0, Mux_select_M1;
 
  // Design under test for the Controller with parameters
  controller DUT(.Instruction(Instruction), .ALUcontrol(ALUcontrol), .RF_W_we(RF_W_we), .DMEM_we(DMEM_we), .Mux_select_M0(Mux_select_M0), .Mux_select_M1(Mux_select_M1));
  
  // Start of them DUT
  initial begin
    // Writes to dump file with first level of variables
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    // First instruction is set to 000
    Instruction = 3'b000;
    // Repeat loop for 6 times
    repeat (6) begin
      // 10 NS wait for value to change
      #10;
      // Displays the Instruction, ALU control, register write state, memory write state, M0 mux selection, and M1 mux selection.
      $display("Instruction: %b, ALUcontrol: %b, RF_W_we: %b, DMEM_we: %b, Mux_select_M0: %b, Mux_select_M1: %b", Instruction, ALUcontrol, RF_W_we, DMEM_we, Mux_select_M0, Mux_select_M1);
      // Increments the instruction value by 1
      Instruction = Instruction + 3'b001;
    end
    // Finish statement called
    $finish;
    // End of the DUT
  end
  // End of the module
endmodule
    
    
