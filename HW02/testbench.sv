/* Name: Shyam Venkatesan */
/* Date: Sep-22-2024 */
/* Description: Testbench to test the 4 bit adder on all possible input values and the 2:1 Mux on the specified inputs. Outputs are printed to the screen.*/

// Timescale in nanoseconds with error of 1 picosecond
`timescale 1ns/1ps

// Module to test the 8 bit adder
module AdderTest();
  // 4 bit registers a and b for adder input
  reg[3:0] a, b;
  // 1 bit register cin for adder carry-in
  reg cin;  
  
  // 5 bit wire sum for adder output
  wire [4:0] sum;
  
  // integers i, j, and k for loop control
  integer i, j, k;
  // Design under test for FourBitAdder with parameters
  FourBitAdder DUT(.a(a), .b(b), .cin(cin), .sum(sum));
  // Start of the DUT
  initial
    begin
      // Wait for 100 nanoseconds for MuxTest to complete first
      #100;
      // Message to notify that Adder test cases are beginning
      $display("Start Verifying Adder");
	  // Loops through 15 possible decimal values for a
      for(i = 0; i < 5'd16; i = i + 1)
        begin
          // Loops through 15 possible decimal values for b
          for(j = 0; j < 5'd16; j = j + 1)
            begin
              // Loops through 2 possible decimal values for cin
              for(k = 0; k < 2'd2; k = k + 1)
                begin
                  // Sets a to i, b to j, and c to k
                  a = i;
                  b = j;
                  cin = k;
                  // 10 nanosecond delay between each display statement
                  #10;
                  // Displays the a, b, and cin values being added and their sum
                  $display("a+b+cin:%0d+%0d+%0d = %0d", a, b, cin, sum);
                end
            end
        end
      // Finish statement called to end sim
      $finish;
      // End of the DUT and the module
    end
endmodule

// Module to test the 2:1 mux
module MuxTest();
  // 8 bit registers d0 and d1 for mux input
  reg[7:0] d0, d1;
  // 1 bit register cin for mux selection
  reg select;  
  
  // 8 bit wire for mux's selected output
  wire [7:0] y;
  
  // Design under test for Mux21 with parameters
  Mux21 DUT(.d0(d0), .d1(d1), .select(select), .y(y));
  // Start of the DUT
  initial
    begin
      // Message to notify that Mux test cases are beginning
      $display("Start Verifying Mux");
      // Alternates between different d0, d1, and select values.
      d0 = 5;
      d1 = 50;
      // Select assigned 0
      select = 0;
      // Waits 10 seconds after assigning values to the variables
      #10;
      // Displays inputs and the output selection for the mux
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 5;
      d1 = 51;
      select = 0;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 6;
      d1 = 50;
      select = 0;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 6;
      d1 = 51;
      select = 0;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 5;
      d1 = 50;
      // Select assigned 1
      select = 1;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 5;
      d1 = 51;
      select = 1;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 6;
      d1 = 50;
      select = 1;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
      d0 = 6;
      d1 = 51;
      select = 1;
      #10;
      $display("sel:%0d, i0: %d, i1: %d, y: %d", select, d0, d1, y);
	// End of the DUT and the module
    end
endmodule
  


