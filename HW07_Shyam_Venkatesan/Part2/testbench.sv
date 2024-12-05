/* Name: Alice Wang 								*/
/* Date: Jun-8-2024									*/
/* Description: HW#7 self-checking testbench for CPU */

module testCPU;

  reg clk,reset;
  wire [7:0] DMem;
  int errors;
  reg [7:0] DMem_expected[4:0];
  
  integer i, j;
  
  // Instantiate design under test
  top_CPU CPU0(.D_rd_data(DMem),
               .clk(clk),.reset(reset));
  
  always #5 clk = ~clk;

  initial begin
    // Dump waves
  	$dumpfile("dump.vcd");
    $dumpvars(2);

    $readmemb("Dmem_expected.tv", DMem_expected);
    i = 0;
    j = 0;
    clk = 1'b0;
    reset = 1'b1;
    $display("Reset");
    #26 reset = 1'b0;
  end
  
    
  // check results on falling edge of clk
  // the first 7 instructions are calculating the fibonacci sequence
  // When i > 7, then we read 5 results from the data memory 
  // compare it to our testvectors.
  // Once i > 12 then we print the number of errors
	
    always @(negedge clk) begin
      if (reset !== 1) begin
        if ((i > 7)&&(i <=12)) begin
          if (DMem !== DMem_expected[j]) begin  
            $display("Error: i=%0d, j=%0d, DMem=%0d, DMem_expected=%0d", i,j, DMem, DMem_expected[j]);
          	errors = errors + 1;
            j = j+1;
        	end
			else begin
          	$display("Correct: i=%0d, j=%0d, DMem=%0d, DMem_expected=%0d", i,j, DMem, DMem_expected[j]);
          	j = j+1;
            end
      	end
 
        else if (i > 12) begin
      	$display("# of Errors = %d", errors);
      	$finish;
    	end
  		i = i+1; 
      end
    end
  
  
endmodule
