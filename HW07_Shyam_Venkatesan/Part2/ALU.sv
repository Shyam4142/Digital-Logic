/* Name: Alice Wang 								*/
/* Date: Jun-8-2024									*/
/* Description: HW#6 4-function ALU	with Status Bits*/

module ALU(Result, N,Z,C,V,A,B, ALUcontrol);
  input [7:0] A,B;
  input [1:0] ALUcontrol;
  output [7:0] Result;
  output N,Z,C,V;
  
  wire [7:0] R0,muxout,sum;
  wire [7:0] cout;
  
  // Instantiating one 8-bit adder
  RippleAdder8b R8b(.sum(sum),.cout(cout),.a(A),.b(muxout),.cin(ALUcontrol[0]));
  
  // 2:1 mux to select B or not B
  assign muxout = ALUcontrol[0] ? ~B : B;
  
  // 4:1 mux to select ALU outputs
  assign R0 = ALUcontrol[0] ? A|B : A&B;
  assign Result = ALUcontrol[1] ? R0 : sum;
  
  // Status outputs
  assign N = Result[7];
  assign Z = ~|Result;
  assign C = ALUcontrol[1] & cout[7];
  assign V = ALUcontrol[1] & (cout[7] ^ cout[6]);
  
endmodule
  
  
module RippleAdder8b(sum,cout,a,b,cin);
  input [7:0] a,b;
  input cin;
  output [7:0] sum;
  output [7:0] cout;
    
  // Instantiating 8 1-bit full adders
  full_adder FA0(.sum(sum[0]), .cout(cout[0]), .a(a[0]), .b(b[0]), .cin(cin));  
  full_adder FA1(.sum(sum[1]), .cout(cout[1]), .a(a[1]), .b(b[1]), .cin(cout[0]));   
  full_adder FA2(.sum(sum[2]), .cout(cout[2]), .a(a[2]), .b(b[2]), .cin(cout[1]));
  full_adder FA3(.sum(sum[3]), .cout(cout[3]), .a(a[3]), .b(b[3]), .cin(cout[2]));
  full_adder FA4(.sum(sum[4]), .cout(cout[4]), .a(a[4]), .b(b[4]), .cin(cout[3]));  
  full_adder FA5(.sum(sum[5]), .cout(cout[5]), .a(a[5]), .b(b[5]), .cin(cout[4]));   
  full_adder FA6(.sum(sum[6]), .cout(cout[6]), .a(a[6]), .b(b[6]), .cin(cout[5]));
  full_adder FA7(.sum(sum[7]), .cout(cout[7]), .a(a[7]), .b(b[7]), .cin(cout[6]));
  
endmodule


module full_adder (sum, cout, a, b, cin);
  	input      a, b, cin;
  	output     sum, cout;
  
	wire w1, w2, w3;

    // Instantiating 2 1-bit half adders to make 1 1-bit full adder
  	half_adder ha1(w1, w2, a, b);
	half_adder ha2(sum, w3, w1, cin);

	assign cout = w2 || w3;
	
endmodule

module half_adder(s, c, a, b);
	output s, c;
	input a, b;

  	// sum is a XOR b and carry is a AND b
	assign s = a ^ b;
	assign c = a & b;
  
endmodule
