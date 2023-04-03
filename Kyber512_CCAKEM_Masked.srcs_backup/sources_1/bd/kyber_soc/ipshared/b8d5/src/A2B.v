`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 10/05/2021 05:41:30 AM
// Design Name: 
// Module Name: A2B
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Arithmetic to Boolean conversion
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////

module A2B #(
  parameter COEFF_SZ = 16,
  parameter QBITS    = 12,
  parameter QBITS2   = QBITS+1,
  parameter QM2      = (1 << QBITS2) - 1)
(
  input wire                clk,
  input wire                ce,
  input wire [COEFF_SZ-1:0] c1,
  input wire [COEFF_SZ-1:0] c2,
  input wire [COEFF_SZ-1:0] PRNG_data,
  output wire               data_valid,
  output reg [COEFF_SZ-1:0] y1,
  output reg [COEFF_SZ-1:0] y2
);

localparam K = 2;

reg [COEFF_SZ-1:0] t1;
reg [COEFF_SZ-1:0] t2;

reg [K-1:0] state = 0;

always @(posedge clk) begin
  state <= {state[K-2:0], ce};
end

always @(posedge clk) begin
  t1 <= PRNG_data & QM2;
  t2 <= (c1 + c2) & QM2;
  y1 <= t1;
  y2 <= t1 ^ t2; 
end

// Driver
assign data_valid = state[K-1];
  
endmodule