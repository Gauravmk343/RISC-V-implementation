`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2023 14:52:55
// Design Name: 
// Module Name: CONTROL_ENABLE
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

// The brains of the entire processor. It sends signals to all the components to enable 
//whenever required
module CONTROL_ENABLE(
    input   Clk,
    input   peripheral_reset,
    input   halt,
    
    output reg en_inst_set_out,        //enable instruction set
    output reg en_inst_decode_out,     // enable instruction decoder
    output reg en_data_mem_out,        //enable data memory
    output reg en_pc_out,              //enable program counter
    output reg en_alu_out,             //Enable ALU
    output reg en_reg_file_out,        //Enable registeer file
    
    //Signals to indicate which step is being run
    output reg fetch_out,              //
    output reg decode_out,
    output reg execute_out,
    output reg write_back_out
    );

localparam IDLE         = 3'b000;
localparam FETCH        = 3'b001;
localparam DECODE       = 3'b010;
localparam EXECUTE      = 3'b011;
localparam WRITE_BACK   = 3'b100;
    
reg [2:0] present_state;
reg [2:0] next_state;

always @ (posedge Clk or posedge peripheral_reset) begin
    if(halt) begin
        present_state <= IDLE;
    end       
    else begin
        if(peripheral_reset) 
            present_state <= IDLE;
        else
            present_state <= next_state;
    end
end


always @ (present_state) begin
//    if(peripheral_reset) begin
//        next_state <= FETCH;
//        present_state <= IDLE;
//        fetch_out               <= 1'b0;
//        en_pc_out               <= 0;
//        en_inst_set_out         <= 0;
//        decode_out              <= 1'b0;            
//        en_inst_decode_out      <= 0;        
//        en_data_mem_out         <= 0;
//        en_reg_file_out         <= 0;
//        execute_out             <= 1'b0;    
//        en_alu_out              <= 0;
//        write_back_out          <= 1'b0; 
//    end
//    else begin
//        present_state = next_state;
        case (present_state)
        //idle state, all values are made zero
            IDLE: begin
                fetch_out               <= 1'b0;
                en_pc_out               <= 0;
                en_inst_set_out         <= 0;
                decode_out              <= 1'b0;            
                en_inst_decode_out      <= 0;   
                en_data_mem_out         <= 0;
                en_reg_file_out         <= 0;
                execute_out             <= 1'b0;    
                en_alu_out              <= 0;
                write_back_out          <= 1'b0;    
                    next_state <= FETCH;
            end
            FETCH: begin
            //fetch state, program counter and instruction set are enabled
                fetch_out               <= 1'b1;
                en_pc_out               <= 1;
                en_inst_set_out         <= 1;
                decode_out              <= 1'b0;            
                en_inst_decode_out      <= 0;  
                en_data_mem_out         <= 0;
                en_reg_file_out         <= 0;
                execute_out             <= 1'b0;   
                en_alu_out              <= 0;
                write_back_out          <= 1'b0;    
                    next_state <= DECODE;
            end
            DECODE: begin
            //decode step, instruction decoder, register file read and data memory read are enabled
                fetch_out               <= 1'b0;
                en_pc_out               <= 0;
                en_inst_set_out         <= 0;
                decode_out              <= 1'b1;            
                en_inst_decode_out      <= 1; 
                en_data_mem_out         <= 1;
                en_reg_file_out         <= 1;
                execute_out             <= 1'b0;    
                en_alu_out              <= 0;
                write_back_out          <= 1'b0;                      
                    next_state <= EXECUTE;
            end
            EXECUTE: begin
            //execute step, Only ALU is enabled
                fetch_out               <= 1'b0;
                en_pc_out               <= 0;
                en_inst_set_out         <= 0;
                decode_out              <= 1'b0;            
                en_inst_decode_out      <= 0;  
                en_data_mem_out         <= 0;
                en_reg_file_out         <= 0;
                execute_out             <= 1'b1;    
                en_alu_out              <= 1;
                write_back_out          <= 1'b0;
                    next_state <= WRITE_BACK;
            end        
            WRITE_BACK: begin
            //Write back step, register file write and data memory write are enabled
                fetch_out               <= 1'b0;
                en_pc_out               <= 0;
                en_inst_set_out         <= 0;
                decode_out              <= 1'b0;            
                en_inst_decode_out      <= 0;   
                execute_out             <= 1'b0;    
                en_alu_out              <= 0;
                write_back_out          <= 1'b1;
                en_reg_file_out         <= 1;
                en_data_mem_out         <= 1;    
                    next_state <= FETCH;
            end
            default : begin
                fetch_out               <= 1'b0;
                en_pc_out               <= 0;
                en_inst_set_out         <= 0;
                decode_out              <= 1'b0;            
                en_inst_decode_out      <= 0;   
                en_data_mem_out         <= 0;
                en_reg_file_out         <= 0;
                execute_out             <= 1'b0;    
                en_alu_out              <= 0;
                write_back_out          <= 1'b0;    
                    next_state <= FETCH;
            end
        endcase
    end
//end
endmodule
