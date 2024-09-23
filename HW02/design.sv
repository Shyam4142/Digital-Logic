/* Name: Shyam Venkatesan */
/* Date: Sep-22-2024 */
/* Description: Verilog file for iterative circuit that builds an 4 bit adder using full adders and half adders. Also builds a 2:1 mux circuit. */

// Module for the half adder structure
module HalfAdder(a, b, carry, sum);
  // a and b are 1 bit binary inputs
  input a, b;
  // carry and sum are 1 bit binary outputs
  output carry, sum;
  
  // 1 bit binary temporary variables for basic operations
  wire notA, notB, aAndNotB, notAAndB;
  
  // Structural Verilog 
  
  // Stores result of !a in notA
  not(notA, a);
  // Stores result of !b in notB
  not(notB, b);
  // Stores result of a & notB in aAndNotB
  and(aAndNotB, a, notB);
  // Stores result of notA & B in notAAndB
  and(notAAndB, notA, b);
  // Stores the sum value in sum through aAndNotB | notAAndB
  or(sum, aAndNotB, notAAndB);
  // Stores the carry value in carry through a & b
  and(carry, a, b);
  // End of module
endmodule

// Module for the full adder structure
module FullAdder(a, b, cin, sum, cout);
  // a, b, and c are 1 bit binary inputs
  input a, b, cin;
  // carry and sum are 1 bit binary outputs
  output sum, cout;
  
  // 1 bit binary variables for temporary storage
  wire sum1, carry1, carry2;
  
  // Two half adders conencted to calculate the sum
  
  // Creates a HalfAdder instance with the input a and b, Output values stored in sum1 and carry1.
  HalfAdder hAdder1(.a(a), .b(b), .sum(sum1), .carry(carry1));
  // Creates a HalfAdder instance with the input sum1 and cin, Output values stored in sum and carry2.
  HalfAdder hAdder2(.a(sum1), .b(cin), .sum(sum), .carry(carry2));
  
  // Stores the carry out value in cout through a | b
  or(cout, carry1, carry2);
  // End of module
endmodule

// Module for the 4 bit adder structure
module FourBitAdder(a, b, cin, sum);
  // a and b are 4 bit binary input arrays
  input [3:0] a, b;
  // cin is a 1 bit binary input
  input cin;
  
  // sum is a 5 bit binary output arrays(because max sum is 31)
  output[4:0] sum;
  
  // 1 bit binary variables for temporary storage
  wire cout, cout1, cout2, cout3;
  
  // 4 1-bit full adders chained together to find the sum
  
  // Creates a FullAdder instance with the input a[0], b[0], and cin. Output values stored in sum[0] and cout1.
  FullAdder fAdder1(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout1));
  // Creates a FullAdder instance with the input a[1], b[1], and cout1. Output values stored in sum[1] and cout2.
  FullAdder fAdder2(.a(a[1]), .b(b[1]), .cin(cout1), .sum(sum[1]), .cout(cout2));
  // Creates a FullAdder instance with the input a[2], b[2], and cout2. Output values stored in sum[2] and cout3.
  FullAdder fAdder3(.a(a[2]), .b(b[2]), .cin(cout2), .sum(sum[2]), .cout(cout3));
  // Creates a FullAdder instance with the input a[3], b[3], and cout3. Output values stored in sum[3] and cout.
  FullAdder fAdder4(.a(a[3]), .b(b[3]), .cin(cout3), .sum(sum[3]), .cout(cout));
  // Stores the final carryout value as the leftmost bit in the sum array.
  assign sum[4] = cout;
  // End of module
endmodule

// Module for the 2:1 mux structure
module Mux21(d0, d1, select, y);
  // d0 and d1 are 8 bit binary input for mux values
  input [7:0] d0, d1;
  // select is a 1 bit binary input for mux decision
  input select;
  
  // y is an 8 bit binary output for selected mux value
  output [7:0] y;
  
  // Ternary logic to assign value of d1 or d0 based on whether select is 1 or 0. 
  assign y = select ? d1 : d0;
  // End of module
endmodule

    
  
  
  
  
  
  
  
  
  
  
  
