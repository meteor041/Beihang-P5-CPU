`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:02 11/05/2024 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

    wire Enable_PC;

    // wire [31:0] NPC;
    wire [31:0] IF_instr;
    wire [31:0] IF_PC;
    wire [31:0] ID_NPC; // ID阶段计算的下一个地址
    IF uvv1(
        .clk(clk),
        .reset(reset),
        .enablePC(Enable_PC),
        .NPC(ID_NPC),
        .IF_instr(IF_instr),
        .IF_PC(IF_PC)
    );


    wire [31:0] ID_PC;
    wire [31:0] ID_instr;
    wire Enable_IF_ID;
    IF_ID uvv2(
        .clk(clk),
        .reset(reset),
        .enable(Enable_IF_ID),
        .IF_PC(IF_PC),
        .IF_instr(IF_instr),
        .ID_PC(ID_PC),
        .ID_instr(ID_instr)
    );

    wire [31:0] ID_RD1_forward;
    wire [31:0] ID_RD2_forward;
    wire [31:0] WB_WD;
    wire [4:0] WB_A3;
    wire [31:0] WB_PC;

    wire [31:0] ID_RD1;
    wire [31:0] ID_RD2;
    wire [31:0] ID_IMM32;
    wire [4:0] ID_A3;// ID阶段的A3,向后传递用
    wire [31:0] ID_WD; // ID阶段的写入数据,向后传递
    wire [1:0] ID_A1_USE; 
    wire [1:0] ID_A2_USE; 
    ID uvv3(
        .clk(clk),
        .reset(reset),
        .IF_PC(IF_PC),
        .ID_PC(ID_PC),
        .ID_instr(ID_instr),
        .ID_RD1_forward(ID_RD1_forward),
        .ID_RD2_forward(ID_RD2_forward),
        .WB_WD(WB_WD),
        .WB_A3(WB_A3),
        .WB_PC(WB_PC),
        .ID_RD1(ID_RD1),
        .ID_RD2(ID_RD2),
        .ID_IMM32(ID_IMM32),
        .ID_A3(ID_A3),
        .ID_WD(ID_WD),
        .ID_NPC(ID_NPC),
        .ID_A1_USE(ID_A1_USE),
        .ID_A2_USE(ID_A2_USE)
    );

    wire Enable_ID_EX;
    wire Flush_ID_EX; // 冲洗信号
    wire [31:0] EX_PC;
    wire [31:0] EX_instr;
    wire [31:0] EX_RD1;
    wire [31:0] EX_RD2;
    wire [31:0] EX_imm32;
    wire [4:0] EX_A3;
    wire [31:0] EX_WD;
    ID_EX uvv4(
        .clk(clk),
        .reset(reset),
        .enable(Enable_ID_EX),
        .flush(Flush_ID_EX), // 冲洗信号
        .ID_PC(ID_PC),
        .ID_instr(ID_instr),
        .ID_RD1(ID_RD1_forward),
        .ID_RD2(ID_RD2_forward),
        .ID_imm32(ID_IMM32),
        .ID_A3(ID_A3),
        .ID_WD(ID_WD),
        .EX_PC(EX_PC),
        .EX_instr(EX_instr),
        .EX_RD1(EX_RD1),
        .EX_RD2(EX_RD2),
        .EX_imm32(EX_imm32),
        .EX_A3(EX_A3),
        .EX_WD(EX_WD)
    );

    wire [31:0] EX_RD1_forward;
    wire [31:0] EX_RD2_forward;
    wire [31:0] EX_MEM_RES;
    wire [31:0] EX_MEM_WD;
    wire [31:0] EX_MEM_RD2;
    wire [1:0] EX_NEW;
    EX uvv5(
        .clk(clk),
        .reset(reset),
        .EX_instr(EX_instr),
        .EX_imm32(EX_imm32),
        .EX_WD(EX_WD),
        .EX_RD1_forward(EX_RD1_forward),
        .EX_RD2_forward(EX_RD2_forward),
        .EX_MEM_RES(EX_MEM_RES),
        .EX_MEM_WD(EX_MEM_WD),
        .EX_MEM_RD2(EX_MEM_RD2),
        .EX_NEW(EX_NEW)
    );

    wire Flush_EX_MEM;
    wire [31:0] MEM_PC;
    wire [31:0] MEM_instr;
    wire [4:0] MEM_A3;
    wire [31:0] MEM_WD;
    wire [31:0] MEM_RES;
    wire [31:0] MEM_RD2;
    EX_MEM uvv6(
        .clk(clk),
        .reset(reset),
        .flush(Flush_EX_MEM),
        .EX_PC(EX_PC),
        .EX_instr(EX_instr),
        .EX_A3(EX_A3),
        .EX_RES(EX_MEM_RES),
        .EX_RD2(EX_MEM_RD2),
        .EX_WD(EX_MEM_WD),
        .MEM_PC(MEM_PC),
        .MEM_instr(MEM_instr),
        .MEM_A3(MEM_A3),
        .MEM_WD(MEM_WD),
        .MEM_RES(MEM_RES),
        .MEM_RD2(MEM_RD2)
    );

    wire [31:0] MEM_RD2_forward;
    wire [4:0] MEM_WB_A3;
    wire [31:0] MEM_WB_WD;
    wire [1:0] MEM_A2_NEW;
    MEM uvv7(
        .clk(clk),
        .reset(reset),
        .MEM_PC(MEM_PC),
        .MEM_instr(MEM_instr),
        .MEM_RES(MEM_RES),
        .MEM_RD2_forward(MEM_RD2_forward),
        .MEM_A3(MEM_A3),
        .MEM_WD(MEM_WD),
        .MEM_WB_A3(MEM_WB_A3),
        .MEM_WB_WD(MEM_WB_WD),
        .MEM_A2_NEW(MEM_A2_NEW)
    );

    // wire [31:0] WB_PC;
    wire [31:0] WB_instr;
    // wire [4:0] WB_A3;
    MEM_WB uvv8(
        .clk(clk),
        .reset(reset),
        .MEM_PC(MEM_PC),
        .MEM_instr(MEM_instr),
        .MEM_A3(MEM_WB_A3),
        .MEM_WD(MEM_WB_WD),
        .WB_PC(WB_PC),
        .WB_instr(WB_instr),
        .WB_A3(WB_A3),
        .WB_WD(WB_WD)
    );

    wire [4:0] ID_A1;
    wire [4:0] ID_A2;
    assign ID_A1 = ID_instr[25:21];
    assign ID_A2 = ID_instr[20:16];
    wire [4:0] EX_A1;
    wire [4:0] EX_A2;
    assign EX_A1 = EX_instr[25:21];
    assign EX_A2 = EX_instr[20:16];
    wire [4:0] MEM_A2;
    assign MEM_A2 = MEM_instr[20:16];
    HAZARD_CTRL uvv9(
        .clk(clk),
        .reset(reset),
        .ID_A1(ID_A1),
        .ID_A2(ID_A2),
        .ID_RD1(ID_RD1),
        .ID_RD2(ID_RD2),
        .ID_A1_USE(ID_A1_USE),
        .ID_A2_USE(ID_A2_USE),
        // ex
        .EX_A1(EX_A1),
        .EX_A2(EX_A2),
        .EX_RD1(EX_RD1),
        .EX_RD2(EX_RD2),
        .EX_NEW(EX_NEW),
        .EX_A3(EX_A3),
        .EX_WD(EX_WD),
        // MEM
        .MEM_A2(MEM_A2),
        .MEM_RD2(MEM_RD2),
        .MEM_A2_NEW(MEM_A2_NEW),
        .MEM_A3(MEM_A3),
        .MEM_WD(MEM_WD),
        // WB
        .WB_A3(WB_A3),
        .WB_WD(WB_WD),
        // 转发
        .ID_RD1_forward(ID_RD1_forward),
        .ID_RD2_forward(ID_RD2_forward),
        .EX_RD1_forward(EX_RD1_forward),
        .EX_RD2_forward(EX_RD2_forward),
        .MEM_RD2_forward(MEM_RD2_forward),
        // Signals
        .Enable_PC(Enable_PC),
        .Enable_IF_ID(Enable_IF_ID),
        .Enable_ID_EX(Enable_ID_EX),
        .Flush_ID_EX(Flush_ID_EX),
        .Flush_EX_MEM(Flush_EX_MEM)
    );
endmodule
