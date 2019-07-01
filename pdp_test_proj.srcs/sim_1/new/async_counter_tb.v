`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 01:37:21 AM
// Design Name: 
// Module Name: async_counter_tb
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


module async_counter_tb(

    );
    
    // Registers for driving inputs
    reg reset_in;
    reg enable_in;
    reg spad_signal_in;
    
    // Wires for outputs
    wire [15:0] count;
    
    // Instantiate DUT
    async_counter counter_1 (
        .reset(reset_in),
        .enable(enable_in),
        .spad_signal(spad_signal_in),
        .out(count)
        );
    
    initial begin
        // Reset
        $display($time, "<< Starting the Simulation >>");
        spad_signal_in = 1'b0; // Spad signal is low
        enable_in = 1'b0; // Enable signal is low
        reset_in = 1'b1; // Reset signal is high
        #20 reset_in = 1'b0; // Reset signal flips at 20 ns
        $display($time, "<< Reset signal is low >>");
        
        // SPAD signal firing, should be no counting
        spad_pulses(10);
        
        // Report count
        $display($time, "<< Count with reset low, enable low: %d >>", count);
        
        // Enable
        enable_in = 1'b1;
        $display($time, "<< Enable signal is high >>");
        #20;
        
        // SPAD signal firing, should count
        spad_pulses(10);
        
        // Report count
        $display($time, "<< Count with reset low, enable high: %d >>", count);
        
        // Drive enable low
        enable_in = 1'b0;
        #20;
        $display($time, "<< Enable signal is low >>");
        
        // SPAD signal firing, should not count
        spad_pulses(10);
        $display($time, "<< Count with reset low, enable low: %d >>", count);
        
        // Reset driven high
        reset_in = 1'b1;
        #20;
        $display($time, "<< Reset signal is high >>");
        
        // SPAD pulses, should not count
        spad_pulses(10);
        $display($time, "<< Count with reset high, enable high: %d >>", count);
        
        // Drive enable low
        enable_in = 1'b0;
        #20;
        $display($time, "<< Enable signal is low >>");
        
        // SPAD pulses, should not count
        spad_pulses(10);
        $display($time, "<< Count with reset high, enable low: %d >>", count);
        
        // End simulation
        $display($time, "<< Simulation end. >>");
        
    end
    
    task spad_pulses;
        input integer iters;
        integer x;
        begin
            for (x=0; x < iters; x=x+1)
            begin
                spad_signal_in = 1'b1;
                #40;
                spad_signal_in = 1'b0;
                #20;
            end
        end
    endtask
    
endmodule
