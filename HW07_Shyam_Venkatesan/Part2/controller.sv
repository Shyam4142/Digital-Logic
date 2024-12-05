/* Name: Shyam Venkatesan */
/* Date: Nov-27-2024 */
/* Description: CPU controller file that decodes mux selections, ALU control, and write enable states from the 3 MSB of the instruction*/

// Controller module
module controller(Instruction, RF_W_we, ALUcontrol, DMEM_we, Mux_select_M0, Mux_select_M1);
  // 3 bit input register of the 3 MSB of the Instruction
  input reg [11:9] Instruction;
  // 2 bit output register for ALU control
  output reg [1:0] ALUcontrol;
  // 1 bit output registers for write enable states and mux selections
  output reg RF_W_we, DMEM_we, Mux_select_M0, Mux_select_M1;
  
  // Executes on change to sensitivty list
  always @(*) begin
    // Switch statement based on instruction value
    case(Instruction)
      // Case 000 : LD
      3'b000 : begin
        ALUcontrol = 2'b00; // ALU control is add (but not used)
        RF_W_we = 1'b1; // Register write enabled
        DMEM_we = 1'b0; // Memory write disabled
        Mux_select_M0 = 1'b1; // M0 select bit is 1 (from memory)
        Mux_select_M1 = 1'b0; // M1 select bit is 0 (load)
      end
      // Case 001 : ST
      3'b001 : begin
        ALUcontrol = 2'b00; // ALU control is add (but not used)
        RF_W_we = 1'b0; // Register write disables
        DMEM_we = 1'b1; // Memory write enabled
        Mux_select_M0 = 1'b0; // M0 select bit is 0 (doesn't matter)
        Mux_select_M1 = 1'b1; // M1 select bit is 1 (store)
      end
      // Case 010 : ADD
      3'b010 : begin
        ALUcontrol = 2'b00; // ALU control is 00 (ADD)
        RF_W_we = 1'b1; // Register write enabled
        DMEM_we = 1'b0; // Memory write disabled
        Mux_select_M0 = 1'b0; // M0 select bit is 0 (from ALU)
        Mux_select_M1 = 1'b0; // M1 select bit is 0 (doesn't matter)
      end
      // Case 011 : SUB
      3'b011 : begin
        ALUcontrol = 2'b01; // ALU control is 01 (SUB)
        RF_W_we = 1'b1; // Register write enabled
        DMEM_we = 1'b0; // Memory write disabled
        Mux_select_M0 = 1'b0; // M0 select bit is 0 (from ALU)
        Mux_select_M1 = 1'b0; // M1 select bit is 0 (doesn't matter)
      end
      // Case 100 : ADD
      3'b100 : begin
        ALUcontrol = 2'b10; // ALU control is 10 (AND)
        RF_W_we = 1'b1; // Register write enabled
        DMEM_we = 1'b0; // Memory write disabled
        Mux_select_M0 = 1'b0; // M0 select bit is 0 (from ALU)
        Mux_select_M1 = 1'b0; // M1 select bit is 0 (doesn't matter)
      end
      // Case 101 : OR
      3'b101 : begin
        ALUcontrol = 2'b11; // ALU control is 11 (OR)
        RF_W_we = 1'b1; // Register write enabled
        DMEM_we = 1'b0; // Memory write disabled
        Mux_select_M0 = 1'b0; // M0 select bit is 0 (from ALU)
        Mux_select_M1 = 1'b0; // M1 select bit is 0 (doesn't matter)
      end
      // End of the switch statement
    endcase
  end
  // End of the module
endmodule