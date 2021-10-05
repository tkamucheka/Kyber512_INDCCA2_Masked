

module State_Unpack__poly_frombytes #(
  parameter KYBER_K = 2,
  parameter KYBER_N = 256,
  parameter BYTE_BITS = 8,
  parameter KYBER_POLYBYTES = 384,
  parameter IPOLY_SZ = BYTE_BITS * KYBER_POLYBYTES * KYBER_K,
  parameter OPOLY_SZ = 128,
  parameter COEFF_SZ = 16
)(
  input                         clk,
  input                         resetn,
  input                         enable,
  input       [IPOLY_SZ-1 : 0]  i_poly,
  input       [15:0]            PRNG_out,
  output reg                    Function_Done,
  output reg                    out_ready,
  output reg                    PRNG_enable,
  output reg  [OPOLY_SZ-1 : 0]  o_poly_s1,
  output reg  [OPOLY_SZ-1 : 0]  o_poly_s2
);

reg [7:0] n;

reg  [ 96-1 : 0] a;
wire [128-1 : 0] r, rand_poly, masked_poly;

reg  P1_mask_enable;
wire mask_outready;

reg [2:0] cstate,nstate;
localparam IDLE   = 3'd0;
localparam UNPACK = 3'd1;
localparam MASK   = 3'd2;

always @(posedge clk or negedge resetn) begin
  if (!resetn)  cstate <= IDLE;
  else          cstate <= nstate;
end

always @(cstate, enable, n, mask_outready) begin
  case (cstate)
    IDLE:     if (enable)                         nstate <= UNPACK;
              else                                nstate <= IDLE;
    UNPACK:                                       nstate <= MASK;
    MASK:     if (mask_outready && n > KYBER_N/4) nstate <= IDLE;
              else if (mask_outready)             nstate <= UNPACK;
              else                                nstate <= MASK;
    default:                                      nstate <= IDLE;
  endcase
end

always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    Function_Done <= 0;
    out_ready     <= 0;
    PRNG_enable   <= 1'b0;
    n             <= 0;
  end else begin
    case ({cstate,nstate})
      {IDLE,IDLE}: begin
        Function_Done <= 0;
        out_ready     <= 1'b0;
        PRNG_enable   <= 1'b0;
      end
      {IDLE,UNPACK}: begin
        a <= i_poly[96+(96*n)-1 -: 96];
        n <= n + 1;
      end
      {UNPACK,MASK}: begin
        PRNG_enable     <= 1'b1;
        P1_mask_enable  <= 1'b1;
      end
      {MASK,MASK}: begin
        PRNG_enable     <= 1'b1;
        P1_mask_enable  <= 1'b0;
      end
      {MASK,UNPACK}: begin
        out_ready <= 1'b1;
        a         <= i_poly[96+(96*n)-1 -: 96];
        o_poly_s1 <= rand_poly;
        o_poly_s2 <= masked_poly;
        n         <= n + 1;
      end
      {MASK,IDLE}: begin
        PRNG_enable   <= 1'b0;
        Function_Done <= 1'b1;
        out_ready     <= 1'b1;
        o_poly_s1     <= rand_poly;
        o_poly_s2     <= masked_poly;
        n             <= 0;
      end
      default: ;
    endcase
  end
end

State_Unpack__poly_frombytes__r P0 (clk, a, r);

State_Unpack__mask P1 (
  .clk(clk),
  .enable(P1_mask_enable),
  .rand(PRNG_out),
  .s(r),
  .function_done(mask_outready),
  .s1(rand_poly), 
  .s2(masked_poly)
);
  
endmodule
