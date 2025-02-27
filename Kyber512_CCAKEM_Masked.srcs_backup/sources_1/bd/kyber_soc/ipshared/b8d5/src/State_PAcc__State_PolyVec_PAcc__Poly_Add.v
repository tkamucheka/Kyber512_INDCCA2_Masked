//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2019 12:18:10 PM
// Design Name: 
// Module Name: State_PolyVec_PAcc__Poly_Add
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


module State_PAcc__Poly_PAcc__Poly_Add#(
  parameter KYBER_K = 2,
  parameter KYBER_N = 256,
  parameter KYBER_Q = 3329,
  parameter i_Coeffs_Width_a = 16,
  parameter i_Coeffs_Width_b = 16,
  parameter o_Coeffs_Width = 16,
  parameter i_Poly_a_Size = i_Coeffs_Width_a * KYBER_N,
  parameter i_Poly_b_Size = i_Coeffs_Width_b * KYBER_N,
  parameter o_Poly_Size = o_Coeffs_Width * KYBER_N
)(
	input clk,		
	input reset_n,
	input enable,	
	input [i_Poly_a_Size-1 : 0] iPoly_a,
	input [i_Poly_b_Size-1 : 0] iPoly_b,
	output reg Poly_Add_done,
	output reg [o_Poly_Size -1 : 0]  oPoly
); 

reg  [i_Coeffs_Width_a-1 : 0] P1_iCoeffs_a;
reg  [i_Coeffs_Width_a-1 : 0] P1_iCoeffs_b;
wire [o_Coeffs_Width-1   : 0] P1_oCoeffs;	
// reg  signed [i_Coeffs_Width_a-1 : 0] Poly_Coeffs_a [KYBER_N : 0];
// reg  signed [i_Coeffs_Width_b-1 : 0] Poly_Coeffs_b [KYBER_N : 0];
// reg  [o_Coeffs_Width-1 : 0]  o_Poly_Coeffs [KYBER_N-1 : 0];
// integer a;
// integer b;
integer i;

reg [1:0] cstate,nstate;
localparam IDLE		        = 2'd0;
localparam Data_Pre   		= 2'd1;
localparam Add            = 2'd2;

always @(posedge clk or negedge reset_n)
	if (!reset_n) cstate <= IDLE;
	else 					cstate <= nstate;
	
always @(cstate or enable  or i ) 
begin				
	case(cstate)
		IDLE: 	  if(enable) 		nstate = Data_Pre;
				   		else 					nstate = IDLE;
		Data_Pre:    						nstate = Add;		       
		Add:      if(i == 256) 	nstate = IDLE;
		          else 					nstate = Add; 					
		default: 								nstate <= IDLE;
	endcase
end

