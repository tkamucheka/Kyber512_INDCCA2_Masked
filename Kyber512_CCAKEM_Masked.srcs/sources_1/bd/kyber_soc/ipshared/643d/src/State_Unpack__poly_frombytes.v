`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University Of Arkansas
// Engineer: Tendayi Kamucheka
// 
// Create Date: 09/29/2021 01:46:53 AM
// Design Name: Kyber512 CCAKEM Masked
// Module Name: State_Unpack__poly_frombytes
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

module State_Unpack__poly_frombytes #(
  parameter KYBER_K         = 2,
  parameter KYBER_N         = 256,
  parameter BYTE_BITS       = 8,
  parameter KYBER_POLYBYTES = 384,
  parameter IPOLY_SZ        = BYTE_BITS * KYBER_POLYBYTES * KYBER_K,
  parameter OPOLY_SZ        = 128,
  parameter COEFF_SZ        = 16
)(
  input                         clk,
  input                         resetn,
  input                         enable,
  input       [IPOLY_SZ-1 : 0]  i_poly,
  input       [15:0]            PRNG_data,
  output reg                    Function_Done,
  output reg                    out_ready,
  output reg  [OPOLY_SZ-1 : 0]  o_poly_s1,
  output reg  [OPOLY_SZ-1 : 0]  o_poly_s2
);

// DEBUG:
// synthesis translate_off
reg [8191:0] i_rand = 8192'h0b0e0ce500a40380011d0c5b07bb03c603e50438060109020138027a0bd707b806be0a77092603e10c2e006b054502690c28028506620afd0aa6026e091c0b950324033a0c6c047d03040ad90b6d098a0914012f04eb0c0c062d04c907390c1e04a708720cce023f0b35018a0bc10aa6017d01db0989085e078a0afc08b2088a0a3900d00318026f0105065907ec00d10c4e052608d10523094f0a2c04cb071b083102fe03350b5b0b030773085a0b9b0bde04bc0acf0c150474084c0b67008008230bfb0153039801ec07120107099308a503000afb0364053f00d1073c019d0759027e0a5602b4072c0b370335032405fe0334046e047e0c9605ec058f05da0c550bca094e0996002c0c35093f013c09bc036a0711083603e609f50b240c4f074d0326070c03ae010b09f20c8d0be80bb3039b08690b0101dc01db026005290a8104ac01090cdf0b8b08240c48000e05ac095d09a60075064c07b201060458082e02eb087809b30687055000b108e6060e070f08630b5b04d306d1016707b8030c0b41058b0a9c00da0caf04a50b190aa004d403200c5a03210b5501210a300cb60a7b052707b40b1001fe0a17056d02c501030866014104560ce004d408c405780cb102c009d901c008d50cac077906ae08f40b8d0ac107e60b180aed0281072506e504c202d5028e038e02b40b0100c903ad0cf00039097e053906e0043b0b930a7502a2026e0b5601ad051e022b058f04d70b9602e402e3015101a300f0062b0a28018a07e2012401be0cb3033e085c04790b80030e09d900f102b9003706d3037e010700ac05de054a0492031e008006a50be40ba5020706360778061c08b805c7019100fc080b065001ca033f032b03b808ef07a505cd02e4094803890074087d05f3071a0282009f0713047c0081022a0a0f04fc04790a1b026d02db053e024c07630c2f0277057b09240c2704c20c9e076501460b0e070e059300ea0243082d04d9080a060b08f104d2019a0bff0bb90bde02000681058808370b28009607a90c2a00f6002f00df0c110898044f08ca04be027302d1034003f105a708770cb705dc051100cc03df04b1094201fd0abb07e90c5107ae0439007a0a000cd204fd04b7093a0ae70997084a089104d902a90a4c00d9006609d505f00a8408e20c10033704a708850af9011909aa075c056b0bd90adf0962053e049b0a3f048708ca07e50849069104960059008d0703018509fa07ee04bc07ae015c092701660aae0617011d0261007f015601410659086601f003c60aec050a066b00ec0b2a054a0a08044e012306f5093d08ef040b00470824096c0b1604c403580c190c5c0a9d01df00e50b42034508d5036e074a06d5011603bc06c40509033a0138097f07a503e904340b0f01da025d073705bd09b405420b8e099b0738077a020b;
reg  [128-1 : 0] rpoly;
// synthesis translate_on

reg  [    7 : 0] n;
reg  [ 96-1 : 0] a;
wire [128-1 : 0] r, rand_poly, masked_poly;
wire [ 16-1 : 0] rand;

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
    IDLE:     if (enable)                          nstate <= UNPACK;
              else                                 nstate <= IDLE;
    UNPACK:                                        nstate <= MASK;
    MASK:     if (mask_outready && n == KYBER_N/4) nstate <= IDLE;
              else if (mask_outready)              nstate <= UNPACK;
              else                                 nstate <= MASK;
    default:                                       nstate <= IDLE;
  endcase
end

always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    Function_Done <= 0;
    out_ready     <= 0;
    n             <= 0;
  end else begin
    case ({cstate,nstate})
      {IDLE,IDLE}: begin
        Function_Done <= 0;
        out_ready     <= 1'b0;
      end
      {IDLE,UNPACK}: begin
        a <= i_poly[96+(96*n)-1 -: 96];
        n <= n + 1;

        // DEBUG:
        // synthesis translate_off
        rpoly     <= i_rand[128+(128*n)-1 -: 128];
        // synthesis translate_on
      end
      {UNPACK,MASK}: begin
        out_ready       <= 1'b0;
        P1_mask_enable  <= 1'b1;
      end
      {MASK,MASK}: begin
        P1_mask_enable  <= 1'b0;
      end
      {MASK,UNPACK}: begin
        out_ready <= 1'b1;
        o_poly_s1 <= rand_poly;
        o_poly_s2 <= masked_poly;
        a         <= i_poly[96+(96*n)-1 -: 96];
        n         <= n + 1;

        // DEBUG:
        // synthesis translate_off
        rpoly     <= i_rand[128+(128*n)-1 -: 128];
        // synthesis translate_on
      end
      {MASK,IDLE}: begin
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

State_Unpack__poly_frombytes__r P0 (a, r);

// State_Unpack__rand_csuq P1 (rand, PRNG_data);

State_Unpack__mask P1 (
  .clk(clk),
  .rst_n(resetn),
  .enable(P1_mask_enable),
  .PRNG_data(PRNG_data),
  .s(r),
  .function_done(mask_outready),
  .s1(rand_poly), 
  .s2(masked_poly)
);
  
endmodule
