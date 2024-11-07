`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:37 11/05/2024 
// Design Name: 
// Module Name:    EX 
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
module EX(
    input clk,
    input reset,
    input [31:0] EX_instr,
    input [31:0] EX_imm32,
    input [31:0] EX_WD,
    input [31:0] EX_RD1_forward,
    input [31:0] EX_RD2_forward,
    output [31:0] EX_MEM_RES,
    output [31:0] EX_MEM_WD,
    output [31:0] EX_MEM_RD2,
    output [1:0] EX_NEW
    // output EX_A2_USE
    );

    // always @(posedge clk)begin
    //     if (reset)begin
    //         MEM_RES = 32'b0;
    //         MEM_WD = 32'b0;
    //         MEM_RD2 = 32'b0;
    //     end
    //     else begin

    //     end
    // end
    wire [3:0] ALUOp;
    wire ALU_B_Sel;
    wire WD_Sel;
    CTRL ex_control(
        .instr(EX_instr),
        .ALUOp(ALUOp),
        .ALU_B_Sel(ALU_B_Sel),
        .WD_Sel(WD_Sel),
        .EX_NEW(EX_NEW)
    );

    wire [31:0] SrcA;
    wire [31:0] SrcB;
    wire [31:0] ALURes;
    assign SrcA = EX_RD1_forward;
    assign SrcB = (ALU_B_Sel == 1) ? EX_imm32 : 
                                    EX_RD2_forward;
    ALU alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUOp(ALUOp),
        .ALURes(ALURes)
    );

    assign EX_MEM_RES = ALURes;
    assign EX_MEM_WD = (WD_Sel == 1) ? EX_WD :
                                       ALURes;
    assign EX_MEM_RD2 = EX_RD2_forward;

endmodule
