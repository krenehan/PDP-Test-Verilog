`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2019 05:48:38 PM
// Design Name: 
// Module Name: relay_shift_register
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


module relay_shift_register(
    input clk,
    input slow_clk,
    input slower_clk,
    input shift_start,
    input [31:0] shift_out_bits,
    output reg shift_done = 0,
    output reg clock_pin = 0,
    output reg data_pin = 0
    
//    output reg [31:0] shift_out,
//    output reg [31:0] shift_counter,
//    output reg [4:0] state = 0,
//    output reg [4:0] next_state,
//    output reg clk_latch,
//    output wire continue_shifting,
//    output reg capture_shift_out_bits,
//    output reg fine_counter
    );
    
    localparam  IDLE                        = 5'b00001,
                WAIT_FOR_DATA               = 5'b00010,
                CAPTURE_SHIFT_OUT_BITS      = 5'b00100,
                SHIFT_OUT                   = 5'b01000,
                DONE                        = 5'b10000;
    
    // 32 bit output register
    reg [31:0] shift_out;
    reg [31:0] shift_counter;
    reg [4:0] state = IDLE;
    reg [4:0] next_state;
    reg clk_latch;
    reg capture_shift_out_bits;
    reg fine_counter;
    
    // To determine if shifting should continue
    wire continue_shifting;
    assign continue_shifting = shift_counter[0];
    
    // Fine counter for incrementing every other cycle
    always @(posedge slow_clk) begin
        if (clk_latch) begin
            fine_counter = ~fine_counter;
        end else begin 
            fine_counter = 1'b0;
        end
    end
    
    // Advance state
    always @(posedge slow_clk) begin
        state <= next_state;
    end

    // Latch clock to clockPin if clk_latch is high
    always @(slower_clk) begin
        if (clk_latch) begin
            clock_pin = slower_clk;
        end else begin
            clock_pin = 0;
        end
    end
    
    // Shift out
    always @(posedge slow_clk) begin
        if (capture_shift_out_bits) begin
            shift_out[31:0] = shift_out_bits[31:0];
        end else if (clk_latch) begin
            if (fine_counter) begin
                shift_out[31:0] = {shift_out[30:0], 1'b0};
                shift_counter[31:0] = {1'b0, shift_counter[31:1]};
            end
        end else if (!shift_start) begin
            shift_out[31:0] = 0;
            shift_counter[31:0] = 32'hFFFFFFFF;
        end
    end
    
    // Handle datapin
    always @(slow_clk) begin
        if (clk_latch) begin
            if (~clock_pin) begin
                data_pin = shift_out[31];
            end
        end else begin
            data_pin = 0;
        end
    end
    
    
    // State logic
    always @(*) begin
        // Default to no movement
        next_state = IDLE;
        
        // State machine
        case (state)
            IDLE: begin
                if (!shift_start) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 1;
                    
                    // Next state
                    next_state = WAIT_FOR_DATA;
                end
            end
            
            WAIT_FOR_DATA: begin
                if (!shift_start) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = SHIFT_OUT;
                end
            end
            
            CAPTURE_SHIFT_OUT_BITS: begin
                if (!shift_start) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next_state 
                    next_state = IDLE;
                end else begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 1;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = SHIFT_OUT;
                end
            end
            
            
            SHIFT_OUT: begin
                if (!shift_start) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (continue_shifting) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 1;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = SHIFT_OUT;
                end else begin
                    // Outputs
                    shift_done <= 1;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = DONE;
                end
            end
            
            DONE: begin
                if (!shift_start) begin
                    // Outputs
                    shift_done <= 0;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else begin
                    // Outputs
                    shift_done <= 1;
                    clk_latch <= 0;
                    capture_shift_out_bits <= 0;
                    
                    // Next state
                    next_state = DONE;
                end
            end
        endcase
        
    
    end
        
    
endmodule
