`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2019 01:01:01 AM
// Design Name: 
// Module Name: debouncer
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


module debouncer #(parameter COUNTER_WIDTH=7) (
    // Optional
//    output reg [COUNTER_WIDTH-1:0] count,
//    output reg counter_full,
//    output counter_enable,
    
    input clk,
    input reset,
    input enable,
    input in,
    output out
    );
    
    localparam COUNTER_MAX = 2**COUNTER_WIDTH-1;
    
    // Internal signals
    wire flop1_out;
    wire flop2_out;
    
    // Counter register
    reg [COUNTER_WIDTH-1:0] count;
    
    // Comparison register
    reg counter_full;
    
    // Enable signals for counter
    wire counter_enable;
    assign counter_enable = enable ? ~counter_full : 1'b0;
    
    // Input flops
    FDRE inputflop1(
        .Q(flop1_out),
        .C(clk),
        .R(reset),
        .CE(enable),
        .D(in)
    );
    
    FDRE inputflop2(
        .Q(flop2_out),
        .C(clk),
        .R(reset),
        .CE(enable),
        .D(flop1_out)
    );
    
    // Output flop
    FDRE outputflop(
        .Q(out),
        .C(clk),
        .R(reset),
        .CE(counter_full),
        .D(flop2_out)
    );
    
    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count = 0;
        end else if (flop1_out ^ flop2_out) begin
            if (enable) begin
                count = 0;
            end
        end else begin
            if (counter_enable) begin
                count = count + 1;
            end
        end
    end
    
    // Indicate when counter is full
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter_full <= 0;
        end else begin
            if (count == (COUNTER_MAX)) begin
                counter_full <= 1;
            end else begin
                counter_full <= 0;
            end
        end
    end
    
    
    
    
endmodule
