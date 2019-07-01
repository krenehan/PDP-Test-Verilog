`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 11:52:53 AM
// Design Name: 
// Module Name: decoder_fast_32b
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


module decoder_fast_32b(
    input clk,
    input decoder_read,
    input valid,
    input empty,
    input [31:0] din,
    output reg [4:0] spad_number,
    output reg rd_en = 0,
    output reg packet_read
    );
    
    // States
    localparam  IDLE                        = 6'b000001,
                FIRST_READ_ATTEMPTED        = 6'b000010,
                FIRST_READ_RETRY            = 6'b000100,
                EMPTY_FIFO                  = 6'b001000,
                DONE                        = 6'b010000,
                WAIT_FOR_ACK                = 6'b100000;
    
    // State
    reg [6:0] state = IDLE;
    reg [6:0] next_state = IDLE;
    reg [31:0] full_packet = 0;
    
    // This logic was implemented to deal with synchronization delay.
    // This delay causes problems when trying to empty the FIFO.
    reg empty_fifo_flag = 0;
    reg reset_empty_fifo_flag = 0;
    reg [2:0] packet_counter = 3'd3;
    
    // Handle reset, advance state
    always @(posedge clk) begin
        state <= next_state;
        spad_number[4:0] <= full_packet[4:0];
    end
    
    // Counting packets received during empty cycle
    always @(negedge clk) begin
        if (empty_fifo_flag) begin
            packet_counter = packet_counter - 1;
        end else if (reset_empty_fifo_flag) begin
            packet_counter[2:0] = 3'd3;
        end
    end
    
    // State machine
    always @(*) begin
        // Default to no movement
        next_state = state;
        
        // States
        case (state)
            IDLE: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = IDLE;
                end else begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = FIRST_READ_ATTEMPTED;
                end
            end
            
            FIRST_READ_ATTEMPTED: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = FIRST_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[31:0] <= din[31:0];
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = EMPTY_FIFO;
                end
            end
            
            FIRST_READ_RETRY: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = FIRST_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[31:0] <= din[31:0];
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = EMPTY_FIFO;
                end
            end
            
            EMPTY_FIFO: begin
                if (packet_counter[2:0] == 3'b0) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = DONE;
                    
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = EMPTY_FIFO;
                end else begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Flags
                    empty_fifo_flag <= 1;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = EMPTY_FIFO;
                end
            end
            
            
            
            DONE: begin
                if (decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 1;
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = WAIT_FOR_ACK;
                end else begin
                    // Outputs 
                    rd_en <= 0;
                    packet_read <= 0;
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
            
            WAIT_FOR_ACK: begin
                if (decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 1;
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 0;
                    
                    // Next state
                    next_state = WAIT_FOR_ACK;
                end else begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    empty_fifo_flag <= 0;
                    reset_empty_fifo_flag <= 1;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
        endcase
    end
    
    
    
endmodule
