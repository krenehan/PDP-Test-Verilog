`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2019 01:46:28 AM
// Design Name: 
// Module Name: encoder_fast_32b
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


module encoder_fast_32b(
    input clk,
    input [15:0] avalanche_count,
    input [4:0] spad_number,
    input full,
    input encoder_write,
    input wr_ack,
    output reg wr_en = 0,
    output reg [31:0] packet,
    output reg packet_written
    );
    
    // States
    localparam  IDLE                        = 6'b000001,
                FIRST_PACKET_ATTEMPTED      = 6'b000010,
                FIRST_PACKET_FAILED         = 6'b000100,
                FILL_FIFO                   = 6'b001000,
                DONE                        = 6'b010000,
                NOT_ACKNOWLEDGED            = 6'b100000;
    
    // Internal registers
    reg [6:0] state = IDLE;
    reg [6:0] next_state;
    
    // This logic was implemented to deal with synchronization delay.
    // This delay causes problems when trying to fill the FIFO.
    reg fill_fifo_flag = 0;
    reg reset_fill_fifo_flag = 0;
    reg [2:0] packet_counter = 3'd3;
    
    // Advance state
    always @(posedge clk) begin
        // Update state
        state <= next_state;        
    end
    
    always @(posedge clk) begin
        // Assemble packet
        if (!fill_fifo_flag) begin
            // Assemble the packet
            packet[15:0] <= avalanche_count[15:0];
            packet[20:16] <= spad_number[4:0];
            packet[31:21] <= 11'b0;
        end else begin
            packet[31:0] <= 32'b0;
        end
    end
    
    // Counting packets sent during fill cycle
    always @(posedge clk) begin
        if (fill_fifo_flag) begin
            packet_counter = packet_counter - 1;
        end else if (reset_fill_fifo_flag) begin
            packet_counter[2:0] = 3'd3;
        end
    end
    
    
    // Combinational logic
    always @(*) begin
    
        // Default back to IDLE state if case is not matched
        next_state = IDLE;
        
        // States
        case (state)
            IDLE: begin
                if (encoder_write) begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 0;
                    
                    // Next state
                    next_state = FIRST_PACKET_ATTEMPTED;
                end else begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 1;
                    fill_fifo_flag <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
            
            FIRST_PACKET_ATTEMPTED: begin
                if (!encoder_write) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 0;
                        
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 1;
                        
                    // Next state
                    next_state = FILL_FIFO;                        
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                        
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 0;
                        
                    // Next state
                    next_state = FIRST_PACKET_FAILED;
                end
            end
            
            FIRST_PACKET_FAILED: begin
                if (!encoder_write) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 1;
                    
                    // Next state
                    next_state = FILL_FIFO;
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = FIRST_PACKET_FAILED;
                end
            end
            
            FILL_FIFO: begin
                if (!encoder_write) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (packet_counter[2:0] == 3'b0) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 0;
                    
                    // Next state
                    next_state = DONE;
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Flags
                    reset_fill_fifo_flag <= 0;
                    fill_fifo_flag <= 1;
                    
                    // Next state
                    next_state = FILL_FIFO;
                end
            end
            
            DONE: begin
                if (encoder_write) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 1;
                    
                    // Next state
                    next_state = NOT_ACKNOWLEDGED;
                end else begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
            
            NOT_ACKNOWLEDGED: begin 
                if (encoder_write) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 1;
                    
                    // Next state
                    next_state = NOT_ACKNOWLEDGED;
                end else begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
        endcase
    
    end
    
endmodule
