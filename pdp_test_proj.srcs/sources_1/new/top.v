`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 05:27:56 PM
// Design Name: 
// Module Name: top
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

// TODO: System for FIFO bus control

module top(
    // FrontPanel interface pins
    input wire [4:0]    okUH,
    output wire [2:0]   okHU,
    inout wire [31:0]   okUHU,
    inout wire          okAA,
    
    // LVDS pins from clock
    input wire          sys_clkp,
    input wire          sys_clkn,
    
    // Reset
    input wire          reset_board,
    
    // LED pins
    output wire [3:0]   led_activelow,
    
    // Pins for relay controller
    output wire         latch_pin,
    output wire         clear_n_pin,
    output wire         enable_n_pin,
    output wire         clock_pin,
    output wire         data_pin,
    
    // SPAD pins
    input wire          anodep,
    input wire          anoden,
    
    // Chip ID pins
    input wire jan_b0,
    input wire nir_b0,
    input wire halo_b0,
    input wire spad_b0,
    input wire array_section_b2,
    input wire array_section_b1,
    input wire array_section_b0,
    input wire board_b2,
    input wire board_b1,
    input wire board_b0
    
    );
    
    // System clock
    wire sys_clk;
    IBUFGDS osc_clk(.O(sys_clk), .I(sys_clkp), .IB(sys_clkn));
    
    
    // Wires for counter
    localparam COUNTER_WIDTH = 27;
    wire counter_enable;
    wire [COUNTER_WIDTH-1:0] avalanche_count;
    wire anode;
    wire counter_clear;
    
    // Wires from core
    wire [8:0] core_state;
    
//    // Wires for led 
//    wire [3:0] led;
//    assign led[3:0] = core_state[3:0];
//    genvar i;        
//    generate        
//        for (i=0; i<4 ; i=i+1) begin
//            assign led_activelow[i] = ~led[i];
//        end        
//    endgenerate 

    // Wires for led
    wire [3:0] led;
    assign led[0] = anode;
    assign led[3:1] = 2'b00;
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin
            assign led_activelow[i] = ~led[i];
        end
    endgenerate
    
    
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
    
    // Wires FrontPanel interface
    wire okClk;
    wire [112:0] okHE;
    wire [64:0] okEH;
    
    // FrontPanel wires
    wire [31:0] wires_in;
    wire [31:0] wires_out;
    
    // FrontPanel pipe
    wire [31:0] config_pipe_dout;
    wire config_pipe_wr_en;
    wire [31:0] results_pipe_din;
    wire results_pipe_rd_en;
    
    // Wire signals
    wire reset_frontpanel;
    assign reset_frontpanel = wires_in[0];
    wire config_written;
    assign config_written = wires_in[1];
    wire acknowledge;
    assign acknowledge = wires_in[2];
    wire config_accepted;
    assign wires_out[0] = config_accepted;
    wire ready_to_measure;
    assign wires_out[1] = ready_to_measure;
    wire measurement_running;
    assign wires_out[2] = measurement_running;
    wire results_written;
    assign wires_out[3] = results_written;
    assign wires_out[4] = pctofpga_fifo_empty;
    assign wires_out[5] = fpgatopc_fifo_empty;
    assign wires_out[10:6] = spad_number[4:0];
    assign wires_out[19:11] = core_state[8:0];
    assign wires_out[20] = board_b0;
    assign wires_out[21] = board_b1;
    assign wires_out[22] = board_b2;
    assign wires_out[23] = array_section_b0;
    assign wires_out[24] = array_section_b1;
    assign wires_out[25] = array_section_b2;
    assign wires_out[26] = spad_b0;
    assign wires_out[27] = halo_b0;
    assign wires_out[28] = nir_b0;
    assign wires_out[29] = jan_b0;
    
    // Reset
    wire reset;
    assign reset = reset_board || reset_frontpanel;
    
    // Trigger signals
    wire start_measurement;
    assign start_measurement = wires_in[3];
    wire stop_measurement;
    assign stop_measurement = wires_in[4];


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
    wire anode_debounced;
    wire anode_raw;
    assign anode_raw = anode;
    debouncer #(.COUNTER_WIDTH(10)) debouncer (
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
        
    // Instantiate host
    wire [65*3-1:0]  okEHx;
    okHost okHI(
        .okUH(okUH),
        .okHU(okHU),
        .okUHU(okUHU),
        .okAA(okAA),
        .okClk(okClk),
        .okHE(okHE), 
        .okEH(okEH)
    );
    
    // Data for Pipe In
    okPipeIn config_pipein (
        .okHE(okHE), 
        .okEH(okEHx[0*65 +: 65]),
        .ep_addr(8'h80), 
        .ep_dataout(pctofpga_fifo_din), 
        .ep_write(pctofpga_fifo_wr_en)
    );
    
    // Data for Pipe Out
    okPipeOut results_pipeout(
        .okHE(okHE), 
        .okEH(okEHx[1*65 +: 65]),
        .ep_addr(8'ha0), 
        .ep_datain(fpgatopc_fifo_dout), 
        .ep_read(fpgatopc_fifo_rd_en)
    );
    
    // Data for Wire In
    okWireIn okWireIn(
        .okHE(okHE),
        .ep_addr(8'h0),
        .ep_dataout(wires_in)
    );
    
    // Data for Wire Out
    okWireOut okWireOut(
        .okHE(okHE),
        .okEH(okEHx[2*65 +: 65]),
        .ep_addr(8'h20),
        .ep_datain(wires_out)
    );
    
    
    // okWireOr to control bus traffic
    okWireOR # (.N(3)) wireOR (okEH, okEHx);        
    
    // Differential signal buffers
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("LVDS_25")) anode_ibufds (.O(anode), .I(anodep), .IB(anoden));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode1 (.O(anode[1]), .I(anodep[1]), .IB(anoden[1]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode2 (.O(anode[2]), .I(anodep[2]), .IB(anoden[2]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode3 (.O(anode[3]), .I(anodep[3]), .IB(anoden[3]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode4 (.O(anode[4]), .I(anodep[4]), .IB(anoden[4]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode5 (.O(anode[5]), .I(anodep[5]), .IB(anoden[5]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode6 (.O(anode[6]), .I(anodep[6]), .IB(anoden[6]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode7 (.O(anode[7]), .I(anodep[7]), .IB(anoden[7]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode8 (.O(anode[8]), .I(anodep[8]), .IB(anoden[8]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode9 (.O(anode[9]), .I(anodep[9]), .IB(anoden[9]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode10 (.O(anode[10]), .I(anodep[10]), .IB(anoden[10]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode11 (.O(anode[11]), .I(anodep[11]), .IB(anoden[11]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode12 (.O(anode[12]), .I(anodep[12]), .IB(anoden[12]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode13 (.O(anode[13]), .I(anodep[13]), .IB(anoden[13]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode14 (.O(anode[14]), .I(anodep[14]), .IB(anoden[14]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode15 (.O(anode[15]), .I(anodep[15]), .IB(anoden[15]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode16 (.O(anode[16]), .I(anodep[16]), .IB(anoden[16]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode17 (.O(anode[17]), .I(anodep[17]), .IB(anoden[17]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode18 (.O(anode[18]), .I(anodep[18]), .IB(anoden[18]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode19 (.O(anode[19]), .I(anodep[19]), .IB(anoden[19]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode20 (.O(anode[20]), .I(anodep[20]), .IB(anoden[20]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode21 (.O(anode[21]), .I(anodep[21]), .IB(anoden[21]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode22 (.O(anode[22]), .I(anodep[22]), .IB(anoden[22]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode23 (.O(anode[23]), .I(anodep[23]), .IB(anoden[23]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode24 (.O(anode[24]), .I(anodep[24]), .IB(anoden[24]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode25 (.O(anode[25]), .I(anodep[25]), .IB(anoden[25]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode26 (.O(anode[26]), .I(anodep[26]), .IB(anoden[26]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode27 (.O(anode[27]), .I(anodep[27]), .IB(anoden[27]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode28 (.O(anode[28]), .I(anodep[28]), .IB(anoden[28]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode29 (.O(anode[29]), .I(anodep[29]), .IB(anoden[29]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode30 (.O(anode[30]), .I(anodep[30]), .IB(anoden[30]));
//    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")) anode31 (.O(anode[31]), .I(anodep[31]), .IB(anoden[31]));

    
    
endmodule
