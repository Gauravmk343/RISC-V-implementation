`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2023 14:21:27
// Design Name: 
// Module Name: DATA_MEMORY
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

//The data memory stores data to be read and written based on the operation
module DATA_MEMORY#(
    parameter data_mem = ""
)(
    input   [4:0] addr_in,
    input   [31:0] write_data_in,
    input          read_en_in,
    input          write_en_in,         
//    input          reset,
    input          Clock,
    input          en_data_mem,
    
//    output  reg [31:0] read_data_out
    output wire [31:0] read_data_out_wire
    );

blk_mem_gen_2 Data_memory_instance (
  .clka(Clock),    // input wire clka
  .ena(en_data_mem & (read_en_in | write_en_in)),      // input wire ena
  .wea(write_en_in),      // input wire [0 : 0] wea
  .addra(addr_in[4:0]),  // input wire [4 : 0] addra
  .dina(write_data_in),    // input wire [31 : 0] dina
  .douta(read_data_out_wire)  // output wire [31 : 0] douta
);


/*
reg [31:0] data_memory1 [0:31];

initial if (data_mem) begin
    $readmemb(data_mem, data_memory1);
end

initial begin
    data_memory1[31] <= 32'b0;
end

//The always block to read from the data memory
always @(addr_in or reset or en_data_mem) begin
    if (reset) begin
        read_data_out <= 32'b0;
    end
    else begin
        if(en_data_mem)begin
            if(read_en_in == 1)
                read_data_out <= data_memory1[addr_in[4:0]];
        end
    end
end    

//The always block to write in the data memory
always @(en_data_mem or write_en_in) begin
    if(!reset) begin
        if(en_data_mem)begin        
            if(write_en_in)
                data_memory1[addr_in[4:0]] <= write_data_in;
        end
    end
end 
*/ 
endmodule

