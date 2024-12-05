/* Name: CoPilot */
/* Date: Oct-12-2024 */
/* Generative AI created register file */

module register_file (
    input wire clk,
    input wire reset,
    input wire [2:0] R1_addr,
    output reg [7:0] R1_data,
    input wire [2:0] R2_addr,
    output reg [7:0] R2_data,
    input wire [2:0] W_addr,
    input wire [7:0] W_data,
    input wire W_we
);
    // Define the register file
    reg [7:0] rf [7:0];

    // Read ports
    always @(*) begin
        R1_data = rf[R1_addr];
        R2_data = rf[R2_addr];
    end

    // Write port
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all registers to 0
            integer i;
            for (i = 0; i < 8; i = i + 1) begin
                rf[i] <= 8'b0;
            end
        end else if (W_we) begin
            rf[W_addr] <= W_data;
        end
    end
endmodule
