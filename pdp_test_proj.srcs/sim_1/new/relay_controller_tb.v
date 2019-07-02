`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2019 05:03:59 PM
// Design Name: 
// Module Name: relay_controller_tb
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


module relay_controller_tb(

    );
    
    // Internal registers
    reg clk;
    reg set_relay;
    reg clear_relay;
    reg [4:0] spad_number;
    
    // Wires
    wire latch_pin;
    wire clear_n_pin;
    wire enable_n_pin;
    wire relay_set;
    wire holding;
    wire clock_pin;
    wire data_pin;
    
    // Invert active low signals
    wire clear_pin;
    wire enable_pin;
    assign clear_pin = ~clear_n_pin;
    assign enable_pin = ~enable_n_pin;
    
    // Instantiate relay controller
    relay_controller relay_controller(
        .clk(clk),
        .set_relay(set_relay),
        .clear_relay(clear_relay),
        .spad_number(spad_number),
        .latch_pin(latch_pin),
        .clear_n_pin(clear_n_pin),
        .enable_n_pin(enable_n_pin),
        .relay_set(relay_set),
        .holding(holding),
        .clock_pin(clock_pin),
        .data_pin(data_pin)
    );
    
    // Clock
    always begin
        #2.5 clk = ~clk;
    end
    
    // Simulate
    initial begin
        
        // Initial state of signals
        clk <= 0;
        set_relay <= 0;
        clear_relay <= 0;
        spad_number[4:0] = 5'd5;
        
        // Set relay
        @(posedge clk);
        set_relay <= 1;
        
        // Wait for relay controller to return
        @(posedge relay_set);
        set_relay <= 0;
        
        // Let relay controller hold for a while
        repeat (5000) @(posedge clk);
        clear_relay <= 1;
        
        // Unset clear relay when holding goes low
        @(negedge holding);
        clear_relay <= 0;
        
        // Wait and finish
        repeat (5000) @(posedge clk);
        $finish;
        
    end
    
endmodule