always @(posedge clk or negedge reset_n)										
	if(!reset_n) begin
		Poly_Add_done <= 1'b0;
		oPoly 				<= 0;
		// a 						<= 0;
		// b 						<= 0;
		i 						<= 0;
	end else begin
		case({cstate,nstate})
			{IDLE,IDLE}: begin
					Poly_Add_done <=  1'b0;	
				end
			{IDLE,Data_Pre}:begin
					// BUG: Slow
					// for(a=0;a<256;a=a+1) begin
					//  Poly_Coeffs_a[a] <= $signed(iPoly_a[(i_Poly_a_Size-1)-((255-a)*16) -: 16]);
					//                      end 
					// for(b=0;b<256;b=b+1) begin
					//  Poly_Coeffs_b[b] <= $signed(iPoly_b[(i_Poly_b_Size-1)-((255-b)*16) -: 16]);
					//                      end
					//  Poly_Coeffs_a[256] <= 0;
					//  Poly_Coeffs_b[256] <= 0;
					i <= 0;                   
				end				       			
			{Data_Pre,Add}: begin
					// P1_iCoeffs_a <= Poly_Coeffs_a[0];
					// P1_iCoeffs_b <= Poly_Coeffs_b[0];
					P1_iCoeffs_a <= iPoly_a[(i_Poly_a_Size-1)-(i*16) -: 16];
					P1_iCoeffs_b <= iPoly_b[(i_Poly_b_Size-1)-(i*16) -: 16];
					i 					 <= 1;	
				end	
			{Add,Add}: begin
					// o_Poly_Coeffs[i-1] <= P1_oCoeffs;
					// P1_iCoeffs_a <= Poly_Coeffs_a[i];
					// P1_iCoeffs_b <= Poly_Coeffs_b[i];
					oPoly[(o_Poly_Size-1)-((i-1)*16) -: 16]	<= P1_oCoeffs;
					P1_iCoeffs_a 														<= iPoly_a[(i_Poly_a_Size-1)-(i*16) -: 16];
					P1_iCoeffs_b 														<= iPoly_b[(i_Poly_b_Size-1)-(i*16) -: 16];		
					i 																			<= i + 1;
				end	            			 					           					
			{Add,IDLE}: begin
					oPoly[(o_Poly_Size-1)-((i-1)*16) -: 16]	<= P1_oCoeffs;
					Poly_Add_done 													<= 1'b1;
					i 																			<= 0;
          // $display("PACC Add (OUT) %h", {oPoly[(o_Poly_Size-1) : 16], P1_oCoeffs});
					// BUG: Inefficient
					// oPoly <= {o_Poly_Coeffs[255],o_Poly_Coeffs[254],o_Poly_Coeffs[253],o_Poly_Coeffs[252],o_Poly_Coeffs[251],o_Poly_Coeffs[250],o_Poly_Coeffs[249],o_Poly_Coeffs[248],o_Poly_Coeffs[247],o_Poly_Coeffs[246],o_Poly_Coeffs[245],o_Poly_Coeffs[244],o_Poly_Coeffs[243],o_Poly_Coeffs[242],o_Poly_Coeffs[241],o_Poly_Coeffs[240],o_Poly_Coeffs[239],o_Poly_Coeffs[238],o_Poly_Coeffs[237],o_Poly_Coeffs[236],o_Poly_Coeffs[235],o_Poly_Coeffs[234],o_Poly_Coeffs[233],o_Poly_Coeffs[232],o_Poly_Coeffs[231],o_Poly_Coeffs[230],o_Poly_Coeffs[229],o_Poly_Coeffs[228],o_Poly_Coeffs[227],o_Poly_Coeffs[226],o_Poly_Coeffs[225],o_Poly_Coeffs[224],o_Poly_Coeffs[223],o_Poly_Coeffs[222],o_Poly_Coeffs[221],o_Poly_Coeffs[220],o_Poly_Coeffs[219],o_Poly_Coeffs[218],o_Poly_Coeffs[217],o_Poly_Coeffs[216],o_Poly_Coeffs[215],o_Poly_Coeffs[214],o_Poly_Coeffs[213],o_Poly_Coeffs[212],o_Poly_Coeffs[211],o_Poly_Coeffs[210],o_Poly_Coeffs[209],o_Poly_Coeffs[208],o_Poly_Coeffs[207],o_Poly_Coeffs[206],o_Poly_Coeffs[205],o_Poly_Coeffs[204],o_Poly_Coeffs[203],o_Poly_Coeffs[202],o_Poly_Coeffs[201],o_Poly_Coeffs[200],o_Poly_Coeffs[199],o_Poly_Coeffs[198],o_Poly_Coeffs[197],o_Poly_Coeffs[196],o_Poly_Coeffs[195],o_Poly_Coeffs[194],o_Poly_Coeffs[193],o_Poly_Coeffs[192],o_Poly_Coeffs[191],o_Poly_Coeffs[190],o_Poly_Coeffs[189],o_Poly_Coeffs[188],o_Poly_Coeffs[187],o_Poly_Coeffs[186],o_Poly_Coeffs[185],o_Poly_Coeffs[184],o_Poly_Coeffs[183],o_Poly_Coeffs[182],o_Poly_Coeffs[181],o_Poly_Coeffs[180],o_Poly_Coeffs[179],o_Poly_Coeffs[178],o_Poly_Coeffs[177],o_Poly_Coeffs[176],o_Poly_Coeffs[175],o_Poly_Coeffs[174],o_Poly_Coeffs[173],o_Poly_Coeffs[172],o_Poly_Coeffs[171],o_Poly_Coeffs[170],o_Poly_Coeffs[169],o_Poly_Coeffs[168],o_Poly_Coeffs[167],o_Poly_Coeffs[166],o_Poly_Coeffs[165],o_Poly_Coeffs[164],o_Poly_Coeffs[163],o_Poly_Coeffs[162],o_Poly_Coeffs[161],o_Poly_Coeffs[160],o_Poly_Coeffs[159],o_Poly_Coeffs[158],o_Poly_Coeffs[157],o_Poly_Coeffs[156],o_Poly_Coeffs[155],o_Poly_Coeffs[154],o_Poly_Coeffs[153],o_Poly_Coeffs[152],o_Poly_Coeffs[151],o_Poly_Coeffs[150],o_Poly_Coeffs[149],o_Poly_Coeffs[148],o_Poly_Coeffs[147],o_Poly_Coeffs[146],o_Poly_Coeffs[145],o_Poly_Coeffs[144],o_Poly_Coeffs[143],o_Poly_Coeffs[142],o_Poly_Coeffs[141],o_Poly_Coeffs[140],o_Poly_Coeffs[139],o_Poly_Coeffs[138],o_Poly_Coeffs[137],o_Poly_Coeffs[136],o_Poly_Coeffs[135],o_Poly_Coeffs[134],o_Poly_Coeffs[133],o_Poly_Coeffs[132],o_Poly_Coeffs[131],o_Poly_Coeffs[130],o_Poly_Coeffs[129],o_Poly_Coeffs[128],o_Poly_Coeffs[127],o_Poly_Coeffs[126],o_Poly_Coeffs[125],o_Poly_Coeffs[124],o_Poly_Coeffs[123],o_Poly_Coeffs[122],o_Poly_Coeffs[121],o_Poly_Coeffs[120],o_Poly_Coeffs[119],o_Poly_Coeffs[118],o_Poly_Coeffs[117],o_Poly_Coeffs[116],o_Poly_Coeffs[115],o_Poly_Coeffs[114],o_Poly_Coeffs[113],o_Poly_Coeffs[112],o_Poly_Coeffs[111],o_Poly_Coeffs[110],o_Poly_Coeffs[109],o_Poly_Coeffs[108],o_Poly_Coeffs[107],o_Poly_Coeffs[106],o_Poly_Coeffs[105],o_Poly_Coeffs[104],o_Poly_Coeffs[103],o_Poly_Coeffs[102],o_Poly_Coeffs[101],o_Poly_Coeffs[100],o_Poly_Coeffs[99],o_Poly_Coeffs[98],o_Poly_Coeffs[97],o_Poly_Coeffs[96],o_Poly_Coeffs[95],o_Poly_Coeffs[94],o_Poly_Coeffs[93],o_Poly_Coeffs[92],o_Poly_Coeffs[91],o_Poly_Coeffs[90],o_Poly_Coeffs[89],o_Poly_Coeffs[88],o_Poly_Coeffs[87],o_Poly_Coeffs[86],o_Poly_Coeffs[85],o_Poly_Coeffs[84],o_Poly_Coeffs[83],o_Poly_Coeffs[82],o_Poly_Coeffs[81],o_Poly_Coeffs[80],o_Poly_Coeffs[79],o_Poly_Coeffs[78],o_Poly_Coeffs[77],o_Poly_Coeffs[76],o_Poly_Coeffs[75],o_Poly_Coeffs[74],o_Poly_Coeffs[73],o_Poly_Coeffs[72],o_Poly_Coeffs[71],o_Poly_Coeffs[70],o_Poly_Coeffs[69],o_Poly_Coeffs[68],o_Poly_Coeffs[67],o_Poly_Coeffs[66],o_Poly_Coeffs[65],o_Poly_Coeffs[64],o_Poly_Coeffs[63],o_Poly_Coeffs[62],o_Poly_Coeffs[61],o_Poly_Coeffs[60],o_Poly_Coeffs[59],o_Poly_Coeffs[58],o_Poly_Coeffs[57],o_Poly_Coeffs[56],o_Poly_Coeffs[55],o_Poly_Coeffs[54],o_Poly_Coeffs[53],o_Poly_Coeffs[52],o_Poly_Coeffs[51],o_Poly_Coeffs[50],o_Poly_Coeffs[49],o_Poly_Coeffs[48],o_Poly_Coeffs[47],o_Poly_Coeffs[46],o_Poly_Coeffs[45],o_Poly_Coeffs[44],o_Poly_Coeffs[43],o_Poly_Coeffs[42],o_Poly_Coeffs[41],o_Poly_Coeffs[40],o_Poly_Coeffs[39],o_Poly_Coeffs[38],o_Poly_Coeffs[37],o_Poly_Coeffs[36],o_Poly_Coeffs[35],o_Poly_Coeffs[34],o_Poly_Coeffs[33],o_Poly_Coeffs[32],o_Poly_Coeffs[31],o_Poly_Coeffs[30],o_Poly_Coeffs[29],o_Poly_Coeffs[28],o_Poly_Coeffs[27],o_Poly_Coeffs[26],o_Poly_Coeffs[25],o_Poly_Coeffs[24],o_Poly_Coeffs[23],o_Poly_Coeffs[22],o_Poly_Coeffs[21],o_Poly_Coeffs[20],o_Poly_Coeffs[19],o_Poly_Coeffs[18],o_Poly_Coeffs[17],o_Poly_Coeffs[16],o_Poly_Coeffs[15],o_Poly_Coeffs[14],o_Poly_Coeffs[13],o_Poly_Coeffs[12],o_Poly_Coeffs[11],o_Poly_Coeffs[10],o_Poly_Coeffs[9],o_Poly_Coeffs[8],o_Poly_Coeffs[7],o_Poly_Coeffs[6],o_Poly_Coeffs[5],o_Poly_Coeffs[4],o_Poly_Coeffs[3],o_Poly_Coeffs[2],o_Poly_Coeffs[1],o_Poly_Coeffs[0]};
				end
			default: ;
		endcase
	end
		
State_PAcc__Poly_PAcc__Poly_Add__Data_Cal P1(
.iCoeffs_a(P1_iCoeffs_a),
.iCoeffs_b(P1_iCoeffs_b),
.oCoeffs(P1_oCoeffs)
);		
		
							
endmodule
