`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 10/04/2021 02:31:39 AM
// Design Name: 
// Module Name: State_Polytomsg__masked_decode_s2
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

module State_Polytomsg__masked_decode_s2 #(
  parameter KYBER_N  = 256,
  parameter KYBER_Q  = 3329,
  parameter COEFF_SZ = 16,
  parameter QBITS    = 12,
  parameter QBITS2   = QBITS + 1,
  parameter QM2      = (1 << QBITS2) - 1  
) (
  input wire                clk,
  input wire                ce,
  input wire [COEFF_SZ-1:0] c1,
  input wire [COEFF_SZ-1:0] c2,
  output reg                data_valid,
  output reg [COEFF_SZ-1:0] y1,
  output reg [COEFF_SZ-1:0] y2
);

localparam Q = KYBER_Q / 2;

always @(posedge clk) begin
  if (ce) begin
    data_valid <= 1'b1;
    y1         <= (c1 - Q) & QM2;
    y2         <= c2;
  end else begin
    data_valid <= 1'b0;
    y1         <= 0;
    y2         <= 0;
  end
end
  
endmodule