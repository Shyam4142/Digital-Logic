/* Name: Shyam Venkatesan */
/* Date: Nov-12-2024 */
/* Description: ALU that takes in two 8-bit values and performs one of four operations: add, subtract, and, or. This is done based on the ALU control and it returns the final output as well as other conditions like zero, overflow, carry, or negative.*/

// Module for ALU functionality
module ALU (A, B, ALUControl, Y, V, C, N, Z);
  // A, B are 8 bit input registers
  input reg [7:0] A, B;
  // ALUControl is the 2 bit input register to control the ALU function
  input reg [1:0] ALUControl;
  // Y is the 8 bit output register
  output reg [7:0] Y;
  // V, C, N, and Z are 1 bit output status registers
  output reg V, C, N, Z;
  // Cout is an intermediate register to store the carry from the adder
  reg Cout;

  // Activates based on a change in the sensitivity list
  always @(*) begin
    // Switch statement based on ALUControl
    case (ALUControl)
      // 00: adds A and B, stores carry in Cout and output in Y
      2'b00: {Cout, Y} = A + B; 
      // 01: subtracts B from A (Two's Complement) and stores the output in Y
      2'b01: Y = A + ~B + 8'b00000001;
      // 10: bitwise and of A and B stored in Y
      2'b10: Y = A & B; 
      // 11: bitwise or of A and B stored in Y
      2'b11: Y = A | B;              
      default: Y = 8'b00000000;
    endcase

    // If the ALUControl is addition, sets C to Cout, otherwise C is 0
    C = (ALUControl == 00) ? Cout : 1'b0;
    // If the MSB is 1, the output is negative
    N = Y[7]; 
    // If the total output is 0, the zero status bit is 1
    Z = (Y == 8'b00000000);  
    // Calculates whether there is an overflow based on the ALUControl and MSB of the inputs
    V = (~ALUControl[1]) ? ((Y[7] ^ A[7]) & ~(ALUControl[0] ^ A[7] ^ B[7])) : 1'b0;
  end
  // End of the module
endmodule
    
