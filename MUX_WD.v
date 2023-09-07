`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2023 12:11:26
// Design Name: 
// Module Name: MUX_WD
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
// Multiplexer for the data before writing into the register file

module MUX_WD(
    input    wd_sel,
    input   [31:0] wd_input_0,
    input   [31:0] wd_input_1, 
    output  reg [31:0] wd_output
    );
    
always @ (wd_sel or wd_input_0 or wd_input_1) begin
    case (wd_sel)
       1: wd_output <= wd_input_1;
       0: wd_output <= wd_input_0; 
    endcase 
end

endmodule
