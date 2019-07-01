`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2019 08:19:57 AM
// Design Name: 
// Module Name: decoder_fast_tb
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


module decoder_fast_tb(

    );
    
    // Inputs to DUT
    reg okClk;
    reg sys_clk;
    reg reset;
    reg decoder_read;
    reg tb_wr_en;
    reg tb_rd_en;
    reg [31:0] tb_dout;
    reg [31:0] tb_packet;
    reg correct_output = 0;
    
    // Outputs of DUT
    wire [4:0] spad_number;
    wire decoder_rd_en;
    wire packet_read;
    
    // Wires to FIFO
    wire fifo_reset;
    wire fifo_wr_en;
    wire fifo_rd_en;
    wire fifo_empty;
    wire fifo_full;
    wire [31:0] fifo_din;
    wire [31:0] fifo_dout;
    wire fifo_wr_ack;
    wire fifo_valid;
    
    // Assign
    assign fifo_reset = reset;
    assign fifo_rd_en = decoder_read ? decoder_rd_en : tb_rd_en;
    //assign fifo_rd_en = decoder_rd_en;
    assign fifo_wr_en = tb_wr_en;
    assign fifo_din[31:0] = tb_dout[31:0];

    
    fifo_generator_1 frontpanel_fifo_32b_pctofpga(
        .wr_clk(okClk),
        .rd_clk(sys_clk),
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
    
    decoder_fast_32b decoder_fast_32b(
        .clk(sys_clk),
        .decoder_read(decoder_read),
        .valid(fifo_valid),
        .empty(fifo_empty),
        .din(fifo_dout),
        .spad_number(spad_number),
        .rd_en(decoder_rd_en),
        .packet_read(packet_read)
    );
    
    // Clock
    always begin
        #2.5 sys_clk = ~sys_clk;
    end
    
    // okClk
    always begin
        #4.96 okClk = ~okClk;
    end
    
    localparam SPAD = 7;
    
    // Simulation
    initial begin
        // Reset
        sys_clk <= 0;
        okClk <= 0;
        reset <= 1;
        decoder_read <= 0;
        tb_rd_en <= 0;
        tb_wr_en <= 0;
        tb_dout <= 32'b0;
        tb_packet[31:0] <= 32'b0;
        
        // Bring out of reset
        repeat (20) @(posedge okClk);
        reset <= 0;
        repeat (20) @(posedge okClk);
        
        // Write 16 bytes
        tb_dout[31:0] <= SPAD;
        @(posedge okClk);
        tb_wr_en <= 1;
        @(posedge okClk);
        tb_dout[31:0] <= 32'd0;
        @(posedge okClk);
        tb_dout[31:0] <= 32'd30;
        @(posedge okClk);
        tb_dout[31:0] <= 32'd60;
        @(posedge okClk);
        tb_wr_en <= 0;
        
//        // Check to see it's written
//        @(posedge clk);
//        tb_rd_en <= 1;
//        repeat (2) @(posedge clk);
//        tb_packet[31:16] <= fifo_dout[15:0];
//        @(posedge clk);
//        tb_packet[15:0] <= fifo_dout[15:0];
//        tb_rd_en <= 0;


        // Read the packet out
        @(posedge sys_clk);
        decoder_read <= 1;
        
        @(posedge packet_read);
        @(posedge sys_clk);
        decoder_read <= 0;

        if (spad_number[4:0] === SPAD) begin
            correct_output <= 1;
            $display("Correct result for SPAD number %d", spad_number[4:0]);
        end else begin
            $display("Incorrect result for SPAD number %d, should be %d", spad_number[4:0], SPAD);
        end
        
        if (fifo_empty) begin
            $display("FIFO was emptied");
        end else begin
            $display("FIFO was not emptied");
        end
        
        repeat (5) @ (posedge okClk);
        $finish;
        
        
    end
    
    
endmodule
