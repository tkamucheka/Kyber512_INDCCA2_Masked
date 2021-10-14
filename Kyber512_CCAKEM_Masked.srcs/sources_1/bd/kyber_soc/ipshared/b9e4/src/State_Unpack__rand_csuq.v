`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka
// 
// Create Date: 09/29/2021 01:46:53 AM
// Design Name: Kyber512 CCAKEM Masked
// Module Name: State_Unpack__rand_csuq
// Project Name: Kyber512 CCAKEM Masked
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


module State_Unpack__rand_csuq #(
  parameter QBITS    = 12,
  parameter QBITS2   = QBITS + 1,
  parameter QM       = (1 << QBITS) - 1,
  parameter QM2      = (1 << QBITS2) - 1
) (
  output reg [15:0] rand,
  input      [15:0] PRNG_data
);

localparam KYBER_Q = 3329;

always @(*) begin
  if (PRNG_data >= KYBER_Q) begin
    rand <= (PRNG_data - KYBER_Q) & QM;
  end else begin
    rand <= PRNG_data & QM;
  end
end

endmodule
