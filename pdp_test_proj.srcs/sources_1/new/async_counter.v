`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Columbia University
// Engineer: Kevin Renehan
// 
// Create Date: 04/20/2019 12:34:20 AM
// Design Name: Asynchronous Counter
// Module Name: async_counter
// Project Name: PDP Test
// Target Devices: XEM7360
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


module async_counter(
    input clear,
    input enable,
    input spad_signal,
    output reg [15:0] avalanche_count = 0
    );
    
    always @(posedge spad_signal or posedge clear) begin
        if (clear) begin
            avalanche_count <= 0;
        end else if (enable) begin
            avalanche_count = avalanche_count + 1;
        end
    end
    
endmodule
