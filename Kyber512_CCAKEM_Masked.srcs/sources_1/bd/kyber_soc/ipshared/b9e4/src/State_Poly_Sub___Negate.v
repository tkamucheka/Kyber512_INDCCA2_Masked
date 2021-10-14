module State_Poly_Sub___Negate #(
  parameter i_Coeffs_Width = 128,
  parameter o_Coeffs_Width = 128
) (
  input         [i_Coeffs_Width-1 : 0] iCoeffs,
  output signed [o_Coeffs_Width-1 : 0] oCoeffs
);

assign oCoeffs[ 15 -: 16] = $signed(-iCoeffs[ 15 -: 16]);
assign oCoeffs[ 31 -: 16] = $signed(-iCoeffs[ 31 -: 16]);
assign oCoeffs[ 47 -: 16] = $signed(-iCoeffs[ 47 -: 16]);
assign oCoeffs[ 63 -: 16] = $signed(-iCoeffs[ 63 -: 16]);
assign oCoeffs[ 79 -: 16] = $signed(-iCoeffs[ 79 -: 16]);
assign oCoeffs[ 95 -: 16] = $signed(-iCoeffs[ 95 -: 16]);
assign oCoeffs[111 -: 16] = $signed(-iCoeffs[111 -: 16]);
assign oCoeffs[127 -: 16] = $signed(-iCoeffs[127 -: 16]);

endmodule