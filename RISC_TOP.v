`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2023 11:29:39
// Design Name: 
// Module Name: RISC_top
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


module RISC_top(
//    input         clk_in1_p,
//    input         clk_in1_n,
//    input         reset

    input         CLOCK,
    input         peripheral_reset,
    
    output      [4:0]  pc_out,
    output      [31:0] alu_result
    );    

//clk_wiz_0 CLOCKIP_Instance
//   (
//    // Clock out ports
//    .clk_out1(CLOCK),     // output clk_out1
//    // Status and control signals
//    .reset(reset), // input reset
//    .locked(dcm_locked),       // output locked
//   // Clock in ports
//    .clk_in1_p(clk_in1_p),    // input clk_in1_p
//    .clk_in1_n(clk_in1_n)    // input clk_in1_n
//);

//proc_sys_reset_0 RESETIP_instance (
//  .slowest_sync_clk(CLOCK),          // input wire slowest_sync_clk
//  .ext_reset_in(reset),                  // input wire ext_reset_in
//  .aux_reset_in(1'b1),                  // input wire aux_reset_in
//  .mb_debug_sys_rst(1'b0),          // input wire mb_debug_sys_rst
//  .dcm_locked(dcm_locked),                      // input wire dcm_locked
//  .mb_reset(),                          // output wire mb_reset
//  .bus_struct_reset(),          // output wire [0 : 0] bus_struct_reset
//  .peripheral_reset(peripheral_reset),          // output wire [0 : 0] peripheral_reset
//  .interconnect_aresetn(),  // output wire [0 : 0] interconnect_aresetn
//  .peripheral_aresetn()      // output wire [0 : 0] peripheral_aresetn
//);  
//wire [31:0] alu_result;
//wire [4:0] pc_out;
//wire [31:0] alu_input_1;
//wire [31:0] alu_input_2;
//wire [31:0] wd_mux_output;
//wire [4:0] write_addr_data_mem_out;
//wire [31:0] read_data_reg_file_2_out;
//wire [31:0] instruction_out;
//wire halt;
//vio_0 VirtualIO_instance (
//  .clk(CLOCK),              // input wire clk
//  .probe_in0(alu_result),  // input wire [31 : 0] probe_in0
//  .probe_in1(pc_out), // input wire [4 : 0] probe_in1
//  .probe_out0(halt)  // output wire [0 : 0] probe_out0
//);   

//ila_0 your_instance_name (
//	.clk(CLOCK), // input wire clk


//	.probe0(alu_result), // input wire [31:0]  probe0  
//	.probe1(alu_input_1), // input wire [31:0]  probe1 
//	.probe2(alu_input_2), // input wire [31:0]  probe2 
//	.probe3(wd_mux_output), // input wire [31:0]  probe3 
//	.probe4(pc_out), // input wire [4:0]  probe4 
//	.probe5(write_addr_data_mem_out), // input wire [4:0]  probe5 
//	.probe6(read_data_reg_file_2_out), // input wire [31:0]  probe6 
//	.probe7(instruction_out) // input wire [31:0]  probe7
//);
//CONECTIONS FROM PROGRAM COUNTER 
wire [4:0] pc_to_inst_set__pc;
assign pc_out = pc_to_inst_set__pc;
//CONECTIONS FROM INSTRUCTION DECODER 
wire  [4:0]  inst_decode_to_reg__read_addr_1;
wire  [4:0] inst_decode_to_reg__read_addr_2;
wire [4:0] inst_decode_to_reg__write_addr;
wire [31:0] inst_decode_to_alu_mux__immediate_1;
wire [12:0] inst_decode_to_pc_cell__immediate_branch;
wire [6:0] inst_decode_to_alu__opcode;
wire [2:0] inst_decode_to_alu__func3;
wire [6:0] inst_decode_to_alu__func7;

wire inst_decode_to_alu_mux__alu_mux_sel;
wire inst_decode_to_wd_mux__wd_sel;
wire inst_decode_to_pc__branch_op;
wire inst_decode_to_reg__write_en;
wire inst_decode_to_reg__read_in;
wire inst_decode_to_data_mem__write_en;
wire inst_decode_to_data_mem__read_en;

//CONNECTIONS FROM REGISTER FILE
wire [31:0] reg_to_alu__read_data_1;
wire [31:0] reg_to_alu_mux_to_data_mem__read_data_2;
assign alu_input_1 = reg_to_alu__read_data_1;
assign read_data_reg_file_2_out =  reg_to_alu_mux_to_data_mem__read_data_2;
//CONNECTIONS FROM ALU
wire [31:0] alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output;
assign alu_result = alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output;
//CONNECTIONS FROM DATA MEMORY
wire [31:0] data_mem_to_wd_mux__read_data;

//CONNECTIONS FROM MUX
wire [31:0] alu_mux_to_alu__input_2;
assign alu_input_2 = alu_mux_to_alu__input_2;
wire [31:0] wd_mux_to_reg__wd_output;
assign wd_mux_output = wd_mux_to_reg__wd_output;
//CONNECTIONS FROM INSTRUCTION SET
wire [31:0] Inst_set_to_inst_decode__inst_input;
assign instruction_out = Inst_set_to_inst_decode__inst_input;
//CONNECTIONS FROM CONTROL ENABLE
wire cont_enable_to_inst_set__en_inst_set; 
wire cont_enable_to_inst_decode__en_inst_decode; 
wire cont_enable_to_data_mem__en_data_mem; 
wire cont_enable_to_pc__en_pc;       
wire cont_enable_to_alu__en_alu;      
wire cont_enable_to_reg_file__en_reg_file; 
wire cont_enable_to_inst_decode__DECODE;
wire cont_enable_to_inst_decode__WRITE_BACK;

//CONNECTIONS FROM DATA MEMORY CELL
wire [4:0] data_mem_cell_to_data_mem__addr;
assign write_addr_data_mem_out = data_mem_cell_to_data_mem__addr;
//CONNECTIONS FROM PROGRAM COUNTER CELL
wire [4:0] pc_cell_to_pc__immediate_branch_out;

Program_imm_branch Program_counter_cell_1(
    .immediate_branch_in(inst_decode_to_pc_cell__immediate_branch),
    .Clock(CLOCK),
    
    .immediate_branch_pc_out(pc_cell_to_pc__immediate_branch_out)
);

PROGRAM_COUNTER program_counter (
    .Immediate_branch_in(pc_cell_to_pc__immediate_branch_out),
    .branch_op(inst_decode_to_pc__branch_op),
    .alu_result_in(alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output),
    .peripheral_reset(peripheral_reset),
    .en_pc(cont_enable_to_pc__en_pc),
    .Clock(CLOCK),
    .pc_out(pc_to_inst_set__pc)
);

CONTROL_ENABLE control_enable (
    .Clk(CLOCK),
    .peripheral_reset(peripheral_reset),
    .halt(halt),
    
    .en_inst_set_out(cont_enable_to_inst_set__en_inst_set),
    .en_inst_decode_out(cont_enable_to_inst_decode__en_inst_decode),
    .en_data_mem_out(cont_enable_to_data_mem__en_data_mem),
    .en_pc_out(cont_enable_to_pc__en_pc),
    .en_alu_out(cont_enable_to_alu__en_alu),
    .en_reg_file_out(cont_enable_to_reg_file__en_reg_file),
    .decode_out(cont_enable_to_inst_decode__DECODE),
    .write_back_out(cont_enable_to_inst_decode__WRITE_BACK),
    .fetch_out(),
    .execute_out()
);

INSTRUCTION_SET instruction_set(
    .pc_in(pc_to_inst_set__pc),
//    .peripheral_reset(peripheral_reset),
    .Clock(CLOCK),
    .enable_inst_set(cont_enable_to_inst_set__en_inst_set),
    .inst_out_wire(Inst_set_to_inst_decode__inst_input)
);
INSTRUCTION_DECODER instruction_decoder(
    .inst_in(Inst_set_to_inst_decode__inst_input),
    .decode_in(cont_enable_to_inst_decode__DECODE),
    .write_back_in(cont_enable_to_inst_decode__WRITE_BACK),
    
    .Clock(CLOCK),
    .peripheral_reset(peripheral_reset),
    .en_inst_decode(cont_enable_to_inst_decode__en_inst_decode),
    
    .Opcode_out(inst_decode_to_alu__opcode),
    .func3_out(inst_decode_to_alu__func3),
    .func7_out(inst_decode_to_alu__func7),
    .immediate_1_out(inst_decode_to_alu_mux__immediate_1),
    .immediate_branch_out(inst_decode_to_pc_cell__immediate_branch),
    .read_addr_1_out(inst_decode_to_reg__read_addr_1),
    .read_addr_2_out(inst_decode_to_reg__read_addr_2),
    .write_addr_out(inst_decode_to_reg__write_addr),
    
    .alu_mux_sel_out(inst_decode_to_alu_mux__alu_mux_sel),
    .wd_sel_out(inst_decode_to_wd_mux__wd_sel),
    .branch_op_out(inst_decode_to_pc__branch_op),
    .reg_file_write_en_out(inst_decode_to_reg__write_en),
    .reg_file_read_en_out(inst_decode_to_reg__read_in),
    .data_memory_read_en_out(inst_decode_to_data_mem__read_en),
    .data_memory_write_en_out(inst_decode_to_data_mem__write_en)
); 

REGISTER_FILE  register_file (
    .read_addr_1_in(inst_decode_to_reg__read_addr_1),
    .read_addr_2_in(inst_decode_to_reg__read_addr_2),
    .write_addr_in(inst_decode_to_reg__write_addr),
    .write_data_in(wd_mux_to_reg__wd_output),
    .write_en_in(inst_decode_to_reg__write_en),
    .read_en_in(inst_decode_to_reg__read_in),
    
//    .peripheral_reset(peripheral_reset),
    .Clock(CLOCK),
    .en_reg_file(cont_enable_to_reg_file__en_reg_file),
    
    .read_data_1_out_wire(reg_to_alu__read_data_1),
    .read_data_2_out_wire(reg_to_alu_mux_to_data_mem__read_data_2)
);

Data_mem_addr Data_mem_addr_1 (
    .alu_result_in(alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output),
    .Clock(CLOCK),
    .data_mem_addr_out(data_mem_cell_to_data_mem__addr)
);

DATA_MEMORY  data_memory(
    .addr_in(data_mem_cell_to_data_mem__addr),
    .write_data_in(reg_to_alu_mux_to_data_mem__read_data_2),
    .read_en_in(inst_decode_to_data_mem__read_en),
    .write_en_in(inst_decode_to_data_mem__write_en),
    
    .Clock(CLOCK),
//    .peripheral_reset(peripheral_reset),
    .en_data_mem(cont_enable_to_data_mem__en_data_mem),
    
    .read_data_out_wire(data_mem_to_wd_mux__read_data)
);

ALU alu(
    .alu_input_1_in(reg_to_alu__read_data_1),
    .alu_input_2_in(alu_mux_to_alu__input_2 ),
    .Opcode_in(inst_decode_to_alu__opcode),
    .func3_in(inst_decode_to_alu__func3),
    .func7_in(inst_decode_to_alu__func7),
    
    .Clock(CLOCK),
    .peripheral_reset(peripheral_reset),
    .en_alu(cont_enable_to_alu__en_alu),
    
    .alu_result_out(alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output)
);

MUX_WD mux_wd(
    .wd_sel(inst_decode_to_wd_mux__wd_sel),
    .wd_input_0(alu_to_wd_mux_to_data_mem_cell_to_pc__alu_output),
    .wd_input_1(data_mem_to_wd_mux__read_data),
    .wd_output(wd_mux_to_reg__wd_output)
);

MUX_ALU_input mux_alu_input(
    .alu_mux_sel(inst_decode_to_alu_mux__alu_mux_sel),
    .alu_mux_input_0(reg_to_alu_mux_to_data_mem__read_data_2),
    .alu_mux_input_1(inst_decode_to_alu_mux__immediate_1),
    .alu_mux_output(alu_mux_to_alu__input_2)
); 

endmodule
