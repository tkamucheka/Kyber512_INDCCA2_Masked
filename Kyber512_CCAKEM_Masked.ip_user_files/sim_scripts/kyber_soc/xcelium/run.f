-makelib xcelium_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/microblaze_v11_0_1 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/f8c3/hdl/microblaze_v11_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_microblaze_0_0_1/sim/kyber_soc_microblaze_0_0.vhd" \
-endlib
-makelib xcelium_lib/axi_lite_ipif_v3_0_4 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_pkg_v1_0_2 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_srl_fifo_v1_0_2 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_uartlite_v2_0_23 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/0315/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_axi_uartlite_0_0_1/sim/kyber_soc_axi_uartlite_0_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_v10_v3_0_9 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_dlmb_v10_0_1/sim/kyber_soc_dlmb_v10_0.vhd" \
  "../../../bd/kyber_soc/ip/kyber_soc_ilmb_v10_0_1/sim/kyber_soc_ilmb_v10_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_bram_if_cntlr_v4_0_16 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/6335/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_dlmb_bram_if_cntlr_0_1/sim/kyber_soc_dlmb_bram_if_cntlr_0.vhd" \
  "../../../bd/kyber_soc/ip/kyber_soc_ilmb_bram_if_cntlr_0_1/sim/kyber_soc_ilmb_bram_if_cntlr_0.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_3 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/c001/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_lmb_bram_0_1/sim/kyber_soc_lmb_bram_0.v" \
-endlib
-makelib xcelium_lib/generic_baseblocks_v2_1_0 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_19 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_4 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_4 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_4 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/axi_data_fifo_v2_1_18 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_crossbar_v2_1_20 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/ace7/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_xbar_0_1/sim/kyber_soc_xbar_0.v" \
-endlib
-makelib xcelium_lib/mdm_v3_2_16 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/550e/hdl/mdm_v3_2_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_mdm_1_0_1/sim/kyber_soc_mdm_1_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_clk_wiz_1_0_1/kyber_soc_clk_wiz_1_0_clk_wiz.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_clk_wiz_1_0_1/kyber_soc_clk_wiz_1_0.v" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_rst_clk_wiz_1_100M_0_1/sim/kyber_soc_rst_clk_wiz_1_100M_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ipshared/dc27/hdl/PRNG.v" \
  "../../../bd/kyber_soc/ipshared/dc27/hdl/PRNG_v1_0_S00_AXI.v" \
  "../../../bd/kyber_soc/ipshared/dc27/hdl/PRNG_v1_0.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_PRNG_IP_0_1/sim/kyber_soc_PRNG_IP_0_1.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/NTT_Poly_BRAM/sim/NTT_Poly_BRAM.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/Zeta/sim/Zeta.v" \
-endlib
-makelib xcelium_lib/xbip_utils_v3_0_10 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_utils_v2_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/axi_utils_v2_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_pipe_v3_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_wrapper_v3_0_4 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_addsub_v3_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_bram18k_v3_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/mult_gen_v12_0_15 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/mult_gen_v12_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/floating_point_v7_0_16 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/floating_point_v7_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_mult_v3_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_dsp48_mult_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xbip_dsp48_multadd_v3_0_6 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/div_gen_v5_1_15 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/hdl/div_gen_v5_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/MOD_Q_Div/sim/MOD_Q_Div.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L96_NTT_Poly_0/sim/L96_NTT_Poly_0.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L128_AtG/sim/L128_AtG.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L128_EncPk_DecSk_PolyVec/sim/L128_EncPk_DecSk_PolyVec.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/State_Pack_Cit_Div/sim/State_Pack_Cit_Div.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L96_Reduce_DecMp/sim/L96_Reduce_DecMp.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L128_INTT_Enc_BpV_DecMp/sim/L128_INTT_Enc_BpV_DecMp.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L12_k/sim/L12_k.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L96_Reduce_EncV/sim/L96_Reduce_EncV.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L96_Reduce_EncBp/sim/L96_Reduce_EncBp.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L32_noise_eG/sim/L32_noise_eG.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/L32_noise_r_PolyVec/sim/L32_noise_r_PolyVec.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/SS_OUT_MEM/sim/SS_OUT_MEM.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/CT_OUT_MEM/sim/CT_OUT_MEM.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/PK_SK_MEM/sim/PK_SK_MEM.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/src/Rand_CT_MEM/sim/Rand_CT_MEM.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/BRAM_MUX.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_CCAKEM_Masked.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/hdl/Kyber512_CCAKEM_Masked_IP_v1_0_S00_AXI.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/hdl/Kyber512_CCAKEM_Masked_IP_v1_0_S01_AXI.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_INDCPA.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_indcpa_DEC.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_indcpa_ENC.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_indcpa_shared.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Kyber512_pre_post_INDCPA.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Montgomery_Reduce.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/NTT.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Poly_Decompress.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Poly_Decompress__r.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Poly_Decompress__t.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Polyvec_Decompress.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Polyvec_Decompress__r.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/Polyvec_Decompress__t.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Add__Add_3.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Add__Poly_Add__Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Decompressed_Ciphertext.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Hash.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Hash__CBD.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Hash__Permutation.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Hash__Rej_Uniform.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Hash__Rej_Uniform_Comparer.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_InvNTT__INTT.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Invntt.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Invntt__BarrettR_MontgomeryR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Invntt__MontegomeryR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_NTT_PolyReduce.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_NTT_PolyReduce_BarrettR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Add__Data_Cal.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Basemul.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Basemul__Basemul.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Basemul__Basemul__MontgomeryR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Reduce.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_PAcc__State_PolyVec_PAcc__Poly_Reduce__BarrettR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_PolyVec_Group.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_PolyVec__Mask_Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_PolyVec__Shift.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_Poly_Group.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_Poly__Mask_Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Pack_Cit__Pack_Poly__Shift.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Poly_Sub.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Poly_Sub___Data_Cal.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Poly_Sub___Negate.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Poly_frommsg.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Polytomsg.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Polytomsg__DataCal.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Polytomsg__DataCal__Add.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Polytomsg__DataCal__Csubq.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Reduce.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Reduce__PolyReduce.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Reduce____BarrettR.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Unpack.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Unpack__mask.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Unpack__poly_frombytes.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_Unpack__poly_frombytes__r.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_ntt.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/State_ntt_BRAM_MUX.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/f_permutation.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/rconst2in1.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/src/round2in1.v" \
  "../../../bd/kyber_soc/ipshared/4ea4/hdl/Kyber512_CCAKEM_Masked_IP_v1_0.v" \
  "../../../bd/kyber_soc/ip/kyber_soc_Kyber512_CCAKEM_Mask_0_0/sim/kyber_soc_Kyber512_CCAKEM_Mask_0_0.v" \
-endlib
-makelib xcelium_lib/axi_protocol_converter_v2_1_19 \
  "../../../../Kyber512_CCAKEM_Masked.srcs/sources_1/bd/kyber_soc/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/kyber_soc/ip/kyber_soc_auto_pc_0/sim/kyber_soc_auto_pc_0.v" \
  "../../../bd/kyber_soc/sim/kyber_soc.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

