`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2019 04:09:36 PM
// Design Name: 
// Module Name: relay_clock_generator_decimated
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


module relay_clock_generator_decimated(
    input clk,
    output slow_clk
    );
    
    // Internal registers
    reg [14:0] counter = 15'b0;
    
    // Unbuffered fabric slow clock
    reg slow_clk_reg;
    
    // Global clock routing buffer
    BUFG slow_clk_bufg(
        .I(slow_clk_reg),
        .O(slow_clk)
    );
    
    // Increment counter
    always @(posedge clk) begin
        counter = counter + 1;
    end
    
    // Tie slow_clk to top value of counter
    always @(posedge clk) begin
        if (counter == 15'b111111111111111) begin
            slow_clk_reg <= 1'b1;
        end else begin
            slow_clk_reg <= 1'b0;
        end
    end
endmodule
