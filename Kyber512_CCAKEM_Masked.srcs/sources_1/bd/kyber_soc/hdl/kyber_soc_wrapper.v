//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Thu Feb 23 13:18:01 2023
//Host        : 444-xps-00 running 64-bit major release  (build 9200)
//Command     : generate_target kyber_soc_wrapper.bd
//Design      : kyber_soc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module kyber_soc_wrapper
   (USER_SMA_GPIO_P,
    XADC_GPIO_2,
    XADC_GPIO_3,
    reset,
    rs232_uart_rxd,
    rs232_uart_txd,
    sys_diff_clock_clk_n,
    sys_diff_clock_clk_p);
  output USER_SMA_GPIO_P;
  output XADC_GPIO_2;
  output XADC_GPIO_3;
  input reset;
  input rs232_uart_rxd;
  output rs232_uart_txd;
  input sys_diff_clock_clk_n;
  input sys_diff_clock_clk_p;

  wire USER_SMA_GPIO_P;
  wire XADC_GPIO_2;
  wire XADC_GPIO_3;
  wire reset;
  wire rs232_uart_rxd;
  wire rs232_uart_txd;
  wire sys_diff_clock_clk_n;
  wire sys_diff_clock_clk_p;

  kyber_soc kyber_soc_i
       (.USER_SMA_GPIO_P(USER_SMA_GPIO_P),
        .XADC_GPIO_2(XADC_GPIO_2),
        .XADC_GPIO_3(XADC_GPIO_3),
        .reset(reset),
        .rs232_uart_rxd(rs232_uart_rxd),
        .rs232_uart_txd(rs232_uart_txd),
        .sys_diff_clock_clk_n(sys_diff_clock_clk_n),
        .sys_diff_clock_clk_p(sys_diff_clock_clk_p));
endmodule
