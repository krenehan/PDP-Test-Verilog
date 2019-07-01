`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2019 12:31:13 AM
// Design Name: 
// Module Name: encoder_decoder_tb
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


module encoder_decoder_tb(

    );
    
    // Registers
    reg clk;
    reg reset;
    reg [31:0] anode_driver;
    reg tb_wr_en;
    reg tb_rd_en;
    reg [15:0] tb_packet;
    reg encoder_write;
    reg decoder_read;
    reg counter_enable;
    reg correct;
    
    // FIFO Wires
    wire fifo_wr_en;
    wire fifo_rd_en;
    wire fifo_empty;
    wire fifo_full;
    wire [15:0] fifo_din;
    wire [15:0] fifo_dout;
    wire fifo_wr_ack;
    wire fifo_valid;
    
    // Top signals
    wire packet_written;
    wire packet_read;
    wire [4:0] spad_number;
    wire spad_signal;
    
    // Encoder signals
    wire encoder_wr_en;
    wire [15:0] encoder_packet;
    
    // Interconnect
    wire [15:0] avalanche_count;
    
    // Decoder wires
    wire decoder_rd_en;
    
    // Instantiate FIFO
    fifo_generator_0 frontpanel_fifo(
        .clk(clk), 
        .rst(reset),
        .wr_en(fifo_wr_en),
        .rd_en(fifo_rd_en),
        .empty(fifo_empty),
        .full(fifo_full),
        .din(fifo_din),
        .dout(fifo_dout),
        .wr_ack(fifo_wr_ack),
        .valid(fifo_valid)
    );
    
    // Instantiate encoder
    encoder_fast encoder_fast(
        .clk(clk),
        .reset(reset),
        .avalanche_count(avalanche_count),
        .spad_number(spad_number),
        .full(fifo_full),
        .wr_ack(fifo_wr_ack),
        .encoder_write(encoder_write),
        .wr_en(encoder_wr_en),
        .packet(encoder_packet),
        .packet_written(packet_written)   
    );
    
    // Instantiate decoder
    decoder_fast decoder_fast(
        .clk(clk),
        .reset(reset),
        .decoder_read(decoder_read),
        .valid(fifo_valid),
        .empty(fifo_empty),
        .din(fifo_dout),
        .spad_number(spad_number),
        .rd_en(decoder_rd_en),
        .packet_read(packet_read)
    );      
    
    // Instantiate multiplexer
    multiplexer_32to1 spad_mux(
        .anode(anode_driver),
        .select(spad_number),
        .spad_signal(spad_signal)
    );
    
    // Instantiate counter
    async_counter counter(
        .reset(reset),
        .enable(counter_enable),
        .spad_signal(spad_signal),
        .avalanche_count(avalanche_count)
    );
    
    // Clock
    always begin
        #25 clk = ~clk;
    end
    
    // Buses
    assign fifo_rd_en = decoder_read ? decoder_rd_en : tb_rd_en;
    assign fifo_wr_en = encoder_write ? encoder_wr_en : tb_wr_en;
    assign fifo_din[15:0] = encoder_write ? encoder_packet[15:0] : tb_packet[15:0];
    
    // Simulation
    initial begin
        // Initial signals
        clk <= 0;
        reset <= 1;
        anode_driver <= 32'b0;
        tb_wr_en <= 0;
        tb_rd_en <= 0;
        tb_packet <= 16'b0;
        encoder_write <= 0;
        decoder_read <= 0;
        counter_enable <= 0;
        correct <= 1;
        
        // Come out of reset
        repeat (5) @(posedge clk);
        reset <= 0;
        repeat (5) @(posedge clk);
        
        // Emulate the PC, write packet into the FIFO
        tb_packet[15:0] <= 16'b0; // MSB
        @(posedge clk);
        tb_wr_en <= 1;
        @(posedge clk);
        tb_packet[15:0] <= 16'd5; // LSB
        @(posedge clk);
        tb_wr_en <= 0;
        
        // Run the decoder
        @(posedge clk);
        decoder_read <= 1;
        
        // Wait for decoder to be done
        @(posedge packet_read);
        @(posedge clk);
        decoder_read <= 0;
        
        // Check to see if spad_number is set correctly
        if (spad_number[4:0] != 5'd5) begin
            correct <= 0;
        end
        
        // Enable the counter
        counter_enable <= 1;
        
        // 15 pulses
        repeat (15) counter_pulse(spad_number[4:0]);
        
        // Write the packet
        @(posedge clk);
        encoder_write <= 1;
        @(posedge packet_written);
        @(posedge clk);
        encoder_write <= 0;
        
        // Wait a few clock cycles
        repeat (5) @(posedge clk);
        
        // Read the data out
        @(posedge clk);
        tb_rd_en <= 1;
        
        @(posedge fifo_empty);
        tb_rd_en <= 0;
        
        
    end  
    
    
    task counter_pulse;
        input integer x;
        begin
            anode_driver[x] <= 1;
            #50000;
            anode_driver[x] <= 0;
            #50000;
        end
    endtask
    
endmodule
