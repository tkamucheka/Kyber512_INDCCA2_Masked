`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 07/29/2021 02:58:54 PM
// Design Name: PRNG
// Module Name: PRNG
// Project Name: 
// Target Devices: Artix-7, Virtex-7
// Tool Versions: 
// Description: Pseudo Random Number Generator based on LFSR + CASR of Tkacik,2002 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PRNG #(parameter integer PRNG_OUT_WIDTH = 32) (
  input              clk,
  input              rst_n,
  input              enable,
  input              load,
  input       [31:0] seed,
  output reg  [PRNG_OUT_WIDTH-1:0] out
  );

  reg [36:0] CASR;
  reg [42:0] LFSR;

  always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
      CASR <= (37'h1000_0000);
      LFSR <= (42'h1000_0001);
    end else if (load) begin
      CASR <= { 5'h0, seed} | 32'h1000_0000; // Load seed, protect from a seed of 0.
      LFSR <= {10'h0, seed} | 32'h1000_0000; // Load seed, protect from a seed of 0.
    end else if (enable) begin
      CASR[36:0] <= ( ({CASR[35:0],CASR[36]}) ^ ({CASR[0],CASR[36:1]}) ^ (CASR[27]<<27) );
      LFSR[42:0] <= ( ({LFSR[41:0],LFSR[42]}) ^ (LFSR[42]<<41) ^ (LFSR[42]<<20) ^ (LFSR[42]<<1) );

      out[PRNG_OUT_WIDTH-1:0] <= ( LFSR [PRNG_OUT_WIDTH-1:0] ^ CASR[PRNG_OUT_WIDTH-1:0] );
    end
  end
endmodule
