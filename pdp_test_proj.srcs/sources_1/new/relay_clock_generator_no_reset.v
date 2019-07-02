`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2019 06:16:42 PM
// Design Name: 
// Module Name: relay_clock_generator_no_reset
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module relay_clock_generator_no_reset(
    input clk,
    output reg slow_clk,
    output reg slower_clk
    );
    
    // Internal registers
    reg [14:0] counter = 0;
    
    // Increment counter
    always @(posedge clk) begin
        counter = counter + 1;
    end
    
    // Tie slow_clk to MSB counter
    always @(*) begin
        if (counter[13]) begin
            slow_clk <= 1'b1;
        end else begin
            slow_clk <= 1'b0;
        end
        
        if (counter[14]) begin
            slower_clk <= 1'b1;
        end else begin
            slower_clk <= 1'b0;
        end
    end
    
endmodule
