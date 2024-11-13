/* Name: Shyam Venkatesan */
/* Date: Nov-12-2024 */
/* Description: Self-checking testbench for an ALU that reads from a testvector and compares expected outputs with real outputs.*/

// Timescale in 1 nanosecond with error of 1 picosecond 
`timescale 1ns/1ps

// Module to perform the ALU tests
module ALUTestbench();
  // 8 bit logic to hold A and B inputs
  logic [7:0] A, B;
  // 2 bit logic to hold ALUControl flag 
  logic [1:0] ALUControl;
  // 8 bit logic to hold the real Y output and expected Y
  logic [7:0] Y, YExpected;
  // 1 bit logic to hold real output and expected V, C, N, Z
  logic V, C, N, Z, VExpected, CExpected, NExpected, ZExpected;
  // 1 bit logic for clock operation
  logic clk, reset;
  // 3 bit logic for book keeping variables
  logic [2:0] vectornum, errors;
  // Logic array of 5 testvectors that hold 30 bits
  logic [29:0] testvectors[4:0];

  // Design under test for the ALU with parameters
  ALU DUT(.A(A), .B(B), .ALUControl(ALUControl), .Y(Y), .V(V), .C(C), .N(N), .Z(Z));
  
  // Clock generation, each period is 10 nanoseconds
  always #5 clk = ~clk;

  // Start of the DUT
  initial begin
    
    // Writes to dump file with first level of variables 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    // Reads input from the testvectors file
    $readmemb("testvectors.tv", testvectors);
    // Initializes clock and book keeping variables
    clk = 0;
    vectornum = 0;
    errors = 0;
    // Pulse resets the ALU and waits 20 nanoseconds after each step
    reset = 1;
    #20;
    reset = 0;
    #20;
  end

  // Reads input on the positive edge of the clock
  always @(posedge clk) begin
    // Waits 10 nanoseconds then reads input and expected values sequentially into the correct variable
    #10;
    {A, B, ALUControl, YExpected, NExpected, ZExpected, CExpected, VExpected} = testvectors[vectornum];
  end

  // Checks results on the negative edge of the clock
  always @(negedge clk) begin
    // Skip during reset
    if (~reset) 
      begin
      // If any of the ouputs don't match with the expected values
      if (Y != YExpected || V != VExpected || C != CExpected || N != NExpected || Z != ZExpected) 
        begin
        // Prints an error with the inputs, outputs, and expected values
        $display("Error: inputs = A: %b, B: %b, ALUControl: %b", A, B, ALUControl);
        $display("outputs = Y: %b, YExpected: %b, N: %b, NExpected: %b, Z: %b, ZExpected: %b, C: %b, CExpected: %b, V: %b, VExpected: %b", Y, YExpected, N, NExpected, Z, ZExpected, C, CExpected, V, VExpected);
        // Increments the error variable
        errors = errors + 3'b001;
      end
      // All the expected and output variables match
      else
        begin
          // Prints a success message with inputs, outputs, and expected values
          $display("Success: inputs = A: %b, B: %b, ALUControl: %b", A, B, ALUControl);
          $display("outputs = Y: %b, YExpected: %b, N: %b, NExpected: %b, Z: %b, ZExpected: %b, C: %b, CExpected: %b, V: %b, VExpected: %b", Y, YExpected, N, NExpected, Z, ZExpected, C, CExpected, V, VExpected);
        end
      
      // Increments vertornum for the next testvector
      vectornum = vectornum + 3'b001;

      // If the vectornum is greater than 4, all tests have been carried out
      if (vectornum > 3'b100) 
        begin
        // Displays how many tests were carried out and how many caused errors
        $display("%d tests completed with %d errors", vectornum, errors);
        // The testbench finishes
        $finish;
      end
    end
  end
  // End of the module
endmodule
