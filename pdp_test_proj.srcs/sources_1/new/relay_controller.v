`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 08:58:25 PM
// Design Name: 
// Module Name: relay_controller
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


module relay_controller(
    input clk,
    input set_relay,
    input clear_relay,
    input [4:0] spad_number,
    output reg latch_pin,
    output reg clear_n_pin,
    output reg enable_n_pin,
    output reg relay_set,
    output reg holding,
    output clock_pin,
    output data_pin
    );
    
        
    // States
    localparam      IDLE             = 7'b0000001,
                    CONFIG          = 7'b0000010,
                    SHIFT           = 7'b0000100,
                    LATCH           = 7'b0001000,
                    RELAY_SET       = 7'b0010000,
                    HOLD            = 7'b0100000, 
                    CLEAR           = 7'b1000000;
    
    // Inputs synchronized to slow clock
    reg set_relay_sync = 0;
    reg clear_relay_sync = 0;
    
    // Internal signals
    reg shift_start;
    reg [31:0] shift_out_bits = 0;
    wire shift_done;
    wire slow_clk_unbuffered;
    wire slow_clk;
    wire slower_clk;
    
    // Registers for state machine
    reg [6:0] state = IDLE;
    reg [6:0] next_state;
    
    // Instantiate relay_clock_generator
    relay_clock_generator_no_reset relay_clock_generator(
        .clk(clk),
        .slow_clk(slow_clk),
        .slower_clk(slower_clk)
    );
    
    // Instantiate the shift register
    relay_shift_register relay_shift_register(
        .clk(clk),
        .slow_clk(slow_clk),
        .slower_clk(slower_clk),
        .shift_start(shift_start),
        .shift_out_bits(shift_out_bits),
        .shift_done(shift_done),
        .clock_pin(clock_pin),
        .data_pin(data_pin)
    );
                    
    // SPAD number from binary to thermometer encoding
    always @(posedge set_relay) begin
        // Zero out the shift bits
        shift_out_bits[31:0] <= 0;
    
        case(spad_number)
            5'b00000: shift_out_bits[0] <= 1'b1;
            5'b00001: shift_out_bits[1] <= 1'b1;
            5'b00010: shift_out_bits[2] <= 1'b1;
            5'b00011: shift_out_bits[3] <= 1'b1;
            5'b00100: shift_out_bits[4] <= 1'b1;
            5'b00101: shift_out_bits[5] <= 1'b1;
            5'b00110: shift_out_bits[6] <= 1'b1;
            5'b00111: shift_out_bits[7] <= 1'b1;
            5'b01000: shift_out_bits[8] <= 1'b1;
            5'b01001: shift_out_bits[9] <= 1'b1;
            5'b01010: shift_out_bits[10] <= 1'b1;
            5'b01011: shift_out_bits[11] <= 1'b1;
            5'b01100: shift_out_bits[12] <= 1'b1;
            5'b01101: shift_out_bits[13] <= 1'b1;
            5'b01110: shift_out_bits[14] <= 1'b1;
            5'b01111: shift_out_bits[15] <= 1'b1;
            5'b10000: shift_out_bits[16] <= 1'b1;
            5'b10001: shift_out_bits[17] <= 1'b1;
            5'b10010: shift_out_bits[18] <= 1'b1;
            5'b10011: shift_out_bits[19] <= 1'b1;
            5'b10100: shift_out_bits[20] <= 1'b1;
            5'b10101: shift_out_bits[21] <= 1'b1;
            5'b10110: shift_out_bits[22] <= 1'b1;
            5'b10111: shift_out_bits[23] <= 1'b1;
            5'b11000: shift_out_bits[24] <= 1'b1;
            5'b11001: shift_out_bits[25] <= 1'b1;
            5'b11010: shift_out_bits[26] <= 1'b1;
            5'b11011: shift_out_bits[27] <= 1'b1;
            5'b11100: shift_out_bits[28] <= 1'b1;
            5'b11101: shift_out_bits[29] <= 1'b1;
            5'b11110: shift_out_bits[30] <= 1'b1;
            5'b11111: shift_out_bits[31] <= 1'b1;
        endcase
    end
    
    // Make set_relay and clear_relay compatible across clock domains
    always @(posedge slow_clk) begin
        set_relay_sync <= set_relay;
        clear_relay_sync <= clear_relay;
    end
    
    // Advance state machine based on slow_clk
    always @(posedge slow_clk) begin
        state <= next_state;
    end
    
    // State machine
    always @(*) begin
        // Default to no movement
        next_state = IDLE;
        
        case (state)
        
            IDLE: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 0;
                enable_n_pin <= 1;
                relay_set <= 0;
                holding <= 0;
                shift_start <= 0;
                
                // Next state
                if (!set_relay_sync) begin
                    next_state = IDLE;
                end else begin
                    next_state = CONFIG;
                end
            end
            
            CONFIG: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 1;
                enable_n_pin <= 0;
                relay_set <= 0;
                holding <= 0;
                shift_start <= 0;
                
                // Next state
                if (!set_relay_sync) begin
                    next_state = IDLE;
                end else begin
                    next_state = SHIFT;
                end
            end
            
            SHIFT: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 1;
                enable_n_pin <= 0;
                relay_set <= 0;
                holding <= 0;
                shift_start <= 1;
                
                // Next state
                if (!set_relay_sync) begin
                    next_state = IDLE;
                end else if (shift_done) begin
                    next_state = LATCH;
                end else begin
                    next_state = SHIFT;
                end
            end
            
            LATCH: begin
                // Outputs
                latch_pin <= 1;
                clear_n_pin <= 1;
                enable_n_pin <= 0;
                relay_set <= 0;
                holding <= 0;
                shift_start <= 0;
                
                // Next state
                if (!set_relay_sync) begin
                    next_state = IDLE;
                end else begin
                    next_state = RELAY_SET;
                end
            end
            
            RELAY_SET: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 1;
                enable_n_pin <= 0;
                relay_set <= 1;
                holding <= 1;
                shift_start <= 0;
                
                // Next state
                if (set_relay_sync) begin
                    next_state = RELAY_SET;
                end else if (clear_relay_sync) begin
                    next_state = CLEAR;
                end else begin
                    next_state = HOLD;
                end
            end
            
            HOLD: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 1;
                enable_n_pin <= 0;
                relay_set <= 0;
                holding <= 1;
                shift_start <= 0;
                
                // Next state
                if (clear_relay_sync) begin
                    next_state = CLEAR;
                end else begin
                    next_state = HOLD;
                end
            end
            
            CLEAR: begin
                // Outputs
                latch_pin <= 0;
                clear_n_pin <= 0;
                enable_n_pin <= 0;
                relay_set <= 0;
                holding <= 1;
                shift_start <= 0;
                
                // Next state
                next_state = IDLE;
            end
        
        endcase
    end
    
    
    
endmodule
