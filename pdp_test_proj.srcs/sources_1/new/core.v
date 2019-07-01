`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 01:21:55 AM
// Design Name: 
// Module Name: core
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


module core(
    input clk,
    input reset,
    input config_written,
    input packet_read,
    input packet_written,
    input relay_set,
    input relay_holding,
    input start_measurement,
    input stop_measurement,
    input acknowledge,
    output reg config_accepted = 0,
    output reg decoder_read = 0,
    output reg encoder_write = 0,
    output reg set_relay = 0,
    output reg clear_relay = 0,
    output reg counter_enable = 0,
    output reg counter_clear = 1,
    output reg measurement_running = 0,
    output reg results_written = 0,
    output reg ready_to_measure = 0,
    output reg [8:0] state = 0
    );
    
    // State registers
    reg [8:0] next_state;
    
    // States
    localparam      IDLE                =   9'b000000001,
                    CONFIG_ACCEPTED     =   9'b000000010,
                    DECODE              =   9'b000000100,
                    SET_RELAY           =   9'b000001000,
                    READY_TO_MEASURE    =   9'b000010000,
                    MEASURE             =   9'b000100000,
                    MEASUREMENT_DONE    =   9'b001000000,
                    ENCODE              =   9'b010000000,
                    NOTIFY              =   9'b100000000;
                    
    // Reset or advance state
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
    
        // Default to IDLE state if case is not matched
        next_state = IDLE;
        
        case (state)
            IDLE: begin
                // Outputsup to us and 
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 1;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (config_written) begin
                    next_state = CONFIG_ACCEPTED;
                end else begin
                    next_state = IDLE;
                end
            end
            
            CONFIG_ACCEPTED: begin
                // Outputs
                config_accepted <= 1;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (config_written) begin
                    next_state = CONFIG_ACCEPTED;
                end else begin
                    next_state = DECODE;
                end
            end
            
            DECODE: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 1;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (packet_read) begin
                    next_state = SET_RELAY;
                end else begin
                    next_state = DECODE;
                end
            end
            
            SET_RELAY: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 1;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (relay_set) begin
                    next_state = READY_TO_MEASURE;
                end else begin
                    next_state = SET_RELAY;
                end
            end
            
            READY_TO_MEASURE: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written = 0;
                ready_to_measure = 1;
                
                // Next state
                if (start_measurement) begin
                    next_state = MEASURE;
                end else begin
                    next_state = READY_TO_MEASURE;
                end
            end
            
            MEASURE: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 1;
                counter_clear <= 0;
                measurement_running <= 1;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (stop_measurement) begin
                    next_state = MEASUREMENT_DONE;
                end else begin
                    next_state = MEASURE;
                end
            end
            
            MEASUREMENT_DONE: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 1;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (relay_holding) begin
                    next_state = MEASUREMENT_DONE;
                end else begin
                    next_state = ENCODE;
                end
            end
            
            ENCODE: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 1;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 0;
                ready_to_measure <= 0;
                
                // Next state
                if (packet_written) begin
                    next_state = NOTIFY;
                end else begin
                    next_state = ENCODE;
                end
            end
            
            NOTIFY: begin
                // Outputs
                config_accepted <= 0;
                decoder_read <= 0;
                encoder_write <= 0;
                set_relay <= 0;
                clear_relay <= 0;
                counter_enable <= 0;
                counter_clear <= 0;
                measurement_running <= 0;
                results_written <= 1;
                ready_to_measure <= 0;
                
                // Next state
                if (acknowledge) begin
                    next_state = IDLE;
                end else begin
                    next_state = NOTIFY;
                end
            end
        endcase
    end
    
endmodule
