`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:22 11/05/2024 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input clk, 
    input reset,    
    input enablePC, // PC 使能信号
    input [31:0] NPC, // PC地址输入
    output [31:0] IF_instr, // 输出指令
    output [31:0] IF_PC // 输出PC地址
    );

    PC pc(
        .clk(clk),
        .reset(reset),
        .enable(enablePC),
        .NPC(NPC),
        .PC(IF_PC)
    );

    IM im(
        .PC(IF_PC),
        .instr(IF_instr)
    );

endmodule
