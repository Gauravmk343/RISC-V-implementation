`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2023 12:24:48
// Design Name: 
// Module Name: MUX_ALU_input
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

// Multiplexer to select the signal going to ALU 2nd input
module MUX_ALU_input(
    input    alu_mux_sel,
    input   [31:0] alu_mux_input_0,
    input   [31:0] alu_mux_input_1, 
    output  reg [31:0] alu_mux_output
    );
always @ (alu_mux_sel or alu_mux_input_0 or alu_mux_input_1) begin
    case (alu_mux_sel)
        1: alu_mux_output <= alu_mux_input_1;
        0: alu_mux_output <= alu_mux_input_0;
    endcase
end
endmodule
