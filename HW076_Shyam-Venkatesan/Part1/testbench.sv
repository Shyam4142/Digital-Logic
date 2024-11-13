/* Name: Shyam Venkatesan */
/* Date: Nov-12-2024 */
/* Description: Checkerboard testbench to test the AI and eLearning variants of the register file by writing in alternating hex values and reading them using both them from bith R1 and R2.*/


// Timescale in 1 nanosecond with error of 1 picosecond 
`timescale 1ns/1ps

// Module to perform the checkerboard test
module checkerboardTest();
  // 1 bit input registers for clock operation and write status
  reg reset, clk, W_we;
  // 2 bit input register of the addresses to write or read from
  reg [2:0] W_addr, R1_addr, R2_addr;
  // 8 bit input registers of the data to be written or the expected read value
  reg [7:0] W_data, E1_data, E2_data;
  // 8 bit output wires of the data that is actually read from the register file
  wire [7:0] R1_data, R2_data;
  
  // Parameterized variables to store the alternating hex values (Constant)
  parameter [7:0] P1_data = 8'hAA;
  parameter [7:0] P2_data = 8'h55;
  
  // Integer to control the for loops
  integer i;
  
  // Design under test for the register file with parameters
  registerfile DUT (.clk(clk), .reset(reset), .W_we(W_we), .W_addr(W_addr), .R1_addr(R1_addr),   .R2_addr(R2_addr), .W_data(W_data), .R1_data(R1_data), .R2_data(R2_data));
  
  // Start of the DUT
  initial
    begin
      
      // Writes to dump file with first level of variables 
      $dumpfile("dump.vcd");
      $dumpvars(1);
      
      // Clock initially set to 0
      clk = 1'b0;
      // Reset set to 1 (resets the register file values)
      reset = 1'b1;
      // Write enable turned off
      W_we = 1'b0;
      // Address and data registers initialized to 0
      W_addr = 3'b000;
      W_data = 8'b00000000;
      R1_addr = 3'b000;
      R2_addr = 3'b000;
      // 10 nanosecond wait for reset to complete
      #10;
      // Reset turned off
      reset = 1'b0;
      
      // Writing Checkerboard
      // For loop iterates 8 times (length of register file)
      for(i = 0; i < 4'd8; i = i + 1) 
        begin
        // Write address is i
        W_addr = i;
        // Write data depends on i: preset 1 if even, preset 2 if odd
        W_data = (i % 2 == 0) ? P1_data : P2_data;
        // Write enable turned on to write to register file
        W_we = 1;
        // 10 nanosecond is one clock cycle
        #10;
        // Write enable disabled
        W_we = 0;
      end
      
      // Reading Checkerboard
      // For loop iterates 8 times (length of register file)
      for(i = 0; i < 4'd8; i = i + 1) 
        begin
        // R1 iterates from beginning to end
        R1_addr = i;
        // R2 iterates from end to beginning
        R2_addr = 4'd7 - i;
        // 10 nanosecond wait
        #10;
        
        // Expected data calculated for register 1 and 2 based on whether the address is even or odd
        E1_data = (R1_addr % 2 == 0) ? P1_data : P2_data;
        E2_data = (R2_addr % 2 == 0) ? P1_data : P2_data;
        
        // If R1's expected value does not match the actual, the test fails and an error message is printed
        if(R1_data != E1_data) 
          begin
          $display("Test failed at R1_addr %d: got %h", R1_addr, R1_data);
          $finish;
        end
               
        // If R2's expected value does not match the actual, the test fails and an error message is printed
        if(R2_data != E2_data) 
          begin
          $display("Test failed at R2_addr %d: got %h", R2_addr, R2_data);
          $finish;
        end
        // Prints successful test for each R1 and R2 address
        $display("Test passed at R1_addr %d: got %h", R1_addr, R1_data);
        $display("Test passed at R2_addr %d: got %h", R2_addr, R2_data);
      end
      // If all tests pass successfuly, the testbench finishes
      $display("All tests successfully passed");
      $finish;
    end
  
  	// Clock generation, each period is 10 nanoseconds
    always #5 clk = ~clk;
  // End of the module
endmodule