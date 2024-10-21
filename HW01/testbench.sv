/* Name: Shyam Venkatesan */
/* Date: Aug-22-2024 */
/* Description: Example test bench for all state values and display a waveform and output on screen */

// Timescale in nanoseconds with error of 1 picosecond
`timescale 1ns/1ps
// Module to test the Bell 
module Bell_Test();
  // Registers headlight and ignition state to hold 0 or 1 values
  reg headlightState, ignitionState;
  // bellRing wire for output
  wire bellRing;
  
  // Design under test for bell with parameters
  Bell DUT(.headlightState(headlightState), .ignitionState(ignitionState),.bellRing(bellRing));
  		   // Start of DUT
           initial
             begin
               // Writes to dump file with first level of variables
               $dumpfile("dump.vcd");
               $dumpvars(1);
               
               // Result for binary 0,0 
               headlightState = 1'b0;
               ignitionState = 1'b0;
               // 10 nanosecond delay then display to log the values of each variable (repeated for next 3 cases)
               #10;
               $display("hState:%b,iState:%b,bRing:%b", headlightState, ignitionState, bellRing);
               
               // Result for binary 0,1
               headlightState = 1'b0;
               ignitionState = 1'b1;
               #10;
               $display("hState:%b,iState:%b,bRing:%b", headlightState, ignitionState, bellRing); 
               
               // Result for binary 1,0
               headlightState = 1'b1;
               ignitionState = 1'b0;
               #10;
               $display("hState:%b,iState:%b,bRing:%b", headlightState, ignitionState, bellRing); 
               
               // Result for binary 1,1
               headlightState = 1'b1;
               ignitionState = 1'b1;
               #10;
               $display("hState:%b,iState:%b,bRing:%b", headlightState, ignitionState, bellRing); 
               $finish;
             
             // End of DUT and module
             end
           endmodule
                     
                         
         
           
        