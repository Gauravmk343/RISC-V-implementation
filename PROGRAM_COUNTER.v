`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2023 12:43:23
// Design Name: 
// Module Name: PROGRAM_COUNTER
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

//Program counter gives the address of where the instruction is stored in instruction set
module PROGRAM_COUNTER(
    input   [4:0] Immediate_branch_in,
    input         peripheral_reset,
    input         en_pc,
    input         Clock,
    input         branch_op,
    input         [31:0] alu_result_in,
    
    output  reg [4:0] pc_out
    ); 
localparam MAX_INST_COUNT = 5'b10001;   

always @ (posedge peripheral_reset or negedge Clock) begin    
    if(peripheral_reset)  
        pc_out <= 5'b0;
    else if(en_pc && branch_op && (alu_result_in ==0)) 
    begin
            //Addign the immediate value to the pc in case of branch function
                    pc_out <= (pc_out + Immediate_branch_in[4:0])%MAX_INST_COUNT;
            end        
     else if(en_pc)
     begin
            //peripheral_resetting the  counter when it reaches the max value
            pc_out <= (pc_out+1)%MAX_INST_COUNT; 
     end
     else begin
        pc_out <= pc_out;
     end
   end 
endmodule

