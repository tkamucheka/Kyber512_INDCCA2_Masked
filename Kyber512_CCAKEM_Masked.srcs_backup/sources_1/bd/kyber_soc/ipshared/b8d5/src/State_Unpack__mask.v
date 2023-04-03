`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arkansas
// Engineer: Tendayi Kamucheka (ftendayi@gmail.com)
// 
// Create Date: 08/01/2021 01:51:42 AM
// Design Name: Kyber512 INDCCA
// Module Name: State_Unpack__mask
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

module State_Unpack__mask #(
  parameter KYBER_Q = 3329,
  parameter COEFF_SZ = 16
) (
  input                     clk,
  input                     rst_n,
  input                     enable,
  input      [COEFF_SZ-1:0] PRNG_data,
  input             [127:0] s,
  output reg                function_done,
  output reg        [127:0] s1, 
  output reg        [127:0] s2
);

reg [3:0]           m;
reg [COEFF_SZ-1:0]  a;
reg                 reduce_enable;
wire                data_valid;
wire [COEFF_SZ-1:0] y;
wire [COEFF_SZ-1:0] w_rand;

reg [1:0] cstate,nstate;
localparam IDLE   = 2'd0;
localparam REDUCE = 2'd1;
localparam PUSH   = 2'd2;

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0)  cstate <= IDLE;
  else                cstate <= nstate;
end

always @(cstate, enable, m, data_valid) begin
  case (cstate)
    IDLE:     if (enable)       nstate <= REDUCE;
              else              nstate <= IDLE;
    REDUCE:   if (m == 7)       nstate <= PUSH;
              else              nstate <= REDUCE;
    PUSH:     if (!data_valid)  nstate <= IDLE;
              else              nstate <= PUSH; 
    default:                    nstate <= IDLE;
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    m  <= 0;
    s1 <= 128'd0;
  end else begin
    case ({cstate,nstate})
      {IDLE,IDLE}: begin
        function_done <= 1'b0;
        m             <= 0;
      end
      {IDLE,REDUCE}: begin
        s1[127-(m*16) -: 16]     <= w_rand; // rand[127-(m*16) -: 16];
        a                        <= s[127-(m*16) -: 16] - w_rand + KYBER_Q;
        reduce_enable            <= 1'b1;
      end
      {REDUCE,REDUCE}: begin
        s1[127-((m+1)*16) -: 16] <= w_rand; // rand[127-((m+1)*16) -: 16];
        a                        <= s[127-((m+1)*16) -: 16] - w_rand + KYBER_Q;
        m                        <= m + 1;
        reduce_enable            <= 1'b1;
      end
      {REDUCE,PUSH}: begin
        reduce_enable            <= 1'b0;
      end
      {PUSH,PUSH}: ;
      {PUSH,IDLE}: begin
        function_done <= 1'b1;
      end
      default: ;
    endcase
  end
end

reg [3:0] w = 0;
always @(posedge clk) begin
  if (rst_n == 1'b0) begin
    s2 <= 128'h0;
    w  <= 0;
  end else begin
    if (data_valid) begin
      s2[127-(w*16) -: 16] <= y;
      w <= w + 1;
    end else begin
      w <= 0;
    end
  end
end

State_Unpack__mask_RNG_core P0 (
  .clk(clk),
  .rst_n(rst_n),
  .seed(PRNG_data),
  .rand(w_rand)
);

Barrett_Reduce P1 (
  .clk(clk),
  .ce(reduce_enable),
  .iCoeffs_a(a),
  .oCoeffs(y),
  .reduce_done(data_valid)
);


endmodule