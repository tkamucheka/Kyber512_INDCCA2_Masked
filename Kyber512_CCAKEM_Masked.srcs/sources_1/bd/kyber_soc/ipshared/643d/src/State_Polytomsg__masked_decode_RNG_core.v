`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 10/19/2021 03:33:18 AM
// Design Name: Kyber512 INDCCA
// Module Name: State_Polytomsg__masked_decode_RNG_core
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

module State_Polytomsg__masked_decode_RNG_core #(
  parameter COEFF_SZ = 16,
  parameter SEED_BUF_SZ = COEFF_SZ * 6
) (
  input clk,
  input rst_n,
  input  wire [COEFF_SZ-1:0] seed,
  output wire [COEFF_SZ-1:0] r1,
  output wire [COEFF_SZ-1:0] r2,
  output wire [COEFF_SZ-1:0] r3,
  output wire [COEFF_SZ-1:0] r4,
  output wire [COEFF_SZ-1:0] r5,
  output wire [COEFF_SZ-1:0] r6
);

// Splice
function [31:0] SPLICE;
  input [SEED_BUF_SZ-1:0] seed_buf;
  input [            1:0] w;
  SPLICE = seed_buf[SEED_BUF_SZ-(COEFF_SZ*w)-1 -: 32];
endfunction

localparam K  = 6;
localparam s1 = 32'h70c21021;
localparam s2 = 32'h81e06c70;
localparam s3 = 32'h50b210bd;

reg  [SEED_BUF_SZ-1:0] r_seed, r_seed_buf;

reg PRNG_rstn   = 1'b1;
reg PRNG_load   = 1'b0;
reg PRNG_enable = 1'b0;
reg [31:0] PRNG_s1;
reg [31:0] PRNG_s2;
reg [31:0] PRNG_s3;

reg [K-1:0] state = 1;

always @(posedge clk) begin
  r_seed_buf <= {r_seed_buf[SEED_BUF_SZ-COEFF_SZ-1:0], seed};
end

reg r_delay;
wire w_delay;

Shift_Reg #(.MSB(3)) FU_delay (
  .clk(clk),
  .din(r_delay),
  .dout(w_delay)
);

always @(posedge clk or negedge rst_n)
  if (rst_n == 1'b0) begin
    state[K-4] <= 1'b1;
    r_delay    <= 1'b1;
  end else begin
    state      <= state << 1;
    r_delay    <= 1'b0;
  end

always @(posedge clk)
  if (state[K-5]) PRNG_rstn   <= 1'b0;
  else            PRNG_rstn   <= 1'b1;

always @(posedge clk)
  if (state[K-4]) PRNG_enable <= 1'b1;

always @(posedge clk) begin
  if (w_delay) r_seed <= r_seed_buf;
  else         r_seed <= 0;
end

always @(posedge clk)
  if (state[K-1]) begin
    PRNG_load   <= 1'b1;
    PRNG_s1     <= s1 ^ SPLICE(r_seed, 0);
    PRNG_s2     <= s2 ^ SPLICE(r_seed, 1);
    PRNG_s3     <= s3 ^ SPLICE(r_seed, 2);
  end else begin
    PRNG_load   <= 1'b0;
  end


// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_0 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(PRNG_s1),
  .out({r1, r4})
);

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_1 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(PRNG_s2),
  .out({r2, r5})
);

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_2 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(PRNG_s3),
  .out({r3, r6})
);
  
endmodule