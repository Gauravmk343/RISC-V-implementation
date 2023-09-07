`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2023 10:50:40
// Design Name: 
// Module Name: Data_mem_addr
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


module Data_mem_addr(
    input [31:0] alu_result_in,
    input        Clock,
    
    output reg [4:0] data_mem_addr_out
    );
    
always @ (posedge Clock) begin
    data_mem_addr_out <= alu_result_in[4:0];
end 
endmodule
