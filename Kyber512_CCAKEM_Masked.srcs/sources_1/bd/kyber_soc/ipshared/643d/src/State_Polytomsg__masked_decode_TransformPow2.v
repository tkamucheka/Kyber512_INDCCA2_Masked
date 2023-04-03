`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 09/29/2021 03:02:39 AM
// Design Name: 
// Module Name: State_Polytomsg__masked_decode_TransformPow2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: From Practical CCA2-Secure and Masked Ring-LWE Implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module State_Polytomsg__masked_decode_TransformPow2 #(
  parameter KYBER_N  = 256,
  parameter KYBER_Q  = 3329,
  parameter COEFF_SZ = 16,
  parameter QBITS    = 12,
  parameter QBITS2   = QBITS + 1,
  parameter QM2      = (1 << QBITS2) - 1,
  parameter RAND_SZ  = COEFF_SZ * 5
) (
  input                      clk,
  input                      ce,
  input       [COEFF_SZ-1:0] c1,
  input       [COEFF_SZ-1:0] c2,
  input       [ RAND_SZ-1:0] PRNG_data,
  output wire                data_valid,
  output reg  [COEFF_SZ-1:0] y1,
  output reg  [COEFF_SZ-1:0] y2
);

// Splice PRNG data
function [COEFF_SZ-1:0] PRAND;
  input [2:0] w;
  PRAND = PRNG_data[RAND_SZ-(COEFF_SZ*w)-1 -: COEFF_SZ];
endfunction

// Pipeline stages
localparam K = 6;

reg [K-1:0] state = 0;

// Driver
assign data_valid = state[K-1];

always @(posedge clk)
  state <= {state[K-2:0], ce};

// Stage 0
reg  [COEFF_SZ-1:0] stage0_y1  = 0;
reg  [COEFF_SZ-1:0] stage0_y2  = 0;
reg  [COEFF_SZ-1:0] stage0_ze1 = 0;

always @(posedge clk) begin
  stage0_y1  <= PRAND(0) & QM2;
  stage0_y2  <= c1 - stage0_y1 + c2;
  stage0_ze1 <= stage0_y1 - KYBER_Q;
end

// Stage 1
wire [COEFF_SZ-1:0] w_stage1_ze1;
wire [COEFF_SZ-1:0] w_stage1_ze2;
wire                w_stage1_data_valid;

A2B A2B_inst0 (
  .clk(clk),
  .ce(state[1]),
  .c1(stage0_ze1),
  .c2(stage0_y2),
  .PRNG_data(PRNG_data[RAND_SZ-(COEFF_SZ*1)-1 -: COEFF_SZ]),
  .data_valid(w_stage1_data_valid),
  .y1(w_stage1_ze1),
  .y2(w_stage1_ze2)
);

// Stage 2
reg [COEFF_SZ-1:0] k1   = 0;
reg [COEFF_SZ-1:0] k2   = 0;
reg [COEFF_SZ-1:0] k1p  = 0;
reg [COEFF_SZ-1:0] k2p  = 0;
reg [COEFF_SZ-1:0] r    = 0;

reg [COEFF_SZ-1:0] k1Q       = 0;
reg [COEFF_SZ-1:0] k2Q       = 0;
reg [COEFF_SZ-1:0] k1pk2pQ   = 0;
reg [COEFF_SZ-1:0] k1pk2ppQ  = 0;
reg [COEFF_SZ-1:0] k1ppk2pQ  = 0;
reg [COEFF_SZ-1:0] k1ppk2ppQ = 0;

function [COEFF_SZ-1:0] MSB;
  input [COEFF_SZ-1:0] coeff;
  MSB = (coeff >> (QBITS2-1)) & 1;
endfunction

always @(posedge clk) begin
  if (w_stage1_data_valid) begin
    k1  <= MSB(w_stage1_ze1) ^ 1; // ((x >> 12) & 1) ^ 1
    k2  <= MSB(w_stage1_ze2);     // ((x >> 12) & 1)
    k1p <= PRAND(2) & QM2;
    k2p <= PRAND(3) & QM2;
  end else begin
    k1  <= 0;
    k2  <= 0;
    k1p <= 0;
    k2p <= 0;
  end
end

always @(posedge clk) begin
  r          <= PRAND(4) & QM2;
  k1Q        <= k1 * KYBER_Q;
  k2Q        <= k2 * KYBER_Q;
  k1pk2pQ    <= 2 * k1p * k2p * KYBER_Q;
  k1pk2ppQ   <= 2 * k1p * (k2 - k2p) * KYBER_Q;
  k1ppk2pQ   <= 2 * (k1 - k1p) * k2p * KYBER_Q;
  k1ppk2ppQ  <= 2 * (k1 - k1p) * (k2 - k2p) * KYBER_Q;
end

// Stage 3
wire [COEFF_SZ-1:0] w_stage0_y1_out;
wire [COEFF_SZ-1:0] w_stage0_y2_out;

always @(posedge clk) begin
  y1 <= (((((((r + w_stage0_y1_out) - k1Q) - k2Q) + k1pk2pQ) + k1pk2ppQ) + k1ppk2pQ) + k1ppk2ppQ) & QM2;
  y2 <= (w_stage0_y2_out - r) & QM2;
end

Shift_Reg #(.MSB(K-1)) FU_y1[COEFF_SZ-1:0] (
  .clk(clk),
  .din(stage0_y1),
  .dout(w_stage0_y1_out)
);

Shift_Reg #(.MSB(K-2)) FU_y2[COEFF_SZ-1:0] (
  .clk(clk),
  .din(stage0_y2),
  .dout(w_stage0_y2_out)
);
  
endmodule
