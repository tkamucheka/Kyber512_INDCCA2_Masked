//////////////////////////////////////////////////////////////////////////////////
// Module Name: State_Unpack
// Project Name: Kyber512_AC701
// Target Devices: AC701
// Author: YIMING,HUANG
// Additional Comments: Reusable for Encryption and Decryption
//////////////////////////////////////////////////////////////////////////////////

 module State_Unpack #(
 parameter KYBER_K = 2,
 parameter KYBER_N = 256,
 parameter Byte_bits = 8,
 parameter Seed_Bytes = 32,
 parameter KYBER_POLYBYTES = 384,
 parameter Length = 128,
 parameter o_BRAM_Length = 128,
 parameter PK_Size = Byte_bits * (KYBER_POLYBYTES * KYBER_K + Seed_Bytes),
 parameter SK_Size = Byte_bits * KYBER_POLYBYTES * KYBER_K,
 parameter PolyBytes_Size = Byte_bits * KYBER_POLYBYTES, 
 parameter Seed_Size = Byte_bits * Seed_Bytes
 )(
  input                     clk,
  input                     rst_n,
  input                     enable,
  input                     mux_enc_dec,//enc0,dec1
  input  [PK_Size-1 : 0]    ipackedpk,
  input  [SK_Size-1 : 0]    ipackedsk,
  input  [15:0]             PRNG_data, 
  output reg                Function_Done,  
  output wire               PRNG_enable,
  output reg                EncPk_DecSk_PolyVec_outready,
  output reg [5 : 0]        EncPk_DecSk_PolyVec_WAd,
  output reg [Length-1 : 0] EncPk_DecSk1_PolyVec_WData,
  output reg [Length-1 : 0] EncPk_DecSk2_PolyVec_WData
  // DEBUG:
  // output reg [Length-1 : 0] unpackedpk_debug
);

reg           P0_enable;
wire          P0_done;
wire          P0_out_ready;
wire [127:0]  P0_o_poly_s1, P0_o_poly_s2;

reg [1:0] cstate, nstate; // current_state, next_state

localparam IDLE           = 2'd0;
localparam LOAD           = 2'd1;
localparam SendEnc        = 2'd2;
localparam SendDec        = 2'd3;

localparam  o = (Seed_Size)+84-1, p = (Seed_Size)+96-1,
            m = (Seed_Size)+80-1, n = (Seed_Size)+88-1,
            k = (Seed_Size)+60-1, l = (Seed_Size)+72-1,
            i = (Seed_Size)+56-1, j = (Seed_Size)+64-1,
            g = (Seed_Size)+36-1, h = (Seed_Size)+48-1, 
            e = (Seed_Size)+32-1, f = (Seed_Size)+40-1,
            c = (Seed_Size)+12-1, d = (Seed_Size)+24-1,
            a = (Seed_Size)+8-1,  b = (Seed_Size)+16-1;

always @(posedge clk or negedge rst_n)
  if(!rst_n)  cstate <= IDLE;
  else        cstate <= nstate;

always @(cstate or enable or mux_enc_dec or P0_done or EncPk_DecSk_PolyVec_WAd) begin       
  case(cstate)
    IDLE:     if(enable && mux_enc_dec)         nstate <= LOAD;
              else if(enable)                   nstate <= SendEnc;
              else                              nstate <= IDLE;
    LOAD:                                       nstate <= SendDec;
    SendDec:  if(P0_done)                       nstate <= IDLE;
              else                              nstate <= SendDec;
    SendEnc:  if(EncPk_DecSk_PolyVec_WAd == 63) nstate <= IDLE;
              else                              nstate <= SendEnc;
    default:                                    nstate <= IDLE;
  endcase
end

