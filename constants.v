`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:55:51 11/05/2024 
// Design Name: 
// Module Name:    constants 
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

// R型指令构造
`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define funct 5:0

// I型指令构造
`define immediate 15:0

// J型指令构造
`define instr_index 25:0

// ALUOp
`define aluAnd 4'b0
`define aluOr 4'b1
`define aluAdd 4'b10
`define aluXor 4'b100
`define aluSub 4'b110
`define aluLui 4'b011

