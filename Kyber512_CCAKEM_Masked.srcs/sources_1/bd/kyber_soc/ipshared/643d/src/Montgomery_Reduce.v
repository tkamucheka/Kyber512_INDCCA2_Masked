`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 03/07/2021 09:42:30 PM
// Design Name: 
// Module Name: Montgomery_reduce
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

module Montgomery_Reduce #(
  parameter MontgomeryR_QINV = 62209,
  parameter KYBER_Q = 3329)
(
  input                 clk,
  input                 ce,
  input   signed [31:0] iCoeffs_a,
  output  reg    [15:0] oCoeffs,
  output  wire          reduce_done
);

localparam K = 4;

reg signed [31:0] a;
reg signed [31:0] t;
reg signed [15:0] u;
wire signed [31:0] fifo_out;

reg [K-1:0] state = 0;

assign reduce_done = state[K-1];

always @(posedge clk)
  state <= {state[K-2:0], ce};

always @(posedge clk) begin
  a <= iCoeffs_a;
  u <= a * $signed(MontgomeryR_QINV);
  t <= u * $signed(KYBER_Q);
  oCoeffs <= $signed(fifo_out - t) >>> 16;
end

Shift_Reg #(.MSB(K-1)) FIFO[31:0] (
  .clk(clk),
  .din(iCoeffs_a),
  .dout(fifo_out)
);

endmodule


// module Montgomery_Reduce #(
//   parameter MontgomeryR_QINV = 62209,
//   parameter KYBER_Q = 3329)
// (
//   input                 clk,
//   input                 ce,
//   input   signed [15:0] iCoeffs_a,
//   output  reg    [15:0] oCoeffs,
//   output  wire          reduce_done
// );

// wire last;

// reg signed [31:0] a;
// reg signed [31:0] t;
// reg signed [15:0] u;

// reg [4:0] state;

// assign reduce_done = state[4];
// assign last        = state[3];

// always @(posedge clk)
//   if (ce) begin
//     state <= {state[4:1], 1'b1};
//     a     <= {{16{iCoeffs_a[15]}}, iCoeffs_a};
//   end else begin
//     state <= state << 1;
//   end

// always @(posedge clk)
//   u <= a * $signed(MontgomeryR_QINV);

// always @(posedge clk)
//   t <= u * $signed(KYBER_Q);

// always @(posedge clk)
//   if (last)
//     oCoeffs <= $signed(iCoeffs_a - t) >>> 16;

// endmodule