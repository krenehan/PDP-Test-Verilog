`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 01:56:54 AM
// Design Name: 
// Module Name: relay_shift_register_tb
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


module relay_shift_register_tb(

    );
    
    // Internal registers
    reg clk;
    reg shift_start;
    reg [31:0] shift_out_bits;
    
    // Outputs of DUT
    wire shift_done;
    wire data_pin;
    wire clock_pin;
    wire slow_clk;
    wire slower_clk;
    wire fine_counter;
    
    // Optional wires
    wire [31:0] shift_out;
    wire [31:0] shift_counter;
    wire [4:0] state;
    wire [4:0] next_state;
    wire clk_latch;
    wire continue_shifting;
    wire capture_shift_out_bits;
    
    // Generate the slow clock
    relay_clock_generator_no_reset rcg(
        .clk(clk),
        .slow_clk(slow_clk),
        .slower_clk(slower_clk)
    );
    
    // Instantiate DUT
    relay_shift_register rsr(
        .clk(clk),
        .slow_clk(slow_clk),
        .slower_clk(slower_clk),
        .shift_start(shift_start),
        .shift_out_bits(shift_out_bits),
        .shift_done(shift_done),
        .data_pin(data_pin),
        .clock_pin(clock_pin)
        
//        // Optional
//        .shift_out(shift_out),
//        .shift_counter(shift_counter),
//        .state(state),
//        .next_state(next_state),
//        .clk_latch(clk_latch),
//        .continue_shifting(continue_shifting),
//        .capture_shift_out_bits(capture_shift_out_bits),
//        .fine_counter(fine_counter)
    );
    
    // Clock
    always begin
        #2.5 clk = ~clk;
    end
   
    
    initial begin
        
        // Initial register states
        clk <= 0;
        shift_start <= 0;
        shift_out_bits <= 32'b10101010101010101000000000000000;
        
        // Start the shift process
        repeat (5) @(posedge slower_clk);
        repeat (25) @(posedge clk);
        $display($time, "<< Initiate shifting >>");
        shift_start <= 1;
        
        // Wait for process to return
        @(posedge shift_done);
        repeat (2) @(posedge slower_clk);
        shift_start <= 0;
        $display($time, "<< Process done >>");
        $finish;
        
    end
endmodule
