/* Name: Alice Wang 								*/
/* Date: Oct-22-2024								*/
/* Description: HW#7 Parameterized 2:1 mux			*/

module Mux2x1 #(parameter N=8)
  (in1,in0,sel,out);
  input  [N-1:0] in1,in0;
  input sel;
  output [N-1:0] out;
  
  assign out = sel ? in1:in0;		// Select between in1 and in0
  
endmodule

