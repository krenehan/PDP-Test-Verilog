`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 03:34:27 PM
// Design Name: 
// Module Name: multiplexer_32to1
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


module multiplexer_32to1(
    input [31:0] anode,
    input [4:0] select,
    output reg spad_signal
    );
    
    always @(select or anode) begin
        case (select)
            5'b00000: spad_signal <= anode[0];
            5'b00001: spad_signal <= anode[1];
            5'b00010: spad_signal <= anode[2];
            5'b00011: spad_signal <= anode[3];
            5'b00100: spad_signal <= anode[4];
            5'b00101: spad_signal <= anode[5];
            5'b00110: spad_signal <= anode[6];
            5'b00111: spad_signal <= anode[7];
            5'b01000: spad_signal <= anode[8];
            5'b01001: spad_signal <= anode[9];
            5'b01010: spad_signal <= anode[10];
            5'b01011: spad_signal <= anode[11];
            5'b01100: spad_signal <= anode[12];
            5'b01101: spad_signal <= anode[13];
            5'b01110: spad_signal <= anode[14];
            5'b01111: spad_signal <= anode[15];
            5'b10000: spad_signal <= anode[16];
            5'b10001: spad_signal <= anode[17];
            5'b10010: spad_signal <= anode[18];
            5'b10011: spad_signal <= anode[19];
            5'b10100: spad_signal <= anode[20];
            5'b10101: spad_signal <= anode[21];
            5'b10110: spad_signal <= anode[22];
            5'b10111: spad_signal <= anode[23];
            5'b11000: spad_signal <= anode[24];
            5'b11001: spad_signal <= anode[25];
            5'b11010: spad_signal <= anode[26];
            5'b11011: spad_signal <= anode[27];
            5'b11100: spad_signal <= anode[28];
            5'b11101: spad_signal <= anode[29];
            5'b11110: spad_signal <= anode[30];
            5'b11111: spad_signal <= anode[31];
        endcase
    end
    
endmodule
