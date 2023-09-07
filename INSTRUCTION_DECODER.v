`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2023 10:50:35
// Design Name: 
// Module Name: INSTRUCTION _DECODER
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

//The instruction decoder takes in the instruction and decides which instruction goes where and which select lines of the MUX must be made on
module INSTRUCTION_DECODER (  
    input   [31:0]  inst_in,
    input           peripheral_reset,
    input           Clock,
    input           en_inst_decode,
    input           decode_in,
    input           write_back_in,
    
    output  reg [6:0]  Opcode_out,
    output  reg [2:0]  func3_out,
    output  reg [6:0]  func7_out,
    output  reg [31:0] immediate_1_out,
    output  reg [12:0] immediate_branch_out,
    output  reg [4:0]  read_addr_1_out,
    output  reg [4:0]  read_addr_2_out,
    output  reg [4:0]  write_addr_out,
    
    output  reg       alu_mux_sel_out,
    output  reg       wd_sel_out,
    output  reg       branch_op_out,
    output  reg       reg_file_write_en_out,
    output  reg       reg_file_read_en_out,
    output  reg       data_memory_read_en_out,
    output  reg       data_memory_write_en_out
    );
    
    
    
//R-type: performs arithmetic operations between two operands which are obtained from register file. The result is written back in the register file.
localparam R_TYPE = 7'b0110011;
//L-type: Performs arithmetic operation between the immediate value and the value taken from register and the result is the address of the data memory, 
//content from data memory goes to register file
localparam L_TYPE = 7'b0000011;
//I-type: performs arithmetic operation with the immediate value coming from instruction set with the value stored in register file and puts the result
//in register file
localparam I_TYPE = 7'b0010011;
//S_type: Performs arithmatic operation between immediate value and the value in register and result is the adddress for data memory, content from register 
//file is loaded in the data memory
localparam S_TYPE = 7'b0100011;
//SB-type: ALU performs operation on operands from register file and the branch determines whether to change pc value by 1 or by the immediate value
localparam SB_TYPE = 7'b1100011;    
    

//This always block splits the information based on the Opcode into various parts like function3, function7, immediate value
//immediate branch and others
//always @ (reset or en_inst_decode or inst_in) begin
always @ (negedge Clock or posedge peripheral_reset) begin
    if (peripheral_reset) begin
         Opcode_out             <= 7'b0;
         func3_out              <= 0;
         func7_out              <= 0;
         immediate_1_out        <= 0;
         immediate_branch_out   <= 0;
         read_addr_1_out        <= 0;
         read_addr_2_out        <= 0;
         write_addr_out         <= 0;
         
        alu_mux_sel_out         <= 1'b0;
        wd_sel_out              <= 1'b0;
        branch_op_out           <= 1'b0;
    end
    else begin
        if(en_inst_decode) begin
        //Since Opsode and func3 are common for all instructions, they are written separetely 
            Opcode_out <= inst_in[6:0];
            func3_out  <= inst_in[14:12];
            case(inst_in[6:0])
            R_TYPE: begin                               
            //R-type Opcode_out
                func7_out               <= inst_in[31:25];
                read_addr_1_out         <= inst_in[24:20];
                read_addr_2_out         <= inst_in[19:15];
                write_addr_out          <= inst_in[11:7];
                immediate_1_out         <= 0;
                immediate_branch_out    <= 0;
           //Determining the select lines for the muxes     
                alu_mux_sel_out <= 1'b0;
                wd_sel_out      <= 1'b0;
                branch_op_out   <= 1'b0;
            end
            L_TYPE: begin                               
            //L-type (read from data memory and write in reg file)
                immediate_1_out <= inst_in[31:20];
                read_addr_1_out <= inst_in[19:15];
                write_addr_out  <= inst_in[11:7];
                read_addr_2_out        <= 0;
                immediate_branch_out   <= 0;
                func7_out              <= 0;
            //Determining the select lines for the muxes      
                alu_mux_sel_out <= 1'b1;
                wd_sel_out      <= 1'b1;
                branch_op_out   <= 1'b0; 
            end
            I_TYPE: begin                               
            //I-type (read from data memory and write in reg file)
                immediate_1_out <= inst_in[31:20];
                read_addr_1_out <= inst_in[19:15];
                write_addr_out  <= inst_in[11:7];
                read_addr_2_out        <= 0;
                immediate_branch_out   <= 0;
                func7_out              <= 0;
            //Determining the select lines for the muxes      
                alu_mux_sel_out <= 1'b1;
                wd_sel_out      <= 1'b0;
                branch_op_out   <= 1'b0; 
            end
            S_TYPE: begin                              
            // S-type (write into memory from reg file)
                immediate_1_out <= {20'b0, inst_in[31:25], inst_in[11:7]};
                read_addr_1_out <= inst_in[24:20];
                read_addr_2_out <= inst_in[19:15];
                immediate_branch_out   <= 0;
                func7_out              <= 0;
                write_addr_out         <= 0;
            //Determining the select lines for the muxes       
                alu_mux_sel_out <= 1'b1;
                wd_sel_out      <= 1'b0;
                branch_op_out   <= 1'b0;
            end
            SB_TYPE: begin                               
            //SB-type Branch instruction which increments pc if branch is taken)
                immediate_branch_out    <= {inst_in[31], inst_in[7], inst_in[30:25], inst_in[11:8], 1'b0};
                read_addr_1_out         <= inst_in[24:20];
                read_addr_2_out         <= inst_in[19:15];
                immediate_1_out        <= 0;
                write_addr_out         <= 0;
                func7_out              <= 0;
            //Determining the select lines for the muxes       
                alu_mux_sel_out             <= 1'b0;
                wd_sel_out                  <= 1'b0;
                branch_op_out               <= 1'b1;
            end
            default : begin
                Opcode_out             <= 7'b0;
                 func3_out              <= 0;
                 func7_out              <= 0;
                 immediate_1_out        <= 0;
                 immediate_branch_out   <= 0;
                 read_addr_1_out        <= 0;
                 read_addr_2_out        <= 0;
                 write_addr_out         <= 0;

                alu_mux_sel_out         <= 1'b0;
                wd_sel_out              <= 1'b0;
                branch_op_out           <= 1'b0;
            end
            endcase
        end
    end
end

//The always block determines which write enable pin to activate when the write back step is to be performed
always @(negedge Clock or posedge peripheral_reset) begin
    if(peripheral_reset) begin
        reg_file_write_en_out    <= 1'b0;
        data_memory_write_en_out <= 1'b0;
    end
    else begin
        case (inst_in[6:0]) 
            R_TYPE: begin
            //We write into the register file only
                if(write_back_in) begin
                    reg_file_write_en_out    <= 1'b1;
                    data_memory_write_en_out <= 1'b0;
                end
                else begin
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b0;
                end
            end
            L_TYPE: begin
            //We write into the register file
                if(write_back_in) begin
                    reg_file_write_en_out    <= 1'b1;
                    data_memory_write_en_out <= 1'b0;
                end
                else begin
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b0;
                end
            end
            //we write into register file
            I_TYPE: begin
                if(write_back_in) begin
                    reg_file_write_en_out    <= 1'b1;
                    data_memory_write_en_out <= 1'b0;
                end
                else begin
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b0;
                end
            end
            S_TYPE: begin
            //we write into data memory
                if(write_back_in) begin
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b1;
                end
                else begin
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b0;
                end
            end
            SB_TYPE: begin
            //we dont write in either
                    reg_file_write_en_out    <= 1'b0;
                    data_memory_write_en_out <= 1'b0;
            end
            default: begin
                reg_file_write_en_out    <= 1'b0;
                data_memory_write_en_out <= 1'b0;
            end
        endcase
    end
end

//This always block decides which read enable pin to enable during the decode step
always @ (negedge Clock or posedge peripheral_reset) begin
    if(peripheral_reset) begin 
         reg_file_read_en_out    <= 1'b0;
         data_memory_read_en_out <= 1'b0;
    end
    else begin
        case (inst_in[6:0]) 
            R_TYPE: begin
            //We read from registe file
                if(decode_in) begin
                    reg_file_read_en_out    <= 1'b1;
                    data_memory_read_en_out <= 1'b0;
                end
                else begin
                    reg_file_read_en_out    <= 1'b0;
                    data_memory_read_en_out <= 1'b0;
                end
            end
            //We read from both register file and data memory
            L_TYPE: begin
                if(decode_in) begin
                    reg_file_read_en_out    <= 1'b1;
                    data_memory_read_en_out <= 1'b1;
                end
                else begin
                    reg_file_read_en_out    <= 1'b0;
                    data_memory_read_en_out <= 1'b0;
                end
            end
            I_TYPE: begin
            //We read from register file
                if(decode_in) begin
                    reg_file_read_en_out    <= 1'b1;
                    data_memory_read_en_out <= 1'b0;
                end
                else begin
                    reg_file_read_en_out    <= 1'b0;
                    data_memory_read_en_out <= 1'b0;
                end
            end
            S_TYPE: begin
            //we read from register file 
                if(decode_in) begin
                    reg_file_read_en_out    <= 1'b1;
                    data_memory_read_en_out <= 1'b0;
                end
                else begin
                    reg_file_read_en_out    <= 1'b0;
                    data_memory_read_en_out <= 1'b0;
                end
            end
            SB_TYPE: begin
            //We read from register file 
                if(decode_in) begin
                    reg_file_read_en_out    <= 1'b1;
                    data_memory_read_en_out <= 1'b0;
                end
                else begin
                    reg_file_read_en_out    <= 1'b0;
                    data_memory_read_en_out <= 1'b0;
                end
            end
            default: begin
                 reg_file_read_en_out    <= 1'b0;
                 data_memory_read_en_out <= 1'b0;
            end
        endcase
    end
end
endmodule
