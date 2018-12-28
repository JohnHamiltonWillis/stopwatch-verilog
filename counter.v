`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2017 02:08:10 PM
// Design Name: 
// Module Name: counter
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


module counter(
 input button_n, //start and stop button.
 input reset_n, //reset button
 input clk_point1hz, //input counter clock
 output reg [3:0] reg_d0, //count for right most digit
 output reg [3:0] reg_d1, //count for 2nd right most digit
 output reg [3:0] reg_d2, //count for 2nd left most digit
 output reg [3:0] reg_d3 //count for left most digit
 );
 reg button_n_ff; //button flip-flop register variable
 reg start_stop; //start, stop or resume signal
 reg reset_n_ff; //reset button flip-flop register variable
 reg reset; //reset signal
 always @ (posedge clk_point1hz) // look for edge of button. Use active low
 begin
 button_n_ff <= button_n; //assign button flip flop from button
 if (button_n_ff && !button_n) // if button_n_ff = 1 && button_n = 0
 start_stop <= ~start_stop;
 reset_n_ff <= reset_n; //assign reset button flip flop from reset button
 if (reset_n_ff && !reset_n) // if reset_n_ff = 1 && reset_n = 0
 reset <=1; //assert reset signal
 else
 reset <=0; //when reset button is not negative edge, reset signal is low
 end
 always @(posedge clk_point1hz, posedge reset_n) //counter logic
 begin
 if (reset_n ==1)
 begin
 reg_d0 <= 0; //counter0 is 0
 reg_d1 <= 0; //counter1 is 0
 reg_d2 <= 0; //counter2 is 0
 reg_d3 <= 0; //counter3 is 0
 // if only stop signal is asserted, store the previous count
 // when stop button is pressed again, resume the old count
 end else if (start_stop == 1)
 begin
 reg_d0 <= reg_d0; //store the old count
 reg_d1 <= reg_d1; //store the old count
 reg_d2 <= reg_d2; //store the old count
 reg_d3 <= reg_d3; //store the old count
 end else if (start_stop != 1) //if no stop
 begin
 if(reg_d0 == 9) // if count is xxx9
 begin
 reg_d0 <= 0; //assign count0 to 0
 if (reg_d1 == 9) //if count is xx99
 begin
 reg_d1 <= 0; //assign count1 to 0
 if (reg_d2 == 9) // if count is x999
 begin
 reg_d2 <= 0; // assign count2 to 0
 if(reg_d3 == 9) //if count is 9999
reg_d3 <= 0; //assign count3 to 0
  else
  reg_d3 <= reg_d3 + 1; //else case for count 9999
  end else //else case for count x999
  reg_d2 <= reg_d2 + 1;
  end else //else case for count xx99
  reg_d1 <= reg_d1 + 1;
  end else // else case for count xxx9
  reg_d0 <= reg_d0 + 1;
  end
  end
 endmodule