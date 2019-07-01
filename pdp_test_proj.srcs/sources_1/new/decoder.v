`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 07:58:30 PM
// Design Name: 
// Module Name: decoder
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


module decoder(
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
                READ = 1,
                WAIT_FOR_VALID = 2,
                PACKET_READ = 3;
                
    // Internal registers
    reg [15:0] packet;
    reg [1:0] state;
    reg [1:0] next_state;
    
    // Reset
    always @(posedge reset) begin
        spad_number[4:0] = 5'b0;
        rd_en <= 1'b0;
        packet <= 16'b0;
        packet_read <= 1'b0;
        state <= IDLE;
        next_state <= IDLE;
    end
    
    // Update packet every clock cycle
    always @(posedge clk) begin
        if (!reset) begin
            // Assemble the packet
            spad_number[4:0] <= packet[4:0];

        end
    end
    
    // Update state
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // State machine
    always @(*) begin
        
        // Default to no movement
        next_state = state;
        
        // State machine
        case (state)
            IDLE: begin
                // Outputs
                rd_en <= 1'b0;
                packet_read <= 1'b0;
                
                // Next state
                if (!decoder_read) begin
                    next_state = IDLE;
                end else if (empty) begin
                    next_state = IDLE;
                end else begin
                    next_state = READ;
                end
                
            end
            
            READ: begin
                // Outputs
                rd_en <= 1'b1;
                packet_read <= 1'b0;
                
                // Next state
                if (!decoder_read) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_VALID;
                end
            
            end
            
            WAIT_FOR_VALID: begin
                // Outputs
                rd_en <= 1'b0;
                packet_read <= 1'b0;
                
                // Next state
                if (!decoder_read) begin
                    next_state = IDLE;
                end else if (!valid) begin
                    next_state = READ;
                end else begin
                    next_state = PACKET_READ;
                end
            
            end
            
            PACKET_READ: begin
                // Outputs
                rd_en <= 1'b0;
                packet_read <= 1'b1;
                
                // Next state
                if (decoder_read) begin
                    next_state = PACKET_READ;
                end else begin
                    next_state = IDLE;
                end
                
            end
 
        endcase
    
        
    end
    
endmodule
