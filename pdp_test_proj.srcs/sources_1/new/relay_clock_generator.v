`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2019 12:37:10 AM
// Design Name: 
// Module Name: relay_clock_generator
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


module relay_clock_generator(
    input clk,
    input reset,
    output reg slow_clk
    );
    
    // Internal registers
    reg [14:0] counter;
    
    // Increment counter
    always @(posedge clk) begin
        if (reset) begin
            counter <= 1'b0;
        end else begin
            counter = counter + 1;
        end
    end
    
    // Tie slow_clk to MSB counter
    always @(*) begin
        if (!reset) begin
            if (counter[14]) begin
                slow_clk <= 1'b1;
            end else begin
                slow_clk <= 1'b0;
            end
        end else begin
            slow_clk <= 1'b0;
        end
    end
    
    
    
endmodule
