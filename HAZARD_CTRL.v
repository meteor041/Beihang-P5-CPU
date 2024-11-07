`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:23:35 11/06/2024 
// Design Name: 
// Module Name:    HAZARD_CTRL 
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
module HAZARD_CTRL(
    input clk,
    input reset,
    // ID
    input [4:0] ID_A1,
    input [4:0] ID_A2,
    input [31:0] ID_RD1,
    input [31:0] ID_RD2,
    input [1:0] ID_A1_USE,
    input [1:0] ID_A2_USE,
    // EX
    input [4:0] EX_A1,
    input [4:0] EX_A2,
    input [31:0] EX_RD1,
    input [31:0] EX_RD2,
    input [1:0] EX_NEW,
    input [4:0] EX_A3,
    input [31:0] EX_WD,
    // MEM
    input [4:0] MEM_A2,
    input [31:0] MEM_RD2,
    input [1:0] MEM_A2_NEW,
    input [4:0] MEM_A3,
    input [31:0] MEM_WD,
    // WB
    input [4:0] WB_A3,
    input [31:0] WB_WD,
    // 转发
    output [31:0] ID_RD1_forward,
    output [31:0] ID_RD2_forward,
    output [31:0] EX_RD1_forward,
    output [31:0] EX_RD2_forward,
    output [31:0] MEM_RD2_forward,
    // Signals
    output Enable_PC,
    output Enable_IF_ID,
    output Enable_ID_EX,
    output Flush_ID_EX,
    output Flush_EX_MEM
    );

    // 暂停
    wire STALL;
    assign STALL =  (ID_A1 == EX_A3 && ID_A1_USE < EX_NEW && EX_A3 != 0)  
                 || (ID_A2 == EX_A3 && ID_A2_USE < EX_NEW && EX_A3 != 0)
                 || (ID_A1 == MEM_A3 && ID_A1_USE < MEM_A2_NEW && MEM_A3 != 0)
                 || (ID_A2 == MEM_A3 && ID_A2_USE < MEM_A2_NEW && MEM_A3 != 0);
    assign Enable_PC = !STALL;
    assign Enable_IF_ID = !STALL;
    assign Flush_ID_EX = STALL;



    assign Flush_EX_MEM = 1'b0;
    assign Enable_ID_EX = 1'b1;

    // 转发
    reg [31:0] REG_A3;
    reg [31:0] REG_WD;
    assign ID_RD1_forward = (ID_A1 == 5'b0) ? 0 :
                            (ID_A1 == MEM_A3) ? MEM_WD :
                            (ID_A1 == WB_A3) ? WB_WD :
                            // (ID_A1 == REG_A3) ? REG_WD :
                            ID_RD1;
                            // (ID_A1 == 5'b0) ? ID_RD1
                            // (ID_A1 == EX_A3) ? EX_WD :
                            
    assign ID_RD2_forward = (ID_A2 == 5'b0) ? 0:
                            (ID_A2 == MEM_A3) ? MEM_WD :
                            (ID_A2 == WB_A3) ? WB_WD :
                            // (ID_A2 == REG_A3) ? REG_WD :
                            ID_RD2;
                      
                            // (ID_A2 == EX_A3) ? EX_WD :
    assign EX_RD1_forward = (EX_A1 == 5'b0) ? 0:
                            (EX_A1 == MEM_A3) ? MEM_WD :
                            (EX_A1 == WB_A3) ? WB_WD :
                            // (EX_A1 == REG_A3) ? REG_WD :
                            EX_RD1;
                            // (EX_A1 == REG_A3) ? REG_WD :
                            
    assign EX_RD2_forward = (EX_A2 == 5'b0 ) ? 0:
                            (EX_A2 == MEM_A3) ? MEM_WD :
                            (EX_A2 == WB_A3) ? WB_WD : 
                            EX_RD2;
                                                       // (EX_A2 == REG_A3 ) ? REG_WD:
                            // (EX_A2 == 5'b0 ) ? EX_RD2:
                            // (EX_A2 == REG_A3) ? REG_WD :
    assign MEM_RD2_forward = (MEM_A2 == 5'b0 ) ? 0 :
                            (MEM_A2 == WB_A3) ? WB_WD :
                            MEM_RD2;
                            //   (MEM_A2 == 5'b0 ) ? MEM_WD :
    always @(posedge clk)begin
        if (reset)begin
            REG_A3 = 32'b0;
            REG_WD = 32'b0;
        end
        else begin
            REG_A3 = WB_A3;
            REG_WD = WB_WD;
        end
    end
    // wire STALL_ID;
    // wire STALL_EX;

    // assign STALL_ID = 
    // (STALL_EX) ? 0 :
    // ((ID_A1 == 0 || ID_A1_USE == 0) && (ID_A2 == 0 || ID_A2_USE == 0)) ? 0:
    // (ID_A1 == EX_A3 && ID_A1 != 0 && ID_A1_USE && EX_WD === 32'bz) ? 1 :
    // (ID_A2 == EX_A3 && ID_A2 != 0 && ID_A2_USE && EX_WD === 32'bz) ? 1 :
    // (ID_A1 == MEM_A3 && ID_A1 != 0 && ID_A1_USE && MEM_WD === 32'bz) && !(ID_A1 == EX_A3 && EX_A3 != 0 && EX_WD != 32'bz) ? 1 :
    // (ID_A2 == MEM_A3 && ID_A2 != 0 && ID_A2_USE && MEM_WD === 32'bz) && !(ID_A2 == EX_A3 && EX_A3 != 0 && EX_WD != 32'bz) ? 1 :
    // 0;


    // // ((ID_A1 == EX_A3 && ID_A1 != 0 && ID_A1_USE && EX_WD === 32'bz) || (ID_A2 == EX_A3 && ID_A2 != 0 && ID_A2_USE && EX_WD === 32'bz)) ? 1 :
    // // (((ID_A1 == MEM_A3 && ID_A1 != 0 && ID_A1_USE && MEM_WD === 32'bz) && !(ID_A1 == EX_A3 && EX_A3 != 0 && EX_WD != 32'bz))
    // // || (ID_A2 == MEM_A3 && ID_A2 != 0 && ID_A2_USE && MEM_WD !== 32'bz) && !(ID_A2 == EX_A3 && EX_A3 != 0 && EX_WD != 32'bz)) ? 1 :
    // // 0;
    // assign STALL_EX = 
    // ((EX_A1 == 0 || EX_A1_USE == 0) && (EX_A2 == 0 || EX_A2_USE == 0)) ? 0:
    // ((EX_A1 == MEM_A3 && EX_A1 != 0 && EX_A1_USE && MEM_WD === 32'bz) || (EX_A2 == MEM_A3 && EX_A2 != 0 && EX_A2_USE && MEM_WD === 32'bz)) ? 1 :
    // 0;

    //     // ((EX_A1 == WB_A3 && EX_A1 != 0 && EX_A1_USE) || (EX_A2 == WB_A3 && EX_A2 != 0 && EX_A2_USE)) ? 1 :
    // assign ID_RD1_forward = (ID_A1 == 5'b0) ? ID_RD1:
    //                         (ID_A1 == EX_A3) ? EX_WD :
    //                         (ID_A1 == MEM_A3) ? MEM_WD :
    //                         ID_RD1;
    // assign ID_RD2_forward = (ID_A2 == 5'b0) ? ID_RD2:
    //                         (ID_A2 == EX_A3) ? EX_WD :
    //                         (ID_A2 == MEM_A3) ? MEM_WD :
    //                         ID_RD2;
    // assign EX_RD1_forward = (EX_A1 == 5'b0) ? EX_RD1:
    //                         (EX_A1 == MEM_A3) ? MEM_WD :
    //                         (EX_A1 == WB_A3) ? WB_WD :
    //                         (EX_A1 == REG_A3) ? REG_WD :
    //                         EX_RD1;
    // assign EX_RD2_forward = (EX_A2 == 5'b0 ) ? EX_RD2:
    //                         (EX_A2 == MEM_A3) ? MEM_WD :
    //                         (EX_A2 == WB_A3) ? WB_WD : 
    //                         (EX_A2 == REG_A3) ? REG_WD :
    //                         EX_RD2;
    // assign MEM_RD2_forward = (MEM_A2 == 5'b0 ) ? MEM_WD :
    //                          (MEM_A2 == WB_A3) ? WB_WD :
    //                           MEM_WD;

    // assign Enable_PC = ((!STALL_ID) && (!STALL_EX)) ? 1 : 0;
    // assign Enable_IF_ID = ((!STALL_ID) && (!STALL_EX)) ? 1 : 0;
    // assign Enable_ID_EX = (!STALL_EX) ? 1 : 0;
    // assign Flush_ID_EX = (STALL_ID) ? 1 : 0;
    // assign Flush_EX_MEM = (STALL_EX) ? 1 : 0;

    // reg [31:0] REG_A3;
    // reg [31:0] REG_WD;
    // always @(posedge clk)begin
    //     if (reset)begin
    //         REG_A3 = 32'b0;
    //         REG_WD = 32'b0;
    //     end
    //     else begin
    //         REG_A3 = WB_A3;
    //         REG_WD = WB_WD;
    //     end
    // end
endmodule
