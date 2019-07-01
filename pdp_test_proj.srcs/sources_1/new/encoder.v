`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 08:20:52 PM
// Design Name: 
// Module Name: encoder
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


module encoder(
    input reset,
    input clk,
    input [15:0] avalanche_count,
    input [4:0] spad_number,
    input full,
    input encoder_write,
    input wr_ack,
    output reg wr_en,
    output reg [15:0] packet,
    output reg packet_written
    );
    
    // States
    localparam  IDLE = 0,
                WRITE_HIGH = 1,
                WAIT_FOR_HIGH_ACK = 2,
                WRITE_LOW = 3,
                WAIT_FOR_LOW_ACK = 4,
                WAIT_FOR_CORE_ACK = 5;
    
    // Internal registers
    reg [31:0] full_packet;
    reg [2:0] state;
    reg [2:0] next_state;
    
    // Reset
    always @(posedge reset) begin
        wr_en <= 1'b0;
        packet <= 16'b0;
        packet_written <= 1'b0;
        state <= IDLE;
        next_state <= IDLE;
        full_packet <= 32'b0;
    end
    
    // Update packet every clock cycle
    always @(posedge clk) begin
        if (!reset) begin
            // Assemble the packet
            full_packet[15:0] <= avalanche_count[15:0];
            full_packet[20:16] <= spad_number[4:0];
            full_packet[31:21] <= 11'b0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        
        // Default to no movement
        next_state = state;
        
        // State machine
        case (state)
            IDLE: begin
                // Outputs
                wr_en <= 1'b0;
                packet_written <= 1'b0;
                
                // Next state
                if (!encoder_write) begin
                    next_state = IDLE;
                end else if (full) begin
                    next_state = IDLE;
                end else begin
                    next_state = WRITE_HIGH;
                end
            end
            
            WRITE_HIGH: begin
                // Outputs
                packet[15:0] = full_packet[31:16];
                wr_en <= 1'b1;
                packet_written <= 1'b0;
                
                // Next state
                if (!encoder_write) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_HIGH_ACK;
                end
            end
            
            WAIT_FOR_HIGH_ACK: begin
                // Outputs
                wr_en <= 1'b0;
                packet_written <= 1'b0;
            
                // Next state
                if (!encoder_write) begin
                    next_state = IDLE;
                end else if (!wr_ack) begin
                    next_state = WRITE_HIGH;
                end else begin
                    next_state = WRITE_LOW;
                end
            end
            
            WRITE_LOW: begin
                // Outputs
                packet[15:0] = full_packet[15:0];
                wr_en <= 1'b1;
                packet_written <= 1'b0;
                
                // Next state
                if (!encoder_write) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_LOW_ACK;
                end
                
            end
            
            WAIT_FOR_LOW_ACK: begin
                // Outputs
                wr_en <= 1'b0;
                packet_written <= 1'b0;
            
                // Next state
                if (!encoder_write) begin
                    next_state = IDLE;
                end else if (!wr_ack) begin
                    next_state = WRITE_LOW;
                end else begin
                    next_state = WAIT_FOR_CORE_ACK;
                end
            
            end
            
            WAIT_FOR_CORE_ACK: begin
                // Outputs
                wr_en <= 1'b0;
                packet_written <= 1'b1;
                
                // Next state
                if (encoder_write) begin
                    next_state = WAIT_FOR_CORE_ACK;
                end else begin
                    next_state = IDLE;
                end
                
            end
        endcase
    
        
    end
    
    
    
endmodule
