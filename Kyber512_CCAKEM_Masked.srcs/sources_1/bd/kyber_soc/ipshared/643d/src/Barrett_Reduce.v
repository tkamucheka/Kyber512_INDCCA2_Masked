`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 03/07/2021 09:42:30 PM
// Design Name: 
// Module Name: Barrett_Reduce
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

module Barrett_Reduce #(parameter KYBER_Q = 3329)
(
  input                 clk,
  input                 ce,
  input   signed [15:0] iCoeffs_a,
  output  reg    [15:0] oCoeffs,
  output  wire          reduce_done
);

localparam K = 4;
localparam V = (1 << 26) / KYBER_Q + 1;

reg signed  [31:0] a        = 0;
reg signed  [31:0] t2_32    = 0;
reg signed  [31:0] t1_32    = 0;
wire signed [31:0] fifo_out;

reg [K-1:0] state = 0;

assign reduce_done = state[K-1];

always @(posedge clk) begin
  state = {state[K-2:0], ce};
end

always @(posedge clk) begin
  if (ce) a <= {{16{iCoeffs_a[15]}}, iCoeffs_a};
  else    a <= 32'h0;
end

always @(posedge clk) begin
  t1_32   <= $signed(a) * $signed(V);
  t2_32   <= ($signed(t1_32) >>> 26) * $signed(KYBER_Q);
  oCoeffs <= $signed(fifo_out) - $signed(t2_32);
end

Shift_Reg #(.MSB(K-1)) FIFO[31:0] (
  .clk(clk),
  .din({{16{iCoeffs_a[15]}}, iCoeffs_a}),
  .dout(fifo_out)
);

endmodule