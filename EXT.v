`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:54 11/05/2024 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    input ExtControl,
    output [31:0] imm32
    );

    // ExtControl为0时,作符号扩展,为1时,作零扩展
    assign imm32 = (ExtControl == 1'b0) ? {{16{imm16[15]}}, imm16} :
                                       {{16{1'b0}}, imm16};
endmodule
