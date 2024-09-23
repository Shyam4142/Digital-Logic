/* Name: Shyam Venkatesan */
/* Date: Aug-22-2024 */
/* Description: Verilog file for circuit that rings bell depending on headlight and ignition state */

// Module for the bell functionality
module Bell(headlightState, ignitionState, bellRing);
  // Headlight and ignition states are inputs
  input headlightState, ignitionState;
  
  // bellRing is output of wire type (assigned result of boolean operation)
  output bellRing;
  wire bellRing;
  
  // Assigns bellRing with the logical and of headlightState and not ignitionState to fulfill the condition
  assign bellRing = (headlightState & ~ignitionState);

// End of module
endmodule
  