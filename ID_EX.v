`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:47:58 11/05/2024 
// Design Name: 
// Module Name:    ID_EX 
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
  module ID_EX(
    input clk,
    input reset,
    input enable,
    input flush, // 冲洗信号
    input [31:0] ID_PC,
    input [31:0] ID_instr,
    input [31:0] ID_RD1,
    input [31:0] ID_RD2,
    input [31:0] ID_imm32,
    input [4:0] ID_A3,
    input [31:0] ID_WD,
    output reg [31:0] EX_PC,
    output reg [31:0] EX_instr,
    output reg [31:0] EX_RD1,
    output reg [31:0] EX_RD2,
    output reg [31:0] EX_imm32,
    output reg [4:0] EX_A3,
    output reg [31:0] EX_WD
    );

    initial begin
        EX_PC = 32'b0;
        EX_instr = 32'b0;
        EX_RD1 = 32'b0;
        EX_RD2 = 32'b0;
        EX_imm32 = 32'b0;
        EX_A3 = 5'b0;
        EX_WD = 32'b0;
    end

    always @(posedge clk)begin
      if (reset || flush)begin
        EX_PC = 32'b0;
        EX_instr = 32'b0;
        EX_RD1 = 32'b0;
        EX_RD2 = 32'b0;
        EX_imm32 = 32'b0;
        EX_A3 = 5'b0;
        EX_WD = 32'b0;
      end
      else begin
        EX_PC <= ID_PC;
        EX_instr <= ID_instr;
        EX_RD1 <= ID_RD1;
        EX_RD2 <= ID_RD2;
        EX_imm32 <= ID_imm32;
        EX_A3 <= ID_A3;
        EX_WD <= ID_WD;
      end
    end

endmodule
