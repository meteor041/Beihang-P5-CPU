`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:34 11/05/2024 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input reset,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input [31:0] PC,
    output [31:0] RD1,
    output [31:0] RD2
    );

    reg [31:0] grf[31:0];
    integer i;
    initial begin
      for (i = 0; i < 32; i=i+1)begin
          grf[i] = 32'b0;
        end
    end
    always @(posedge clk)begin
      if (reset)begin
        for (i = 0; i < 32; i=i+1)begin
          grf[i] = 32'b0;
        end
      end
      else if (A3 != 5'b0)begin
        grf[A3] = WD;
        $display("%d@%h: $%d <= %h", $time, PC, A3, WD);
      end
    end
    assign RD1 = (A1 == A3 && A1 != 0 && !reset) ? WD : grf[A1];
    assign RD2 = (A2 == A3 && A2 != 0 && !reset) ? WD : grf[A2];
endmodule
