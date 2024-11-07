`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:13:28 11/06/2024 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [3:0] ALUOp,
    output reg [31:0] ALURes
    );

    always @(*)begin
        case (ALUOp)
            `aluAdd:ALURes = SrcA+SrcB;
            `aluSub:ALURes = SrcA-SrcB;
            `aluOr:ALURes = SrcA | SrcB;
            `aluAnd:ALURes = SrcA & SrcB;
            `aluLui:ALURes = SrcB << 16; // 高位覆盖
            default:ALURes = 32'bz;
        endcase
    end
endmodule
