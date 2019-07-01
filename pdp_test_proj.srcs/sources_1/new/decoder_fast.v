`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2019 11:52:53 AM
// Design Name: 
// Module Name: decoder_fast
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


module decoder_fast(
    input clk,
    input reset,
    input decoder_read,
    input valid,
    input empty,
    input [15:0] din,
    output reg [4:0] spad_number,
    output reg rd_en,
    output reg packet_read
    );
    
    // States
    localparam  IDLE = 0,
                FIRST_READ_ATTEMPTED = 1,
                FIRST_READ_RETRY = 2,
                SECOND_READ_ATTEMPTED = 3,
                SECOND_READ_RETRY = 4,
                DONE = 5,
                WAIT_FOR_ACK = 6;
    
    // State
    reg [2:0] state;
    reg [2:0] next_state;
    reg [31:0] full_packet;
    
    // Handle reset, advance state
    always @(posedge clk) begin
        if (reset) begin
            full_packet <= 32'b0;
            state <= IDLE;
            next_state <= IDLE;
            spad_number <= 5'b0;
            rd_en <= 0;
            packet_read <= 0;
        end else begin
            state = next_state;
        end
    end
    
    // Updating SPAD number
    always @(posedge clk) begin
        if (!reset) begin
            spad_number[4:0] <= full_packet[4:0];
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
                    
                    // Next state
                    next_state = IDLE;
                end else begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = FIRST_READ_ATTEMPTED;
                end
            end
            
            FIRST_READ_ATTEMPTED: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = FIRST_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[31:16] <= din[15:0];
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = SECOND_READ_ATTEMPTED;
                end
            end
            
            FIRST_READ_RETRY: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = FIRST_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[31:16] <= din[15:0];
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = SECOND_READ_ATTEMPTED;
                end
            end
            
            SECOND_READ_ATTEMPTED: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = SECOND_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[15:0] <= din[15:0];
                    rd_en <= 0;
                    packet_read <= 1;
                    
                    // Next state
                    next_state = DONE;
                end
            end
            
            SECOND_READ_RETRY: begin
                if (!decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (!valid) begin
                    // Outputs
                    rd_en <= 1;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = SECOND_READ_RETRY;
                end else begin
                    // Outputs
                    full_packet[15:0] <= din[15:0];
                    rd_en <= 0;
                    packet_read <= 1;

                    
                    // Next state
                    next_state = DONE;
                end
            end
            
            DONE: begin
                if (decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 1;
                    
                    // Next state
                    next_state = WAIT_FOR_ACK;
                end else begin
                    // Outputs 
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
            
            WAIT_FOR_ACK: begin
                if (decoder_read) begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 1;
                    
                    // Next state
                    next_state = WAIT_FOR_ACK;
                end else begin
                    // Outputs
                    rd_en <= 0;
                    packet_read <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
        endcase
    end
    
    
    
endmodule
