`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:05 11/05/2024 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] PC,
    output [31:0] instr
    );

    // Instruction Memory
    reg[31:0] rom[0:4095];
    integer i;
    initial begin
      for (i = 0; i < 4096; i=i+1)begin
        rom[i] = 32'b0;
      end
      $readmemh("code.txt", rom);
    end
    
    wire [31:0] PC_minus_three_thousand;
    wire [13:2] addr;
    assign PC_minus_three_thousand = PC - 32'h3000;
    // assign addr = PC_minus_three_thousand[13:2];
    assign instr = rom[PC_minus_three_thousand >> 2];
endmodule
