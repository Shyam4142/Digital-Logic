/* Name: Shyam Venkatesan */
/* Date: Oct-17-2024 */
/* Description: Design file to implement a BiPAP FSM that traverses between 4 different states (S0-S3) depending on the INHALE and EXHALE inputs. As a Moore FSM, current state determined output values for IPAPEN, EPAPEN, and the LED. */

// Timescale in 10 microseconds with error of 1 microsecond (10ms/1ms timestep)
`timescale 10ms/1ms

// Module for the BiPAP FSM functionality
module BiPAP(clock, reset, INHALE, EXHALE, IPAPEN, EPAPEN, LED);
  // 1 bit inputs
  input clock, reset, INHALE, EXHALE;
  
  // 1 bit outputs
  output IPAPEN, EPAPEN, LED;
  
  // State values S0-S1, stored as 2 bit binary numbers
  localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
  
  // 2 bit binary registers for the current and next state of FSM
  reg [1:0] currState, nextState;
  
  // Always statement that updates at the positive edge of clock (D flip-flop)
  always@(posedge clock) begin
    // Non-blockig assignment used inside always block with clock signal
    // If reset is 0, the currrent state reverts to S0
    if(reset) currState <= S0;
    // Otherwise, the current state is assigned the value of the next state 
    else currState <= nextState;
  // End of the always statement
  end
  
  // Output Assignment
  
  // If current state is S1, IPAPEN is assigned 1
  assign IPAPEN = (currState == S1);
  // If current state is S2, EPAPEN is assigned 1
  assign EPAPEN = (currState == S2);
  // If current state is S3, LED is assigned 1
  assign LED = (currState == S3);
  
  // Always statement that updates at the change of an input in the sensitivity list (INHALE or EXHALE)
  always@(*) begin
    // Uses blocking assignment because there's a sensitvity list 
    
    // Switch statement based on the current state
    case(currState)
      
      // Case that current state is S0 (waiting)
      S0 : begin
        // If no exhale and no inhale, next state is S0
        if(!EXHALE & !INHALE)
          nextState = S0;
        // If no exhale but inhale, next state is S1
        else if(!EXHALE & INHALE)
          nextState = S1;
        // If exhale but no inhale, next state is S2
        else if(EXHALE & !INHALE)
          nextState = S2;
        // If exhale and inhale, next state is S3
        else if(EXHALE & INHALE)
          nextState = S3;
      // End of case
      end
      
      // Case that current state is S1 (inhale)
      S1 : begin
       // If no exhale and no inhale, next state is S0
       if(!EXHALE & !INHALE)
          nextState = S0;
        // If no exhale but inhale, next state is S1
        else if(!EXHALE & INHALE)
          nextState = S1;
        // If exhale but no inhale, next state is S2
        else if(EXHALE & !INHALE)
          nextState = S2;
        // If exhale and inhale, next state is S3
        else if(EXHALE & INHALE)
          nextState = S3;
      // End of case
      end
      
      // Case that current state is S2 (exhale)
      S2 : begin
        // If no exhale and no inhale, next state is S0
        if(!EXHALE & !INHALE)
          nextState = S0;
        // If no exhale but inhale, next state is S1
        else if(!EXHALE & INHALE)
          nextState = S1;
        // If exhale but no inhale, next state is S2
        else if(EXHALE & !INHALE)
          nextState = S2;
        // If exhale and inhale, next state is S3
        else if(EXHALE & INHALE)
          nextState = S3;
      // End of case
      end
      
      // Case that current state is S3 (alert)
      S3 : begin
        // nextState will always be S3 because a malfunction can only be resolved by reset
        nextState = S3;
      // End of case
      end
    // End of switch statement
    endcase
  // End of always statement
  end
// End of module
endmodule
             

             
             
    
  
 
    
    	
  
