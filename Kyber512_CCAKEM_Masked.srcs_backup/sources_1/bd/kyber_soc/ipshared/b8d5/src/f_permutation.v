/*
 * Copyright 2013, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* if "ack" is 1, then current input has been used. */

module f_permutation #(
  parameter r = 576,  // bitrate
  parameter c = 1024, // capacity
  parameter d = 512   // output length
) (clk, resetn, in, in_ready, ack, out, out_ready);
    input                     clk, resetn;
    input      [r-1:0]        in;
    input                     in_ready;
    output                    ack;
    output reg [1599:0]       out;
    output reg                out_ready;

    reg        [10:0]         i; /* select round constant */
    wire       [1599:0]       round_in, round_out;
    wire       [63:0]         rc1, rc2;
    wire                      update;
    wire                      accept;
    reg                       calc; /* == 1: calculating rounds */
    reg                       ready_tick;

    assign accept = in_ready & (~ calc); // in_ready & (i == 0)
    
    always @ (posedge clk)
      if (resetn) i <= 0;
      else       i <= {i[9:0], accept};
    
    always @ (posedge clk)
      if (resetn) calc <= 0;
      else       calc <= (calc & (~ i[10])) | accept;
    
    assign update = calc | accept;

    assign ack = accept;

    always @ (posedge clk)
      if (resetn) begin
        out_ready <= 0;
        ready_tick <= 0;
      end else if (accept)
        out_ready <= 0;
      else if (i[10] & ~ready_tick) begin // only change at the last round
        out_ready <= 1;
        ready_tick <= 1;
      end else begin
        out_ready <= 0;
        ready_tick <= 0;
      end

    assign round_in = accept ? {in ^ out[1599 -: r], out[0 +: c]} : out;

    rconst2in1
      rconst_ (
        .i({i, accept}), .rc1(rc1), .rc2(rc2)
      );

    round2in1
      round_ (
        .in(round_in), 
        .round_const_1(rc1), 
        .round_const_2(rc2), 
        .out(round_out)
      );

    always @ (posedge clk)
      if (resetn)
        out <= 0;
      else if (update)
        out <= round_out;
endmodule
