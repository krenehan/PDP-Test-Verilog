`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2019 11:38:47 PM
// Design Name: 
// Module Name: encoder_fast
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


module encoder_fast(
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
                FIRST_PACKET_ATTEMPTED = 1,
                FIRST_PACKET_FAILED = 2,
                SECOND_PACKET_ATTEMPTED = 3,
                SECOND_PACKET_FAILED = 4,
                DONE = 5,
                NOT_ACKNOWLEDGED = 6;
    
    // Internal registers
    reg [31:0] full_packet;
    reg [2:0] state;
    reg [2:0] next_state;
    
    // Reset
    always @(posedge clk) begin
        if (reset) begin
            wr_en <= 1'b0;
            packet <= 16'b0;
            packet_written <= 1'b0;
            state <= IDLE;
            next_state <= IDLE;
            full_packet <= 32'b0;
        end else begin
            // Assemble the packet
            full_packet[15:0] <= avalanche_count[15:0];
            full_packet[20:16] <= spad_number[4:0];
            full_packet[31:21] <= 11'b0;
            
            // Update state
            state <= next_state;
        end
    end
    
//    // Drive the bus
//    always @(posedge clk) begin
//        if (encoder_write) begin
//            //
//        end
//    end
    
    
    // Combinational logic
    always @(*) begin
    
        // Default no movement
        next_state = state;
        
        // States
        case (state)
            IDLE: begin
                if (encoder_write) begin
                    // Outputs
                    packet[15:0] = full_packet[31:16];
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = FIRST_PACKET_ATTEMPTED;
                end else begin
                    // Outputs
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
            
            FIRST_PACKET_ATTEMPTED: begin
                if (!encoder_write) begin
                    // Outputs
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                        
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    packet[15:0] = full_packet[15:0];
                    wr_en <= 1;
                    packet_written <= 0;
                        
                    // Next state
                    next_state = SECOND_PACKET_ATTEMPTED;                        
                end else begin
                    // Outputs
                        wr_en <= 1;
                        packet_written <= 0;
                        
                    // Next state
                    next_state = FIRST_PACKET_FAILED;
                end
            end
            
            FIRST_PACKET_FAILED: begin
                if (!encoder_write) begin
                    // Outputs
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    packet[15:0] = full_packet[15:0];
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = SECOND_PACKET_ATTEMPTED;
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = FIRST_PACKET_FAILED;
                end
            end
            
            SECOND_PACKET_ATTEMPTED: begin
                if (!encoder_write) begin
                    // Outputs
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 1;
                    
                    // Next state
                    next_state = DONE;
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = SECOND_PACKET_FAILED;
                end
            end
            
            SECOND_PACKET_FAILED: begin
                if (!encoder_write) begin
                    // Outputs
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end else if (wr_ack) begin
                    // Outputs
                    wr_en <= 0;
                    packet_written <= 1;
                    
                    // Next state
                    next_state = DONE;
                end else begin
                    // Outputs
                    wr_en <= 1;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = SECOND_PACKET_FAILED;
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
                    packet[15:0] <= 16'bZZZZZZZZZZZZZZZZ;
                    wr_en <= 1'bZ;
                    packet_written <= 0;
                    
                    // Next state
                    next_state = IDLE;
                end
            end
        endcase
    
    end
    
endmodule
