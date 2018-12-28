`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2017 02:06:11 PM
// Design Name: 
// Module Name: enable_sr
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


module enable_sr(
 input refreshClk, //input clock
 output enable_D1, //right most digit
 output enable_D2, //second right most digit
 output enable_D3, //second left most digit
 output enable_D4 //left most digit
 );
 //pattern vector variable. each vector represent one digit
 //assign the pattern to 0111 so only right most digit is asserted (active low)
 reg [3:0] pattern = 4'b0111;
 assign enable_D1 = pattern[3]; //assign rightmost digit to 0; turn on rightmost
 assign enable_D2 = pattern[2]; //assign second right most digit to 1, off
 assign enable_D3 = pattern[1]; //assign second left most digit to 1, off
 assign enable_D4 = pattern[0]; //assign left most digit to 1, off
 always @(posedge refreshClk) begin
 pattern <= {pattern[0],pattern[3:1]}; //shift the vector to enable each digit
 end
endmodule
