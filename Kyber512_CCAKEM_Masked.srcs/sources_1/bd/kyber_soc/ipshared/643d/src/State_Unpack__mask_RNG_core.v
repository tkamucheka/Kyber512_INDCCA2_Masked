`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 10/19/2021 02:04:42 AM
// Design Name: Kyber512 INDCCA
// Module Name: State_Unpack__mask_RNG_core
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

module State_Unpack__mask_RNG_core #(
  parameter COEFF_SZ = 16,
  parameter QBITS    = 12,
  parameter QM       = (1 << QBITS) - 1) 
(
  input clk,
  input rst_n,
  input  wire [COEFF_SZ-1:0] seed,
  output wire [COEFF_SZ-1:0] rand
);
localparam KYBER_Q = 3329;
localparam SEED_SZ = COEFF_SZ * 2;

localparam K  = 5;
localparam s1 = 32'h40bfe3a7; // RNG_core seed

reg PRNG_rstn   = 1'b1;
reg PRNG_load   = 1'b0;
reg PRNG_enable = 1'b0;
reg  [ SEED_SZ-1:0] PRNG_seed;
wire [COEFF_SZ-1:0] PRNG_out;

reg  [SEED_SZ-1:0] r_seed, r_seed_buf;

// Mod 2^10: Keep random values smaller Q
// r -> Q/2 and r -> Q, produce erroneous message bits
assign rand = (PRNG_out & 16'h07FF); // & QM;

reg [K-1:0] state = 1;

always @(posedge clk) begin
  r_seed_buf <= {r_seed_buf[COEFF_SZ-1:0], seed};
end

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    state[K-1] <= 1'b1;
    r_seed     <= r_seed_buf;
  end else begin
    state      <= state << 1;
    r_seed     <= 0;
  end
end

always @(posedge clk)
  if (state[K-4]) PRNG_rstn   <= 1'b0;
  else            PRNG_rstn   <= 1'b1;

always @(posedge clk)
  if (state[K-3]) PRNG_enable <= 1'b1;

always @(posedge clk)
  if (state[K-1]) begin
    PRNG_load   <= 1'b1;
    PRNG_seed   <= s1 ^ r_seed;
  end else begin
    PRNG_load   <= 1'b0;
  end

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(COEFF_SZ)) PRNG_0 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(PRNG_seed),
  .out(PRNG_out)
);
  
endmodule