`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2023 12:21:55
// Design Name: 
// Module Name: INSTRUCTION_SET
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

//The Instruction set contains the list of instructions which go one by one to the instruction decoder
module INSTRUCTION_SET#(
    parameter file = ""
)(
    input  [4:0] pc_in,
    input        Clock,
//    input reset,
    input enable_inst_set,
    
    //output  [31:0] inst_out_wire,
    output  [31:0] inst_out_wire
    );
//reg [31:0] instructions [0:31];

//initial if(file) begin
//    $readmemb(file, instructions);
//end
//wire [31:0] inst_out_wire;

blk_mem_gen_0 Instruction_Set(
  .clka(Clock),    // input wire clka
  .ena(enable_inst_set),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(pc_in),  // input wire [4 : 0] addra
  .dina(32'b0),    // input wire [31 : 0] dina
  .douta(inst_out_wire)  // output wire [31 : 0] douta
);  


//assign inst_out_wire = inst_out;
//always @ (reset or pc_in or enable_inst_set) begin
//    if(reset == 1)
//        inst_out <= 32'b0;
////    else begin
////        if(enable_inst_set)
////        begin
////            inst_out <= instructions[pc_in];
////        end
////    end    
//end
endmodule

