/* Name: Alice Wang 								*/
/* Date: Jun-8-2024									*/
/* Description: HW#7 memory  						*/


// 64 x 8-bit memory module with one read and one write port
module dmem(clk, we, addr, wr_data, rd_data);
  input  clk;
  input  we;  				// writeenable
  input  [5:0]  addr;		// address
  input [7:0] wr_data;			// write port
  output [7:0] rd_data;		// read port
  
  reg  [7:0] RAM[63:0];			// Memory Array

  assign rd_data = RAM[addr];	// Read from address addr

  always @(posedge clk) begin
    if (we)
      RAM[addr] <= wr_data;		// Write to address addr the value
  end							// on the write data port when we = 1

  // Initialize the memory module
  initial begin
    RAM[0] = 8'h01;
    RAM[1] = 8'h01;
  end
  
endmodule							

module imem(addr,rd_data);
  input  [3:0]  addr;		// address
  output [11:0] rd_data;		// read port
  
  reg  [11:0] RAM[15:0];			// Memory Array

  assign rd_data = RAM[addr];	// Read from address addr

  // Initialize the memory module
  initial begin
    RAM[0] = 12'b000_000_000000;	// LD R[0], DMem[0]
    RAM[1] = 12'b000_001_000001;	// LD R[1], DMem[1]
    RAM[2] = 12'b010_010_000001;	// ADD R[2], R[0], R[1]
    RAM[3] = 12'b010_011_001010;	// ADD R[3], R[1], R[2]
    RAM[4] = 12'b010_100_010011;	// ADD R[4], R[2], R[3]
    RAM[5] = 12'b001_000010_010;	// ST R[2], DMem[2]
    RAM[6] = 12'b001_000011_011;	// ST R[3], DMem[3]
    RAM[7] = 12'b001_000100_100;	// ST R[4], DMem[4]
    RAM[8] = 12'b000_000_000000;	// LD [R0], DMem[0]
    RAM[9] = 12'b000_000_000001;	// LD [R0], DMem[1]
    RAM[10] = 12'b000_000_000010;	// LD [R0], DMem[2]
    RAM[11] = 12'b000_000_000011;	// LD [R0], DMem[3]
    RAM[12] = 12'b000_000_000100;	// LD [R0], DMem[4]
  end
  
endmodule