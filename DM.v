`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:59:19 11/06/2024 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input WE,
    input [31:0] addr,
    input [31:0] WD,
    input [31:0] PC,
    output [31:0] RD
    );

    reg[31:0] ram[4095:0];
    integer i;
    initial begin
        for (i = 0; i < 4096; i=i+1)begin
                ram[i] = 32'b0;
            end
    end
    always @(posedge clk)begin
        if (reset) begin
            for (i = 0; i < 4096; i=i+1)begin
                ram[i] = 32'b0;
            end
        end
        else if (WE == 1) begin
            ram[addr >> 2] = WD;
            $display("%d@%h: *%h <= %h", $time, PC, addr, WD);
        end
    end

    assign RD = ram[addr[13:2]];

endmodule
