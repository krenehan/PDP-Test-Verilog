`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2019 02:49:29 AM
// Design Name: 
// Module Name: full_system_tb
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

//`include "okHostCalls.v"

module full_system_tb(

    );
    
    // Internal tb registers
    reg sys_clk;
    reg okClk;
    reg reset;
    reg anoden;
    reg anodep;
    reg tb_wr_en;
    reg tb_rd_en;
    reg [31:0] tb_packet;
    
    // Results registers
    reg [31:0] first_result;
    
    // IO to relays
    wire latch_pin;
    wire clear_n_pin;
    wire enable_n_pin;
    wire clock_pin;
    wire data_pin;
    
    // Core to PC connections
    reg config_written;
    reg start_measurement;
    reg stop_measurement;
    wire measurement_running;
    reg acknowledge;
    wire config_accepted;
    wire results_written;
    wire ready_to_measure;
    wire [8:0] core_state;

     // Wires for counter
    localparam COUNTER_WIDTH = 27;
    wire counter_enable;
    wire [COUNTER_WIDTH-1:0] avalanche_count;
    wire anode;
    wire counter_clear;

    // Wires for led
    wire [3:0] led;
    assign led[0] = anode;
    assign led[3:1] = 2'b00;
    
    
    // Wires for fpga to pc FIFO
    wire fpgatopc_fifo_full;
    wire fpgatopc_fifo_empty;
    wire fpgatopc_fifo_wr_en;
    wire fpgatopc_fifo_rd_en;
    wire [31:0] fpgatopc_fifo_din;
    wire [31:0] fpgatopc_fifo_dout;
    wire fpgatopc_fifo_valid;
    wire fpgatopc_fifo_wr_ack;
    
    // Wires for pc to fpga FIFO
    wire pctofpga_fifo_full;
    wire pctofpga_fifo_empty;
    wire pctofpga_fifo_wr_en;
    wire pctofpga_fifo_rd_en;
    wire [31:0] pctofpga_fifo_din;
    wire [31:0] pctofpga_fifo_dout;
    wire pctofpga_fifo_valid;
    wire pctofpga_fifo_wr_ack;
    
    // Wires for encoder
    wire encoder_write;
    wire [31:0] encoder_packet;
    wire encoder_wr_en;
    wire packet_written;
    
    // Wires for decoder
    wire decoder_read;
    wire decoder_rd_en;
    wire packet_read;
    
    // Wires for relay controller
    wire set_relay;
    wire clear_relay;
    wire relay_set;
    wire holding;
    wire [4:0] spad_number;

    // Wires out to frontpanel
    wire [31:0] wires_out;
    
    // FrontPanel pipe
    wire [31:0] config_pipe_dout;
    wire config_pipe_wr_en;
    wire [31:0] results_pipe_din;
    wire results_pipe_rd_en;
    
    // Wire signals
    assign wires_out[0] = config_accepted;
    assign wires_out[1] = ready_to_measure;
    assign wires_out[2] = measurement_running;
    assign wires_out[3] = results_written;
    assign wires_out[4] = pctofpga_fifo_empty;
    assign wires_out[5] = fpgatopc_fifo_empty;
    assign wires_out[10:6] = spad_number[4:0];
    assign wires_out[19:11] = core_state[8:0];

    
    localparam  SPAD1 = 7,
                COUNTS1 = 50,
                SPAD2 = 24,
                COUNTS2 = 1000;


    // Clock
    always begin
        #2.5 sys_clk = ~sys_clk;
    end
    
    // Frontpanel clock
    always begin 
        #4.96 okClk = ~okClk;
    end

    assign pctofpga_fifo_din[31:0] = tb_packet[31:0];
    assign pctofpga_fifo_wr_en = tb_wr_en;
    assign fpgatopc_fifo_rd_en = tb_rd_en;
    
    // Simulation
    initial begin
        
        // Initial signal states
        sys_clk <= 0;
        okClk <= 0;
        reset <= 1;
        anodep <= 1'b0;
        anoden <= 1'b1;
        tb_wr_en <= 0;
        tb_rd_en <= 0;
        tb_packet[31:0] <= 32'b0;
        config_written <= 0;
        start_measurement <= 0;
        stop_measurement <= 0;
        acknowledge <= 0;
        
        // Bring out of reset
        repeat (10) @(posedge okClk);
        reset <= 0;
        repeat (20) @(posedge okClk);
        
        // Write 16 bytes
        tb_packet[31:0] <= SPAD1;
        @(posedge okClk);
        tb_wr_en <= 1;
        @(posedge okClk);
        tb_packet[31:0] <= 32'd0;
        @(posedge okClk);
        tb_packet[31:0] <= 32'd30;
        @(posedge okClk);
        tb_packet[31:0] <= 32'd60;
        @(posedge okClk);
        tb_wr_en <= 0;
        
        // Signal that the configuration is written, handshake with core
        @(posedge okClk);
        config_written <= 1;
        @(posedge config_accepted);
        @(posedge okClk);
        config_written <= 0;
        
        // Wait for test_ready signal, start measurement
        @(posedge ready_to_measure);
        repeat(4) @(posedge okClk);
        start_measurement <= 1;
        @(posedge okClk);
        start_measurement <= 0;
        
        // Run for 15 pulses
        repeat (COUNTS1) counter_pulse();
        
        // Pulse short and make sure counts don't come through
        repeat (20) counter_short_pulse();
        
        // Stop the measurement
        @(posedge okClk);
        stop_measurement <= 1;
        @(posedge okClk);
        stop_measurement <= 0;
        
        // Wait for the packet to be written and then acknowledge, handshake
        @(posedge results_written);
        @(posedge okClk);
        acknowledge <= 1;
        @(negedge results_written);
        acknowledge <= 0;
        
        // Read the contents of the FIFO out
        repeat (10) @(posedge okClk);
        tb_rd_en <= 1;
        repeat (2) @(posedge okClk);
        first_result[31:0] <= fpgatopc_fifo_dout[31:0];
        @(posedge fpgatopc_fifo_empty);
        tb_rd_en <= 0;
        
        if (spad_number === SPAD1) begin
            $display("Correct SPAD number %d", spad_number[4:0]);
        end else begin
            $display("Incorrect SPAD number %d", spad_number[4:0]);
            $display("SPAD number should be %d", SPAD1);
            $finish;
        end
        
        if (pctofpga_fifo_empty) begin
            $display("FIFO emptied correctly");
        end else begin
            $display("FIFO not emptied correctly");
            $finish;
        end
        
        if (first_result[31:27] == SPAD1) begin
            $display("Test 1 - SPAD number correctly output from FIFO");
        end else begin
            $display("Test 1 - SPAD number incorrectly output from FIFO");
            $finish;
        end
        
        if (first_result[COUNTER_WIDTH-1:0] == COUNTS1) begin
            $display("Test 1 - Count value correctly output from FIFO");
        end else begin
            $display("Test 1 - Count value incorrectly output from FIFO");
            $finish;
        end
        
        $display("Success");        
        $finish;
        
