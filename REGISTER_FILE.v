`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2023 12:27:40
// Design Name: 
// Module Name: REGISTER_FILE
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

//Register file with 2 read ports and 1 write port, the register file is filled 
// with some data, the first value is 0.
module REGISTER_FILE #(
    parameter reg_file = ""
)(
    input   [4:0] read_addr_1_in,
    input   [4:0] read_addr_2_in,
    input   [4:0] write_addr_in,
    input   [31:0] write_data_in,
    input   write_en_in,
    input   read_en_in,
//    input   reset,
    input   Clock,
    //Signal to enable the register file
    input   en_reg_file,                  
    
//    output  reg  [31:0] read_data_1_out,
//    output  reg  [31:0] read_data_2_out
    
    output wire [31:0] read_data_1_out_wire,
    output wire [31:0] read_data_2_out_wire
    );
    
wire [4:0] addr_in_wire;
assign addr_in_wire = (read_en_in == 1)? read_addr_2_in : 5'bZ;
assign addr_in_wire =(write_en_in == 1)? write_addr_in : 5'bZ;
blk_mem_gen_1 Reg_file_instance (
  .clka(Clock),    // input wire clka
  .ena(en_reg_file & read_en_in),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(read_addr_1_in),  // input wire [4 : 0] addra
  .dina(32'b0),    // input wire [31 : 0] dina
  .douta(read_data_1_out_wire),  // output wire [31 : 0] douta
  .clkb(Clock),    // input wire clkb
  .enb(en_reg_file & (read_en_in | write_en_in)),      // input wire enb
  .web(write_en_in),      // input wire [0 : 0] web
  .addrb(addr_in_wire),  // input wire [4 : 0] addrb
  .dinb(write_data_in),    // input wire [31 : 0] dinb
  .doutb(read_data_2_out_wire)  // output wire [31 : 0] doutb
);

//// Initializing the register file memory with data

//reg [31:0] Register_file_memory [0:31];
//initial if(reg_file) begin
//    $readmemb(reg_file, Register_file_memory);
//end

//////Making the first data equal to 0
//initial begin
//    Register_file_memory[0] = 31'b0;
//end



//always @ (reset or read_en_in or en_reg_file) 
//begin
//    if(reset) begin
//    //Setting the read values to 0 when reset is pressed
//        read_data_1_out <= Register_file_memory[0];
//        read_data_2_out <= Register_file_memory[0];
//    end
//    else 
//    begin
//        if(en_reg_file && read_en_in) begin          //Ensuring both Enable for register file and read enable are active
//                read_data_1_out <= Register_file_memory[read_addr_1_in];
//                read_data_2_out <= Register_file_memory[read_addr_2_in];
//        end
//    end
//end

//always @ (write_en_in or en_reg_file)
//begin
//    if(!reset && en_reg_file && write_en_in && write_addr_in != 5'b0)  //Ensuring that writing does not happen in the first register as it is initialized to zero
//        begin
//            Register_file_memory[write_addr_in] <= write_data_in;
//        end 
//end
endmodule

