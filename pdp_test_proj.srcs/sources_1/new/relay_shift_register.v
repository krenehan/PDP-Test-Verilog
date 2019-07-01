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
    input shift_start,
    input [31:0] shift_out_bits,
    output reg shift_done = 0,
    output reg clock_pin = 0,
    output reg data_pin = 0,
    
    output reg [31:0] shift_out,
    output reg [31:0] shift_counter,
    output reg [3:0] state,
    output reg [3:0] next_state,
    output reg clk_latch,
    output wire continue_shifting,
    output reg capture_shift_out_bits
    );
    
    localparam  IDLE                        = 4'b0001,
                CAPTURE_SHIFT_OUT_BITS      = 4'b0010,
                SHIFT_OUT                   = 4'b0100,
                DONE                        = 4'b1000;
    
    // 32 bit output register
    //reg [31:0] shift_out;
    //reg [31:0] shift_counter;
    //reg [3:0] state = IDLE;
    //reg [3:0] next_state;
    //reg clk_latch;
    
    // To determine if shifting should continue
    //wire continue_shifting;
    assign continue_shifting = shift_counter[0];
    
    // For handling shift out
    //reg capture_shift_out_bits;
    
    // Advance state
    always @(posedge slow_clk) begin
        state <= next_state;
    end

    // Latch clock to clockPin if clk_latch is high
    always @(slow_clk) begin
        if (clk_latch) begin
            clock_pin = slow_clk;
        end else begin
            clock_pin = 0;
        end
    end
    
    // Shift out
    always @(posedge slow_clk) begin       
        if (capture_shift_out_bits) begin
            shift_out[31:0] = shift_out_bits[31:0];
        end else if (clk_latch) begin
            data_pin = shift_out[31];
            shift_out[31:0] = {shift_out[30:0], 1'b0};
            shift_counter[31:0] = {1'b0, shift_counter[31:1]};
        end else begin
            data_pin = 0;
            shift_out[31:0] = 0;
            shift_counter[31:0] = 32'hFFFFFFFF;
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
                    next_state = CAPTURE_SHIFT_OUT_BITS;
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
