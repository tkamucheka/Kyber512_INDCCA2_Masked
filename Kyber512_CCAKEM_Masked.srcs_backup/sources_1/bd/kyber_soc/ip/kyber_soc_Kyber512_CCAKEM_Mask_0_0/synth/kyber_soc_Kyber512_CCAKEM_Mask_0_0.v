// (c) Copyright 1995-2021 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: uark.edu:user:Kyber512_CCAKEM_Masked_IP:1.0
// IP Revision: 12

(* X_CORE_INFO = "Kyber512_CCAKEM_Masked_IP_v1_0,Vivado 2019.1" *)
(* CHECK_LICENSE_TYPE = "kyber_soc_Kyber512_CCAKEM_Mask_0_0,Kyber512_CCAKEM_Masked_IP_v1_0,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module kyber_soc_Kyber512_CCAKEM_Mask_0_0 (
  kyber_aclk,
  kyber_aresetn,
  PRNG_data,
  trigger1,
  trigger2,
  s01_axi_awaddr,
  s01_axi_awprot,
  s01_axi_awvalid,
  s01_axi_awready,
  s01_axi_wdata,
  s01_axi_wstrb,
  s01_axi_wvalid,
  s01_axi_wready,
  s01_axi_bresp,
  s01_axi_bvalid,
  s01_axi_bready,
  s01_axi_araddr,
  s01_axi_arprot,
  s01_axi_arvalid,
  s01_axi_arready,
  s01_axi_rdata,
  s01_axi_rresp,
  s01_axi_rvalid,
  s01_axi_rready,
  s01_axi_aclk,
  s01_axi_aresetn,
  s00_axi_awaddr,
  s00_axi_awprot,
  s00_axi_awvalid,
  s00_axi_awready,
  s00_axi_wdata,
  s00_axi_wstrb,
  s00_axi_wvalid,
  s00_axi_wready,
  s00_axi_bresp,
  s00_axi_bvalid,
  s00_axi_bready,
  s00_axi_araddr,
  s00_axi_arprot,
  s00_axi_arvalid,
  s00_axi_arready,
  s00_axi_rdata,
  s00_axi_rresp,
  s00_axi_rvalid,
  s00_axi_rready,
  s00_axi_aclk,
  s00_axi_aresetn
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME kyber_aclk, ASSOCIATED_RESET kyber_aresetn, ASSOCIATED_BUSIF kyber_aclk, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN kyber_soc_clk_wiz_1_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 kyber_aclk CLK" *)
input wire kyber_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME kyber_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 kyber_aresetn RST" *)
input wire kyber_aresetn;
input wire [15 : 0] PRNG_data;
output wire trigger1;
output wire trigger2;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWADDR" *)
input wire [4 : 0] s01_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWPROT" *)
input wire [2 : 0] s01_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWVALID" *)
input wire s01_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI AWREADY" *)
output wire s01_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WDATA" *)
input wire [31 : 0] s01_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WSTRB" *)
input wire [3 : 0] s01_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WVALID" *)
input wire s01_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI WREADY" *)
output wire s01_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BRESP" *)
output wire [1 : 0] s01_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BVALID" *)
output wire s01_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI BREADY" *)
input wire s01_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARADDR" *)
input wire [4 : 0] s01_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARPROT" *)
input wire [2 : 0] s01_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARVALID" *)
input wire s01_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI ARREADY" *)
output wire s01_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RDATA" *)
output wire [31 : 0] s01_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RRESP" *)
output wire [1 : 0] s01_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RVALID" *)
output wire s01_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN kyber_soc_clk_wiz_1_0_clk\
_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S01_AXI RREADY" *)
input wire s01_axi_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXI_CLK, ASSOCIATED_BUSIF S01_AXI, ASSOCIATED_RESET s01_axi_aresetn, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN kyber_soc_clk_wiz_1_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S01_AXI_CLK CLK" *)
input wire s01_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S01_AXI_RST RST" *)
input wire s01_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *)
input wire [4 : 0] s00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *)
input wire [2 : 0] s00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *)
input wire s00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *)
output wire s00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *)
input wire [31 : 0] s00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *)
input wire [3 : 0] s00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *)
input wire s00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *)
output wire s00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *)
output wire [1 : 0] s00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *)
output wire s00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *)
input wire s00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *)
input wire [4 : 0] s00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *)
input wire [2 : 0] s00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *)
input wire s00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *)
output wire s00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *)
output wire [31 : 0] s00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *)
output wire [1 : 0] s00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *)
output wire s00_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 5, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN kyber_soc_clk_wiz_1_0_clk\
_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *)
input wire s00_axi_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN kyber_soc_clk_wiz_1_0_clk_out1, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST" *)
input wire s00_axi_aresetn;

  Kyber512_CCAKEM_Masked_IP_v1_0 #(
    .C_S01_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S01_AXI_ADDR_WIDTH(5),  // Width of S_AXI address bus
    .C_S00_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S00_AXI_ADDR_WIDTH(5),  // Width of S_AXI address bus
    .KYBER_K(2),
    .KYBER_N(256),
    .KYBER_Q(3329),
    .Byte_bits(8),
    .KYBER_512_SKBytes(1632),
    .KYBER_512_PKBytes(800),
    .KYBER_512_CtBytes(736),
    .KYBER_512_SSBytes(32),
    .KYBER_512_RandBytes(32),
    .RAND_SZ(256),
    .CIPHERTEXT_SZ(5888),
    .SECRET_KEY_SZ(13056),
    .SHARED_SECRET_SZ(256),
    .PUBLIC_KEY_SZ(6400)
  ) inst (
    .kyber_aclk(kyber_aclk),
    .kyber_aresetn(kyber_aresetn),
    .PRNG_data(PRNG_data),
    .trigger1(trigger1),
    .trigger2(trigger2),
    .s01_axi_awaddr(s01_axi_awaddr),
    .s01_axi_awprot(s01_axi_awprot),
    .s01_axi_awvalid(s01_axi_awvalid),
    .s01_axi_awready(s01_axi_awready),
    .s01_axi_wdata(s01_axi_wdata),
    .s01_axi_wstrb(s01_axi_wstrb),
    .s01_axi_wvalid(s01_axi_wvalid),
    .s01_axi_wready(s01_axi_wready),
    .s01_axi_bresp(s01_axi_bresp),
    .s01_axi_bvalid(s01_axi_bvalid),
    .s01_axi_bready(s01_axi_bready),
    .s01_axi_araddr(s01_axi_araddr),
    .s01_axi_arprot(s01_axi_arprot),
    .s01_axi_arvalid(s01_axi_arvalid),
    .s01_axi_arready(s01_axi_arready),
    .s01_axi_rdata(s01_axi_rdata),
    .s01_axi_rresp(s01_axi_rresp),
    .s01_axi_rvalid(s01_axi_rvalid),
    .s01_axi_rready(s01_axi_rready),
    .s01_axi_aclk(s01_axi_aclk),
    .s01_axi_aresetn(s01_axi_aresetn),
    .s00_axi_awaddr(s00_axi_awaddr),
    .s00_axi_awprot(s00_axi_awprot),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata(s00_axi_wdata),
    .s00_axi_wstrb(s00_axi_wstrb),
    .s00_axi_wvalid(s00_axi_wvalid),
    .s00_axi_wready(s00_axi_wready),
    .s00_axi_bresp(s00_axi_bresp),
    .s00_axi_bvalid(s00_axi_bvalid),
    .s00_axi_bready(s00_axi_bready),
    .s00_axi_araddr(s00_axi_araddr),
    .s00_axi_arprot(s00_axi_arprot),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata(s00_axi_rdata),
    .s00_axi_rresp(s00_axi_rresp),
    .s00_axi_rvalid(s00_axi_rvalid),
    .s00_axi_rready(s00_axi_rready),
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn)
  );
endmodule
