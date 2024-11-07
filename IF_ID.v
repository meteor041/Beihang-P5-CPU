`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:42 11/05/2024 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
    input clk,
    input reset,
    input enable,
    input [31:0] IF_PC,
    input [31:0] IF_instr,
    output reg [31:0] ID_PC,
    output reg [31:0] ID_instr
    );
    initial begin
        ID_PC = 32'h3000;
        ID_instr = 32'b0;
    end
    always @(posedge clk)begin
        if (reset)begin
            ID_PC <= 32'h3000;
            ID_instr <= 32'h0;
        end
        else if (enable)begin
            ID_PC <= IF_PC;
            ID_instr <= IF_instr;
        end
    end
endmodule
