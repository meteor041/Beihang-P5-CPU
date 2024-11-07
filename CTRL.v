`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:50:19 11/05/2024 
// Design Name: 
// Module Name:    CTRL 
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
`include "constants.v"
module CTRL(
    input [31:0] instr,

    // ID(解码)阶段
    input zero,
    output Branch,
    output Jal,
    output Jr,
    output ExtControl,
    output Sel_ID_WD,
    output [4:0] ID_A3,
    output [1:0] ID_A1_USE,
    output [1:0] ID_A2_USE,

    // EX(执行)阶段
    output [3:0] ALUOp,
    output ALU_B_Sel,
    output WD_Sel,
    output [1:0] EX_NEW,

    // MEM(存储)阶段
    output MEM_WE, // 选择是否写入Memory
    output MEM_Sel, // 选择是否将Memory读出值向后传递
    output [1:0] MEM_A2_NEW
    );

    // 输入指令
    wire [5:0] op;
    wire [5:0] funct;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;

    assign op = instr[31:26];
    assign funct = instr[5:0];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];

    // 指令类型
    wire R;
    wire add, sub, ori, lw, sw, beq, lui, jal, jr, nop;
    assign R = (op == 6'b0) ? 1 : 0;
    assign add = (R && funct == 6'b100000) ? 1 : 0;
    assign sub = (R && funct == 6'b100010) ? 1 : 0;
    assign ori = (op == 6'b001101) ? 1 : 0;
    assign lw = (op == 6'b100011) ? 1 : 0;
    assign sw = (op == 6'b101011) ? 1 : 0;
    assign beq = (op == 6'b000100) ? 1 : 0;
    assign lui = (op == 6'b001111) ? 1 : 0;
    assign jal = (op == 6'b000011) ? 1 : 0;
    assign jr = (R && funct == 6'b001000) ? 1 : 0;
    assign nop = (R && funct == 6'b000000) ? 1 : 0;

    // ID(解码)阶段
    assign Branch = (beq & zero) ? 1 : 0;
    assign Jal = jal ? 1 : 0;
    assign Jr = jr ? 1 : 0;
    assign ExtControl = (lw || sw || beq || lui) ? 1'b0 :
                        (ori) ? 1'b1 :
                        1'bz;
    assign Sel_ID_WD = jal ? 1'b1 : 1'b0;
    assign ID_A3 = jal ? 31 : 
                   (add || sub) ? rd : 
                   (lui || ori || lw)? rt :
                   0; // 这里$0可以代表不写入(EnWrite=0)
    assign ID_A1_USE = (beq || jr) ? 2'd0 :
                        (add || sub || ori || lw || sw ) ? 2'd1:
                        2'd3;
    assign ID_A2_USE = (beq) ? 2'd0:
                        (add || sub) ? 2'd1 :
                        (sw) ? 2'd2 :
                        2'd3;

    // assign ID_A1_USE = (add || sub || ori || lw || sw || beq || jr) ? 1'b1 : 1'b0;
    // assign ID_A2_USE = (add || sub || beq || sw) ? 1'b1 : 1'b0;
    // EX(执行)阶段
    assign ALUOp = (add || lw || sw) ? `aluAdd :
                    (ori) ? `aluOr :
                    (sub) ? `aluSub :
                    (lui) ? `aluLui :
                    4'bz;
    assign ALU_B_Sel = (ori || lw || sw || lui) ? 1'b1 :
                        (add || sub) ?  1'b0 :
                        1'bz;
    assign WD_Sel = (jal) ? 1 : 0;
    assign EX_NEW = (add || sub || ori || lui) ? 2'd1 :
                    (lw || jal) ? 2'd2 :
                    2'd0;

    // MEM(存储)阶段
    assign MEM_WE = (sw) ? 1 : 0;
    assign MEM_Sel = (lw) ? 1 : 0;
    assign MEM_A2_NEW = (lw) ? 2'd1 : 2'd0;
endmodule

