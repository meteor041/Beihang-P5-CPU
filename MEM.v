`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:54:48 11/06/2024 
// Design Name: 
// Module Name:    MEM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM(
    input clk,
    input reset,
    input [31:0] MEM_PC,
    input [31:0] MEM_instr,
    input [31:0] MEM_WD,
    input [31:0] MEM_RES,
    input [31:0] MEM_RD2_forward,
    input [4:0] MEM_A3,
    output [4:0] MEM_WB_A3,
    output [31:0] MEM_WB_WD,
    output [1:0] MEM_A2_NEW
    );

    wire WE;
    wire [31:0] RD;
    wire MEM_Sel;

    CTRL mem_ctrl(
        .instr(MEM_instr),
        .MEM_WE(WE), // 写入Memory的使能信号
        .MEM_Sel(MEM_Sel),
        .MEM_A2_NEW(MEM_A2_NEW)
    );

    assign MEM_WB_WD = (MEM_Sel == 1) ? RD : MEM_WD;
    assign MEM_WB_A3 = MEM_A3;

    DM dm(
        .clk(clk),
        .reset(reset),
        .WE(WE),
        .addr(MEM_RES),
        .WD(MEM_RD2_forward),
        .PC(MEM_PC),
        .RD(RD)
    );


endmodule