always @(posedge clk)
  if (!rst_n) begin
    Function_Done                 <= 1'b0;        
    EncPk_DecSk_PolyVec_outready  <= 1'b0;
    EncPk_DecSk_PolyVec_WAd       <= 0;
    EncPk_DecSk1_PolyVec_WData    <= 0;
    EncPk_DecSk2_PolyVec_WData    <= 0;
  end else begin
    case({cstate,nstate})
      {IDLE,IDLE}: Function_Done        <= 1'b0;
      {IDLE,SendEnc}: begin
          EncPk_DecSk_PolyVec_outready  <= 1'b1;
          EncPk_DecSk_PolyVec_WAd       <= 0;
          
          EncPk_DecSk1_PolyVec_WData      <= {
            4'h0, ipackedpk [o -: 4], ipackedpk [p -: 8],
            4'h0, ipackedpk [m -: 8], ipackedpk [n -: 4],
            4'h0, ipackedpk [k -: 4], ipackedpk [l -: 8],
            4'h0, ipackedpk [i -: 8], ipackedpk [j -: 4],
            4'h0, ipackedpk [g -: 4], ipackedpk [h -: 8],
            4'h0, ipackedpk [e -: 8], ipackedpk [f -: 4],
            4'h0, ipackedpk [c -: 4], ipackedpk [d -: 8],
            4'h0, ipackedpk [a -: 8], ipackedpk [b -: 4]
          };
        end
      {SendEnc,SendEnc}: begin
          EncPk_DecSk_PolyVec_outready  <= 1'b1;
          EncPk_DecSk_PolyVec_WAd       <= EncPk_DecSk_PolyVec_WAd + 1;

          EncPk_DecSk1_PolyVec_WData      <= {
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+o -: 4], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+p -: 8],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+m -: 8], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+n -: 4],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+k -: 4], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+l -: 8],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+i -: 8], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+j -: 4],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+g -: 4], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+h -: 8],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+e -: 8], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+f -: 4],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+c -: 4], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+d -: 8],
            4'h0, ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+a -: 8], ipackedpk[((EncPk_DecSk_PolyVec_WAd+1)*96)+b -: 4]
          };
          end
      {SendEnc,IDLE}: begin
          Function_Done                 <= 1'b1;        
          EncPk_DecSk_PolyVec_outready  <= 1'b0;
          EncPk_DecSk_PolyVec_WAd       <= 0;
          EncPk_DecSk1_PolyVec_WData    <= 0;
          // DEBUG:
          // unpackedpk_debug               <= EncPk_DecSk1_PolyVec_WData;
        end 
      {IDLE,LOAD}: begin
          P0_enable <= 1'b1;
        end
      {LOAD,SendDec}: begin
        P0_enable                       <= 1'b0;
        EncPk_DecSk_PolyVec_WAd         <= -1;
      end
      {SendDec,SendDec}: begin
        if (P0_out_ready) begin
          EncPk_DecSk_PolyVec_WAd       <= EncPk_DecSk_PolyVec_WAd + 1;
          EncPk_DecSk1_PolyVec_WData    <= P0_o_poly_s1;
          EncPk_DecSk2_PolyVec_WData    <= P0_o_poly_s2;    
          EncPk_DecSk_PolyVec_outready  <= 1'b1;
        end else begin
          EncPk_DecSk_PolyVec_outready  <= 1'b0;
        end
      end
      {SendDec,IDLE}: begin
          Function_Done                 <= 1'b1;
          EncPk_DecSk_PolyVec_outready  <= 1'b0;
          EncPk_DecSk_PolyVec_WAd       <= 0;
          EncPk_DecSk1_PolyVec_WData    <= 0;
          EncPk_DecSk2_PolyVec_WData    <= 0;
        end                     
      default: ;
    endcase
  end


State_Unpack__poly_frombytes P0 (
  .clk(clk),
  .resetn(rst_n),
  .enable(P0_enable),
  .i_poly(ipackedsk),
  .PRNG_data(PRNG_data),
  .Function_Done(P0_done),
  .PRNG_enable(PRNG_enable),
  .out_ready(P0_out_ready),
  .o_poly_s1(P0_o_poly_s1),
  .o_poly_s2(P0_o_poly_s2)
);

endmodule

