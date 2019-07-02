`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2019 12:52:46 AM
// Design Name: 
// Module Name: relay_clock_generator_tb
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


module relay_clock_generator_tb(

    );
    
    // Inputs to DUT
    reg reset;
    reg clk;
    
    // Outputs from DUT
    wire slow_clk;
    wire slower_clk;
    
    // Instantiate DUT
    relay_clock_generator rcg(
        .reset(reset),
        .clk(clk),
        .slow_clk(slow_clk),
        .slower_clk(slower_clk)
    );
    
    always begin
        #2.5 clk = ~clk;
    end
    
    
    initial begin
        
        // Initial state of signals
        reset <= 1;
        clk <= 0;
        
        repeat (10) @(posedge clk);
        reset <= 0;
        
    end
    
endmodule
