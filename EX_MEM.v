`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:50:23 11/06/2024 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
    input clk,
    input reset,
    input flush,
    input [31:0] EX_PC,
    input [31:0] EX_instr,
    input [4:0] EX_A3,
    input [31:0] EX_WD,
    input [31:0] EX_RES,
    input [31:0] EX_RD2,
    output reg [31:0] MEM_PC,
    output reg [31:0] MEM_instr,
    output reg [4:0] MEM_A3,
    output reg [31:0] MEM_WD,
    output reg [31:0] MEM_RES,
    output reg [31:0] MEM_RD2
    );

    initial begin
        MEM_PC = 32'b0;
        MEM_instr= 32'b0;
        MEM_A3 = 5'b0;
        MEM_WD = 32'b0;
        MEM_RES= 32'b0;
        MEM_RD2= 32'b0;
    end
    always @(posedge clk)begin
        if (reset || flush)begin
            MEM_PC = 32'b0;
            MEM_instr= 32'b0;
            MEM_A3 = 5'b0;
            MEM_WD = 32'b0;
            MEM_RES= 32'b0;
            MEM_RD2= 32'b0;
        end
        else begin
            MEM_PC = EX_PC;
            MEM_instr = EX_instr;
            MEM_A3 = EX_A3;
            MEM_WD = EX_WD;
            MEM_RES = EX_RES;
            MEM_RD2 = EX_RD2;
        end
    end
endmodule
