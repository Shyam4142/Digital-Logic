/* Name: Shyam Venkatesan */
/* Date: Oct-17-2024 */
/* Description: Testbench to test the BiPAP FSM in 3 different cases: 12 BPS breathing, taking off BiPAP, and malfunctioning BiPAP. Specific inputs are used to simulate these scenarios and the outputs are given through a dumpfile with the 3 waveforms.*/

// Timescale in 10 microseconds with error of 1 microsecond (10ms/1ms timestep)
`timescale 10ms/1ms

// Module to test the BiPAP FSM
module BiPAP_Test();
  // 1 bit input registers
  reg clock, reset, INHALE, EXHALE;
  
  // 1 bit output wires
  wire IPAPEN, EPAPEN, LED;
  
  // Design under test for BiPAP with parameters
  BiPAP DUT(.clock(clock), .reset(reset), .INHALE(INHALE), .EXHALE(EXHALE), .IPAPEN(IPAPEN), .EPAPEN(EPAPEN), .LED(LED));
  
  // Start of the DUT
  initial 
    begin
      
    // Writes to dump file with first level of variables 
    $dumpfile("dump.vcd");
    $dumpvars(1);
      
    // Initial clock set to 0
    clock = 1'b0;
    // Initial input values set to 0
    INHALE = 1'b0;
    EXHALE = 1'b0;
    // Initial reset value set to 1 (resets registers)
    reset = 1'b1;
    // 1000ms wait time
    #100;
    // Reset value set to 0 to disable it for normal function
    reset = 1'b0;
      
    // First waveform of a person breathing at 12 BPM
    // Repeats 12 times (12 breaths/minute)
    repeat(12)
      begin
        // INHALE set to 1 and EXHALE set to 0 (Triggers inhale state)
      	INHALE = 1'b1; EXHALE = 1'b0; 
        // Values maintained for 2500 ms (half of a breathing cycle)
        #250;
        // INHALE set to 0 and EXHALE set to 1 (Triggers exhale state)
      	INHALE = 1'b0; EXHALE = 1'b1; 
        // Values maintained for 2500 ms (half of a breathing cycle)
        #250;
      end
    
      // Second waveform of a person who took off their BiPAP
      // INHALE set to 0 and EXHALE set to 0 (Triggers waiting state)
      INHALE = 1'b0; EXHALE = 1'b0; 
      // Values maintained for 3000ms
      #3000;
    
      // Third waveform of a malfunctioning BiPAP machine
      // INHALE set to 1 and EXHALE set to 1 (Triggers alert state)
      INHALE = 1'b1; EXHALE = 1'b1; 
      // Values maintained for 3000ms
      #3000;
    
     // Finish statement called to exit the simulation
    $finish;
  // End of the DUT
  end
  // Always statement that sets the positive and negative halves of the clock to 50 ms
  // Total period is 100ms
  always #5 clock = ~clock;
// End of the module
endmodule
