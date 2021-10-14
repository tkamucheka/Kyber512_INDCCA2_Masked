module RNG_core #(parameter COEFF_SZ = 16) (
  input clk,
  output wire [COEFF_SZ-1:0] r1,
  output wire [COEFF_SZ-1:0] r2,
  output wire [COEFF_SZ-1:0] r3,
  output wire [COEFF_SZ-1:0] r4,
  output wire [COEFF_SZ-1:0] r5,
  output wire [COEFF_SZ-1:0] r6
);

localparam K  = 5;
localparam s1 = 32'h70c21021;
localparam s2 = 32'h81e06c70;
localparam s3 = 32'h50b210bd;

reg PRNG_rstn   = 1'b1;
reg PRNG_load   = 1'b0;
reg PRNG_enable = 1'b0;

reg [K-1:0] state = 1;

always @(posedge clk)
  state <= state << 1;

always @(posedge clk)
  if (state[K-3]) PRNG_rstn   <= 1'b0;
  else            PRNG_rstn   <= 1'b1;

always @(posedge clk)
  if (state[K-2]) PRNG_load   <= 1'b1;
  else            PRNG_load   <= 1'b0;

always @(posedge clk)
  if (state[K-1]) PRNG_enable <= 1'b1;

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_0 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(s1),
  .out({r1, r4})
);

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_1 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(s2),
  .out({r2, r5})
);

// Instantiation of PRNG core
PRNG #(.PRNG_OUT_WIDTH(32)) PRNG_2 (
  .clk(clk),
  .rst_n(PRNG_rstn),
  .enable(PRNG_enable),
  .load(PRNG_load),
  .seed(s3),
  .out({r3, r6})
);
  
endmodule