`timescale 10ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2019 04:24:44 PM
// Design Name: 
// Module Name: multiplexer_32to1_tb
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


module multiplexer_32to1_tb(

    );
    
    // Inputs to DUT
    reg [31:0] anode;
    reg [4:0] select;
    wire spad_signal;
    
    // Instantiate DUT
    multiplexer_32to1 mux(
        .anode(anode),
        .select(select),
        .spad_signal(spad_signal)
    );
    
    // Run test
    initial 
    begin
        anode[31:0] = 32'hAAAAAAAA;
        select[4:0] = 0;
        $display($time, "<< Starting simulation >>");
        
        increment_select();
        
        $display($time, "<< Ending simulation >>");
        
    end
    
    task increment_select;
        integer x;
        begin
            for(x=0; x <= 30; x=x+1)
            begin
                #20;
                select = select + 1;
            end
        end
    endtask
    
    
endmodule
