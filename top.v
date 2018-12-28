`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2017 01:57:40 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input button_n,
    input reset_n,
    output [6:0] segment,
    output enable_D1,
    output enable_D2,
    output enable_D3,
    output enable_D4,
    output dp
    );
    
    reg [3:0] hex;
    wire [3:0] reg_d0, reg_d1, reg_d2, reg_d3;
    
    clkgen Uclkgen (clk, refreshClk, clk_point1hz);
    enable_sr Uenable (refreshClk, enable_D1, enable_D2, enable_D3, enable_D4);
    counter Ucounter (button_n, reset_n, clk_point1hz, reg_d0, reg_d1, reg_d2, reg_d3);
    ssd Ussd (hex, enable_D2, segment, dp);
    
    
    always @ (*)
     case ({enable_D1,enable_D2,enable_D3,enable_D4})
     4'b0111: hex = reg_d0;
     4'b1011: hex = reg_d1;
     4'b1101: hex = reg_d2;
     4'b1110: hex = reg_d3;
     default: hex = 0;
     endcase
endmodule