//        ///////////////////////////////////////// DO IT AGAIN
        
//        // Emulate the PC, write packet into the FIFO
//        tb_packet[31:0] <= 32'd31; // MSB
//        @(posedge sys_clk);
//        tb_wr_en <= 1;
//        @(posedge sys_clk);
//        tb_wr_en <= 0;
        
//        // Signal that the configuration is written, handshake with core
//        @(posedge sys_clk);
//        config_written <= 1;
//        @(posedge config_accepted);
//        @(posedge sys_clk);
//        config_written <= 0;
        
//        // Wait for test_ready signal, start measurement
//        @(posedge ready_to_measure);
//        repeat(4) @(posedge sys_clk);
//        start_measurement <= 1;
        
//        // Run for 15 pulses
//        repeat (50) counter_pulse();
        
//        // Stop the measurement
//        @(posedge sys_clk);
//        stop_measurement <= 1;
//        start_measurement <= 0;
//        repeat(5) @(posedge sys_clk);
//        stop_measurement <= 0;
        
//        // Wait for the packet to be written and then acknowledge, handshake
//        @(posedge results_written);
//        @(posedge sys_clk);
//        acknowledge <= 1;
//        @(negedge results_written);
//        acknowledge <= 0;
        
//        // Read the contents of the FIFO out
//        repeat (10) @(posedge sys_clk);
//        tb_rd_en <= 1;
//        @(posedge fifo_empty);
//        tb_rd_en <= 0;
        
    end
    
    
    
    
    
    
    
    
    
    
    task counter_pulse;
        begin
            anodep <= 1;
            anoden <= 0;
            #50000;
            anodep <= 0;
            anoden <= 1;
            #50000;
        end
    endtask
    
    task counter_short_pulse;
        begin
            anodep <= 1;
            anoden <= 0;
            #250;
            anodep <= 0;
            anoden <= 1;
            #250;
        end
    endtask
    
    
     // Instantiate core
    core core(
        .clk(sys_clk),
        .reset(reset),
        .config_written(config_written),
        .packet_read(packet_read),
        .packet_written(packet_written),
        .relay_set(relay_set),
        .relay_holding(holding),
        .start_measurement(start_measurement),
        .measurement_running(measurement_running),
        .stop_measurement(stop_measurement),
        .acknowledge(acknowledge),
        .config_accepted(config_accepted),
        .decoder_read(decoder_read),
        .encoder_write(encoder_write),
        .set_relay(set_relay),
        .clear_relay(clear_relay),
        .counter_enable(counter_enable),
        .counter_clear(counter_clear),
        .results_written(results_written),
        .ready_to_measure(ready_to_measure),
        .state(core_state[8:0])
    );
    
    // Debouncer for anode input, if deleting, just comment this out and change input to counter from "anode_debounced" to "anode"
    // Remove counter_short_pulse and function call
    wire anode_debounced;
    wire anode_raw;
    assign anode_raw = anode;
