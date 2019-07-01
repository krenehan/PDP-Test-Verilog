`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2019 12:52:37 PM
// Design Name: 
// Module Name: encoder_tb
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

//`define BASIC
`define FULL

module encoder_tb(

    );
    
    // Inputs to DUT
    reg clk;
    reg fifo_reset;
    reg encoder_reset;
    reg encoder_write;
    reg [4:0] spad_number;
    reg [15:0] avalanche_count;
    reg fifo_rd_en;
    
    // Interconnect between encoder and fifo
    wire fifo_wr_ack;
    wire [15:0] fifo_din;
    wire fifo_full;
    wire fifo_wr_en;
    
    // Outputs from DUT
    wire [15:0] fifo_dout;
    wire fifo_valid;
    wire packet_written;
    wire fifo_empty;
    
    // Instantiate FIFO
    fifo_generator_0 frontpanel_fifo(
        .clk(clk), 
        .rst(fifo_reset),
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
    encoder encoder(
        .clk(clk),
        .reset(encoder_reset),
        .avalanche_count(avalanche_count),
        .spad_number(spad_number),
        .full(fifo_full),
        .wr_ack(fifo_wr_ack),
        .encoder_write(encoder_write),
        .wr_en(fifo_wr_en),
        .packet(fifo_din),
        .packet_written(packet_written)
        
    );
    
    // 50 ns clock period
    always begin
        #25 clk = ~clk;
    end
    
    `ifdef BASIC
    // Basic write test case
    initial begin
        
        // Reset
        clk <= 0;
        fifo_reset <= 1;
        encoder_reset <= 1;
        encoder_write <= 0;
        spad_number <= 5'b0;
        avalanche_count <= 16'b0;
        fifo_rd_en <= 0;
        
        // Hold reset for 4 clock cycles
        repeat (4) @(posedge clk);
        
        // Bring reset low and hold for 4 cycles
        fifo_reset <= 0;
        encoder_reset <= 0;
        repeat (4) @(posedge clk);
        
        // Put dummy data into registers
        spad_number <= 5'hA;
        avalanche_count <= 16'hABCD;
        
        // Trigger the encoder
        @(posedge clk);
        encoder_write <= 1;
        
        // Wait for packet_written
        @(posedge packet_written);
        encoder_write <= 0;
        
        // Read the data back
        @(posedge clk);
        fifo_rd_en <= 1;
        
        // Wait until we've read out the entire FIFO
        @(posedge fifo_empty);
        fifo_rd_en <= 0;
        
    end
    `endif

    `ifdef FULL
    // Full fifo test case
    initial begin
        // Reset
        clk <= 0;
        fifo_reset <= 1;
        encoder_reset <= 1;
        encoder_write <= 0;
        spad_number <= 5'b0;
        avalanche_count <= 16'b0;
        fifo_rd_en <= 0;
        
        // Hold reset for 4 clock cycles
        repeat (4) @(posedge clk);
        
        // Bring reset low and hold for 4 cycles
        fifo_reset <= 0;
        encoder_reset <= 0;
        repeat (4) @(posedge clk);
        
        // Put dummy data into registers
        spad_number <= 5'b11111;
        avalanche_count <= 16'hFFFF;
        
        // Fill the FIFO completely, 16 encoder_write cycles
        fill_fifo();
        
        // Attempt an encoder_write operation
        @(posedge clk);
        spad_number = 5'hA;
        avalanche_count = 16'hABCD;
        encoder_write <= 1;
        
        // Wait for 10 clock cycles
        repeat (10) @(posedge clk);
        
        // Initiate 16 reads to clear FIFO of dummy data
        fifo_rd_en = 1;
        repeat (32) @(posedge clk);
        fifo_rd_en = 0;
        
        // Clear encoder_write
        @(posedge clk);
        encoder_write <= 0;
        
        // Read the data back
        @(posedge clk);
        fifo_rd_en <= 1;
        
        // Wait until we've read out the entire FIFO
        @(posedge fifo_empty);
        fifo_rd_en <= 0;
        
    end
    `endif

task fill_fifo;
    integer x;
    begin
        while (!fifo_full) begin
            @(posedge clk);
            encoder_write <= 1;
            @(posedge packet_written);
            encoder_write <= 0;
            x = x + 1;
        end
    end
endtask

endmodule
