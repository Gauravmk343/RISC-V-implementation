`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2023 11:44:59
// Design Name: 
// Module Name: ALU
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

//The ALU performs the operation between the operands which might come from register file
// or data memory or immediate value
module ALU(
    input [31:0] alu_input_1_in,
    input [31:0] alu_input_2_in,
    input [6:0]  Opcode_in,
    input [2:0]  func3_in,
    input [6:0]  func7_in,
    input        peripheral_reset,
    input        en_alu,
    input        Clock,
    
    output reg [31:0] alu_result_out    
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

//always @ (peripheral_reset or en_alu)  begin
always @ (negedge Clock or posedge peripheral_reset)  begin
    if(peripheral_reset) begin
        alu_result_out <= 0;
    end
    else begin
        if(en_alu) begin       
            case (Opcode_in)
            //Sorting based on Opcode
                R_TYPE: begin
                    case(func7_in)
                        7'b0: begin
                            case(func3_in)
                                3'b000: 
                                    alu_result_out <= alu_input_1_in + alu_input_2_in;
                                3'b001:
                                    alu_result_out <= alu_input_1_in << alu_input_2_in;
                                3'b010:
                                    alu_result_out <= (alu_input_1_in>alu_input_2_in)?1:0; 
                                3'b011:
                                    alu_result_out <= (alu_input_1_in<alu_input_2_in)?1:0;
                                3'b100:
                                    alu_result_out <= alu_input_1_in ^ alu_input_2_in;
                                3'b101:
                                    alu_result_out <= alu_input_1_in >> alu_input_2_in;
                                3'b110:
                                    alu_result_out <= alu_input_1_in | alu_input_2_in;
                                3'b111:
                                    alu_result_out <= alu_input_1_in & alu_input_2_in;
                            endcase 
                        end  
                        7'b0100000: begin
                            case(func3_in)
                                3'b000:
                                    alu_result_out <= alu_input_1_in - alu_input_2_in;
                                3'b001:
                                    alu_result_out <= alu_input_1_in <<< alu_input_2_in;
                                3'b101:
                                    alu_result_out <= alu_input_1_in >>> alu_input_2_in; 
                            endcase                        
                        end
                    endcase 
                end
                I_TYPE: begin
                    case(func3_in)
                        3'b000: 
                            alu_result_out <= alu_input_1_in + alu_input_2_in;
                        3'b001:
                            alu_result_out <= alu_input_1_in - alu_input_2_in;
                        3'b010:
                            alu_result_out <= (alu_input_1_in>alu_input_2_in)?1:0; 
                        3'b011:
                            alu_result_out <= (alu_input_1_in<alu_input_2_in)?1:0;
                        3'b100:
                            alu_result_out <= alu_input_1_in ^ alu_input_2_in;
                        3'b101:
                            alu_result_out <= alu_input_1_in >> alu_input_2_in;
                        3'b110:
                            alu_result_out <= alu_input_1_in | alu_input_2_in;
                        3'b111:
                            alu_result_out <= alu_input_1_in & alu_input_2_in;
                    endcase 
                end  
                L_TYPE: begin
                    case(func3_in)
                        3'b010:
                             alu_result_out <= alu_input_1_in + alu_input_2_in;
                    endcase
                end
                S_TYPE: begin
                    case(func3_in)
                        3'b010:
                             alu_result_out <= alu_input_1_in + alu_input_2_in;         
                    endcase
                end
                SB_TYPE: begin
                    case(func3_in)
                        3'b000:
                            alu_result_out <= alu_input_1_in ^ alu_input_2_in;
                        3'b001:
                            alu_result_out <= alu_input_1_in | alu_input_2_in;
                        3'b010:
                            alu_result_out <= alu_input_1_in & alu_input_2_in;
    
                    endcase
                end
                default: alu_result_out <= 32'b0;  
            endcase
        end
    end
end
endmodule
