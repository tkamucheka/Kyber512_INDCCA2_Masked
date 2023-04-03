#include "xuartlite.h"
#include "xuartlite_l.h"

// UARTLITE device id & base address
#define UARTLITE_DEVICE_ID XPAR_UARTLITE_0_DEVICE_ID
#define UART_BASEADDR XPAR_AXI_UARTLITE_0_BASEADDR

// Utilities
u8 hex_decode(u8 byte);
u8 uart_to_bram(volatile u32 *input_reg, volatile u32 *memaddr_reg, int len);
u8 bram_to_uart(volatile u32 *output_reg, volatile u32 *memaddr_reg, int len, int offset);