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


module full_system_tb(

    );
    
    // Internal tb registers
    reg sys_clk;
    reg okUH;
    reg reset;
    reg [31:0] anode;
    reg tb_wr_en;
    reg tb_rd_en;
    reg [31:0] tb_packet;
    
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
    wire [3:0] core_state;
    
    // Decoder core connections
    wire decoder_read;
    wire packet_read;
    
    // Decoder FIFO connection
    //wire decoder_rd_en;
    
    // Encoder core connections
    wire encoder_write;
    wire packet_written;
    
    // Encoder FIFO connections
    //wire encoder_wr_en;
    //wire [31:0] encoder_packet;
    
    // Relay controller core connections
    wire set_relay;
    wire clear_relay;
    wire relay_set;
    wire holding;
    
    // Counter core connections
    wire counter_enable;
    wire counter_clear;
    
    // Mux to counter connection
    wire spad_signal;
    
    // Counter to encoder connection
    wire [15:0] avalanche_count;
    
    // SPAD address bus
    wire [4:0] spad_number;
    
    // FIFO connection
    wire pctofpga_fifo_wr_en;
    wire pctofpga_fifo_rd_en;
    wire [31:0] pctofpga_fifo_din;
    wire [31:0] pctofpga_fifo_dout;
    wire pctofpga_fifo_wr_ack;
    wire pctofpga_fifo_full;
    wire pctofpga_fifo_valid;
    wire pctofpga_fifo_empty;
    
    // FIFO connection
    wire fpgatopc_fifo_wr_en;
    wire fpgatopc_fifo_rd_en;
    wire [31:0] fpgatopc_fifo_din;
    wire [31:0] fpgatopc_fifo_dout;
    wire fpgatopc_fifo_wr_ack;
    wire fpgatopc_fifo_full;
    wire fpgatopc_fifo_valid;
    wire fpgatopc_fifo_empty;
    
    localparam  SPAD1 = 7,
                COUNTS1 = 5,
                SPAD2 = 24;


    // Clock
    always begin
        #2.5 sys_clk = ~sys_clk;
    end
    
    // Frontpanel clock
    always begin 
        #4.96 okUH = ~okUH;
    end
    
    // Buses
//    assign fifo_rd_en = decoder_read ? decoder_rd_en : tb_rd_en;
//    assign fifo_wr_en = encoder_write ? encoder_wr_en : tb_wr_en;
//    assign fifo_din[31:0] = encoder_write ? encoder_packet[31:0] : tb_packet[31:0];

    assign pctofpga_fifo_din[31:0] = tb_packet[31:0];
    assign pctofpga_fifo_wr_en = tb_wr_en;
    assign fpgatopc_fifo_rd_en = tb_rd_en;
    
    // Simulation
    initial begin
        
        // Initial signal states
        sys_clk <= 0;
        okUH <= 0;
        reset <= 1;
        anode <= 32'b0;
        tb_wr_en <= 0;
        tb_rd_en <= 0;
        tb_packet[31:0] <= 32'b0;
        config_written <= 0;
        start_measurement <= 0;
        stop_measurement <= 0;
        acknowledge <= 0;
        
        // Bring out of reset
        repeat (10) @(posedge okUH);
        reset <= 0;
        repeat (20) @(posedge okUH);
        
        // Write 16 bytes
        tb_packet[31:0] <= SPAD1;
        @(posedge okUH);
        tb_wr_en <= 1;
        @(posedge okUH);
        tb_packet[31:0] <= 32'd0;
        @(posedge okUH);
        tb_packet[31:0] <= 32'd30;
        @(posedge okUH);
        tb_packet[31:0] <= 32'd60;
        @(posedge okUH);
        tb_wr_en <= 0;
        
        // Signal that the configuration is written, handshake with core
        @(posedge okUH);
        config_written <= 1;
        @(posedge config_accepted);
        @(posedge okUH);
        config_written <= 0;
        
        // Wait for test_ready signal, start measurement
        @(posedge ready_to_measure);
        repeat(4) @(posedge okUH);
        start_measurement <= 1;
        @(posedge okUH);
        start_measurement <= 0;
        
        // Run for 15 pulses
        repeat (15) counter_pulse(COUNTS1);
        
        // Stop the measurement
        @(posedge okUH);
        stop_measurement <= 1;
        @(posedge okUH);
        stop_measurement <= 0;
        
        // Wait for the packet to be written and then acknowledge, handshake
        @(posedge results_written);
        @(posedge okUH);
        acknowledge <= 1;
        @(negedge results_written);
        acknowledge <= 0;
        
        // Read the contents of the FIFO out
        repeat (10) @(posedge okUH);
        tb_rd_en <= 1;
        @(posedge fpgatopc_fifo_empty);
        tb_rd_en <= 0;
        
        if (spad_number === SPAD1) begin
            $display("Correct SPAD number %d", spad_number[4:0]);
        end else begin
            $display("Incorrect SPAD number %d", spad_number[4:0]);
            $display("SPAD number should be %d", SPAD1);
        end
        
        if (pctofpga_fifo_empty) begin
            $display("FIFO emptied correctly");
        end else begin
            $display("FIFO not emptied correctly");
        end
                
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
//        repeat (50) counter_pulse(31);
        
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
        input integer x;
        begin
            anode[x] <= 1;
            #50000;
            anode[x] <= 0;
            #50000;
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
        .state(core_state)
    );
    
    // Instantiate counter
    async_counter async_counter(
        .clear(counter_clear),
        .enable(counter_enable),
        .spad_signal(spad_signal), 
        .avalanche_count(avalanche_count)
    );
    
    // Instantiate multiplexer
    multiplexer_32to1 spad_mux(
        .anode(anode),
        .select(spad_number),
        .spad_signal(spad_signal)
    );
    
    // Instantiate FIFO for Frontpanel, this FIFO is written by FPGA and read by PC
    fifo_generator_fpgatopc frontpanel_fifo_32b_fpgatopc(
        .wr_clk(sys_clk),
        .rd_clk(okUH),
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
    
    fifo_generator_pctofpga frontpanel_fifo_32b_pctofpga(
        .wr_clk(okUH),
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
    encoder_fast_32b encoder_fast_32b(
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
    

    
endmodule
