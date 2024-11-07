`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:43 11/05/2024 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] IF_PC,
    input [31:0] ID_PC,
    input [25:0] ID_imm26,
    input [31:0] imm32,
    input [31:0] Jr_Reg_Data,
    input Branch,
    input Jal,
    input Jr,
    output [31:0] NPC
    );

    wire [31:0] PC_PLUS_FOUR;
    assign PC_PLUS_FOUR = ID_PC + 4;
    assign NPC = (Branch == 1) ? PC_PLUS_FOUR + (imm32 << 2) :
                 (Jal == 1) ? {PC_PLUS_FOUR[31:28], ID_imm26, 2'b0} :
                 (Jr == 1) ? Jr_Reg_Data :
                 IF_PC + 4;
    // assign NPC = IF_PC + 4;
endmodule
