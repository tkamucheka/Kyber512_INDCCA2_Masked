`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 09/30/2021 03:02:39 AM
// Design Name: 
// Module Name: N-bit Shift Register
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

module Shift_Reg #(parameter MSB = 8) (
  input       clk,
  input  wire din,
  output wire dout
);

reg [MSB-1:0] state = 0;

always @(posedge clk) begin
  state <= {state[MSB-2 : 0], din};
end

// Driver
assign dout = state[MSB-1];
  
endmodule