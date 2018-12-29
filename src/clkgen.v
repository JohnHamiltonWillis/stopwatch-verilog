`timescale 1ns / 1ps

module clkgen(
 input clk, // master clock
 output refreshClk, //refresh the display
 output clk_point1hz //counter clock
 );
 reg [22:0] count = 0; // counter register variable
 reg [15:0] refresh = 0; // refresh counter register variable
 reg tmp_clk = 0; // temporary clock register variable
 reg rclk = 0; // temporary refresh clock register variable
 assign clk_point1hz = tmp_clk;// 0.5Hz clock
 assign refreshClk = rclk; //refresh clock
 BUFG clock_buf_0( //buffered clock to reduce the clock skew
 .I(clk),
 .O(clk_100mhz)
 );
 // use two always block to generate the clock.
 // when positive edge of master clock, both always blocks evaluated immediately
 // Use non-block assignment in the block
 always @(posedge clk_100mhz) begin // loop to gen tmpclk. tmpclk*cnt=master clk
 if (count < 5_000_000) begin //5,000,000 is within refresh vector range 2^23
 count <= count + 1; // count up
 end
 else begin
 tmp_clk <= ~tmp_clk; // flip the signal when count reaches 5,000,000.
 count <= 0; // reset the counter
 end
 end
 always @(posedge clk_100mhz) begin // loop to gen rclk. rclk*refresh=master clk
 if (refresh < 50_000) begin //50,000 is within the refresh vector range 2^16
 refresh <= refresh + 1; // count up
 end else begin
 refresh <= 0; // reset the refresh counter
 rclk <= ~rclk; // flip the signal when count reaches 50,000.
 end
 end
endmodule
