`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2023 10:53:24
// Design Name: 
// Module Name: Program_imm_branch
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


module Program_imm_branch(
    input [12:0] immediate_branch_in,
    input        Clock,
    
    output reg [4:0] immediate_branch_pc_out
    );
    
always @ (posedge Clock) begin
    immediate_branch_pc_out <= immediate_branch_in;
end
endmodule
