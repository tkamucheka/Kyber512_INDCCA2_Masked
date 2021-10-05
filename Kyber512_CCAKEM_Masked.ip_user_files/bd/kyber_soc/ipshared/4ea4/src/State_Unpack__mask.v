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

module State_Unpack__mask #(parameter KYBER_Q = 3329)(
  input              clk,
  input              rst_n,
  input              enable,
  input      [ 15:0] rand,
  input      [127:0] s,
  output reg         function_done,
  output reg [127:0] s1, 
  output reg [127:0] s2
);

reg [7:0] m;

reg  [15:0] dividend_tdata;
wire [15:0] divisor_tdata;
wire [31:0] dout_tdata;

reg  divisor_tvalid, dividend_tvalid;
wire dout_tvalid;

assign divisor_tdata = KYBER_Q;

reg [3:0] cstate,nstate;
localparam IDLE = 4'd0;
localparam DIV  = 4'd1;
localparam WAIT = 4'd2;
localparam PUSH = 4'd3;

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0)  cstate <= IDLE;
  else                cstate <= nstate;
end

always @(cstate, enable, dout_tvalid, m) begin
  case (cstate)
    IDLE:     if (enable)       nstate <= DIV;
              else              nstate <= IDLE;
    DIV:      if (m > 8)        nstate <= WAIT;
              else              nstate <= DIV;
    WAIT:     if (dout_tvalid)  nstate <= PUSH;
              else              nstate <= WAIT;
    PUSH:     if (m > 8)        nstate <= IDLE;
              else              nstate <= PUSH; 
    default:                    nstate <= IDLE;
  endcase
end

always @(posedge clk or negedge rst_n) begin
  if (rst_n == 1'b0) begin
    m  <= 0;
    s1 <= 128'd0;
    s2 <= 128'd0;
  end else begin
    case ({cstate,nstate})
      {IDLE,IDLE}: begin
        function_done <= 1'b0;
        m <= 0;
      end
      {IDLE,DIV}: begin
        s1[127-(m*16) -: 16] <= rand;
        dividend_tdata       <= s[127-(m*16) -: 16] - rand + KYBER_Q;
        dividend_tvalid      <= 1'b1;
        divisor_tvalid       <= 1'b1;
      end
      {DIV,DIV}: begin
        s2[127-(m*16) -: 16] <= dout_tdata[15:0];

        s1[127-((m+1)*16) -: 16] <= rand;
        dividend_tdata           <= s[127-((m+1)*16) -: 16] - rand + KYBER_Q;
        dividend_tvalid          <= 1'b1;
        divisor_tvalid           <= 1'b1;
        m                        <= m + 1;
      end
      {DIV,WAIT}: begin
        dividend_tvalid          <= 1'b0;
        divisor_tvalid           <= 1'b0;
        m                        <= 0;
      end
      {WAIT,WAIT}: ;
      {WAIT,PUSH}: begin
        s2[127-(m*16) -: 16] <= dout_tdata[15:0];
        m <= m + 1;
      end
      {PUSH,PUSH}: begin
        s2[127-(m*16) -: 16] <= dout_tdata[15:0];
        m <= m + 1;
      end
      {PUSH,IDLE}: begin
        function_done <= 1'b1;
      end
      default: ;
    endcase
  end
  
end

MOD_Q_Div P0 (
.aclk(clk),
.s_axis_divisor_tvalid(divisor_tvalid),
.s_axis_divisor_tdata(divisor_tdata),
.s_axis_dividend_tvalid(dividend_tvalid),
.s_axis_dividend_tdata(dividend_tdata),
.m_axis_dout_tvalid(dout_tvalid),
.m_axis_dout_tdata(dout_tdata)
);

endmodule