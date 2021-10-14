`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 09/29/2021 03:02:39 AM
// Design Name: 
// Module Name: State_Polytomsg__masked_decode
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


module State_Polytomsg__masked_decode(
  input              clk,
  input              ce,
  input  wire [15:0] c1,
  input  wire [15:0] c2,
  input  wire [15:0] PRNG_data,
  output reg         data_valid,
  output reg         m1,
  output reg         m2
);

// localparam K = 6;

// reg [K-1:0] state = 0;

wire w_P0_ready;
wire w_P1_ready;
wire w_P2_ready;
wire w_P3_ready;

wire [15:0] w_P0_c1, w_P0_c2;
wire [15:0] w_P1_y1, w_P1_y2;
wire [15:0] w_P2_y1, w_P2_y2;
wire [15:0] w_P3_y1, w_P3_y2;

// Driver
// assign function_done = state[K-1];

// always @(posedge clk) begin
//   state <= {state[K-2:0], ce};
// end

reg [15:0] t1, t2;
reg d1;

always @(posedge clk) begin
  d1 <= w_P3_ready;
  t1 <= (w_P3_y1 >> 12) & 16'h01;
  t2 <= (w_P3_y2 >> 12) & 16'h01;
end

always @(posedge clk) begin
  data_valid <= d1;
  m1 <= t1[0];
  m2 <= t2[0];
end

// 1: -q/4 mod q
State_Polytomsg__masked_decode_s0 P0 (
  .clk(clk),
  .ce(ce),
  .c1(c1),
  .c2(c2),
  .data_valid(w_P0_ready),
  .y1(w_P0_c1),
  .y2(w_P0_c2)
);

// 2: Transform to power of 2
State_Polytomsg__masked_decode_TransformPow2 P1 (
  .clk(clk),
  .ce(w_P0_ready),
  .c1(w_P0_c1),
  .c2(w_P0_c2),
  // .PRNG_data(PRNG_data),
  .data_valid(w_P1_ready),
  .y1(w_P1_y1),
  .y2(w_P1_y2)
);

// 3: -q/2 mod 2^n
State_Polytomsg__masked_decode_s2 P2 (
  .clk(clk),
  .ce(w_P1_ready),
  .c1(w_P1_y1),
  .c2(w_P1_y2),
  .data_valid(w_P2_ready),
  .y1(w_P2_y1),
  .y2(w_P2_y2)
);

// 4: Another A2B
A2B P3 (
  .clk(clk),
  .ce(w_P2_ready),
  .c1(w_P2_y1),
  .c2(w_P2_y2),
  .PRNG_data(PRNG_data),
  .data_valid(w_P3_ready),
  .y1(w_P3_y1),
  .y2(w_P3_y2)
);

endmodule
