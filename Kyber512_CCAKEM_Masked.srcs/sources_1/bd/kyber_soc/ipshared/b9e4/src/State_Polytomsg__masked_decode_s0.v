`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 09/29/2021 03:02:39 AM
// Design Name: 
// Module Name: State_Polytomsg__masked_decode_s0
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

module State_Polytomsg__masked_decode_s0 #(
  parameter KYBER_K = 2,
  parameter KYBER_N = 256,
  parameter KYBER_Q = 3329
)(
  input              clk,
  input              ce,
  input       [15:0] c1,
  input       [15:0] c2,
  output wire        data_valid,
  output wire [15:0] y1,
  output wire [15:0] y2 
);

localparam K = 5;
localparam Q = (KYBER_Q / 4) + KYBER_Q;

// wire barret_done;
// wire [15:0] barret_out;

reg [15:0] t = 0;
// reg [15:0] t1 = 0;

// assign divisor_tdata = KYBER_Q;

reg [K-1:0] state = 0;

always @(posedge clk)
  state <= {state[K-2:0], ce};

always @(posedge clk)
  if (ce) t <= c1 - Q;
  else    t <= 16'h0;

Barrett_Reduce P1 (
  .clk(clk),
  .ce(state[0]),
  .iCoeffs_a(t),
  .oCoeffs(y1),
  .reduce_done(data_valid)
);

Shift_Reg #(.MSB(K)) FIFO[15:0] (
  .clk(clk),
  .din(c2),
  .dout(y2)
);
  
endmodule