//    wire [9:0] count;
//    wire debounce_counter_enable;
//    wire counter_full;
    debouncer #(.COUNTER_WIDTH(10)) debouncer (
//        // Optional
//        .count(count),
//        .counter_enable(debounce_counter_enable),
//        .counter_full(counter_full),
        
        .clk(sys_clk),
        .reset(reset),
        .enable(counter_enable),
        .in(anode_raw),
        .out(anode_debounced)
    );
    
    // Instantiate counter
    sync_counter #(.WIDTH(COUNTER_WIDTH)) sync_counter(
        .clear(counter_clear),
        .enable(counter_enable),
        .spad_signal(anode_debounced), 
        .avalanche_count(avalanche_count)
    );

//    // Instantiate counter
//    async_counter #(.Width(16)) async_counter (
//        .clk(anode),
//        .reset(counter_clear),
//        .clk_follower(clk_follower),
//        .count(avalanche_count)
//    );

    // Instantiate FIFO for Frontpanel, this FIFO is written by FPGA and read by PC
    fifo_generator_fpgatopc frontpanel_fifo_32b_fpgatopc(
        .wr_clk(sys_clk),
        .rd_clk(okClk),
        .rst(reset),
        .wr_en(fpgatopc_fifo_wr_en),
        .rd_en(fpgatopc_fifo_rd_en),
        .empty(fpgatopc_fifo_empty),
        .full(fpgatopc_fifo_full),
        .din(fpgatopc_fifo_din),
        .dout(fpgatopc_fifo_dout),
        .wr_ack(fpgatopc_fifo_wr_ack),
        .valid(fpgatopc_fifo_valid)
    );
    
    // Instantiate FIFO for Frontpanel, this FIFO is written by PC and read by FPGA
    fifo_generator_pctofpga frontpanel_fifo_32b_pctofpga(
        .wr_clk(okClk),
        .rd_clk(sys_clk),
        .rst(reset),
        .wr_en(pctofpga_fifo_wr_en),
        .rd_en(pctofpga_fifo_rd_en),
        .empty(pctofpga_fifo_empty),
        .full(pctofpga_fifo_full),
        .din(pctofpga_fifo_din),
        .dout(pctofpga_fifo_dout),
        .wr_ack(pctofpga_fifo_wr_ack),
        .valid(pctofpga_fifo_valid)
    );
    
    // Instantiate encoder
    encoder_fast_32b #(.COUNTER_WIDTH(COUNTER_WIDTH)) encoder_fast_32b(
        .clk(sys_clk),
        .avalanche_count(avalanche_count),
        .spad_number(spad_number),
        .full(fpgatopc_fifo_full),
        .wr_ack(fpgatopc_fifo_wr_ack),
        .encoder_write(encoder_write),
        .wr_en(fpgatopc_fifo_wr_en),
        .packet(fpgatopc_fifo_din),
        .packet_written(packet_written)
    );
        
    // Instantiate decoder
    decoder_fast_32b decoder_fast_32b(
        .clk(sys_clk),
        .decoder_read(decoder_read),
        .valid(pctofpga_fifo_valid),
        .empty(pctofpga_fifo_empty),
        .din(pctofpga_fifo_dout),
        .spad_number(spad_number),
        .rd_en(pctofpga_fifo_rd_en),
        .packet_read(packet_read)
    );
    
    // Instantiate relay_controller
    relay_controller relay_controller(
        .clk(sys_clk),
        .set_relay(set_relay),
        .clear_relay(clear_relay),
        .spad_number(spad_number),
        .latch_pin(latch_pin),
        .clear_n_pin(clear_n_pin),
        .enable_n_pin(enable_n_pin),
        .relay_set(relay_set),
        .holding(holding),
        .clock_pin(clock_pin),
        .data_pin(data_pin)
    );
            
    
    // Differential signal buffers
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("LVDS_25")) anode_ibufds (.O(anode), .I(anodep), .IB(anoden));
    

    
endmodule
