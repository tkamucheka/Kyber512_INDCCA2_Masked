#include "utilities.h"

static XUartLite UartLite; /* Instance of the UartLite Device */

u8 hex_decode(u8 byte)
{
  // transform u8 input into 4-bit equivalent hex
  if (byte >= '0' && byte <= '9')
    byte = byte - '0';
  else if (byte >= 'a' && byte <= 'f')
    byte = byte - 'a' + 10;
  else if (byte >= 'A' && byte <= 'F')
    byte = byte - 'A' + 10;

  return (byte & 0xF);
}

// Write packets from UART to KYBER512 IP Core BRAMs
u8 uart_to_bram(volatile u32 *input_reg, volatile u32 *memaddr_reg, int len)
{
  int receivedCount = 0;
  u32 buffer = 0;
  u32 memaddr = 0;
  u8 RecvBuffer = 0x00;

  // Wait for UART to finish sending before proceeding
  while (XUartLite_IsSending(&UartLite) == 1)
  {
  }
  XUartLite_ResetFifos(&UartLite);

  // Anticipate control program will send data
  // Stop receiving when appropriate number of bytes is received
  // from the control program
  while (1)
  {
    if (!XUartLite_IsReceiveEmpty(UART_BASEADDR))
    {
      // Receive byte from UART
      receivedCount += XUartLite_Recv(&UartLite,
                                      &RecvBuffer,
                                      len - receivedCount);

      // Pack received data into 32-bit buffer
      buffer = (buffer << 4) | hex_decode(RecvBuffer); // "a" => A

      // Detect early termination and quit immediate
      if (RecvBuffer == '\n')
        return XST_FAILURE;

      // Write to register after every 4 bytes
      if (receivedCount % 8 == 0)
      {
        // Write packet to bram
        *input_reg = buffer;
        *memaddr_reg = memaddr++;

        // DEBUG:
        // Ebyteo received packet
        xil_printf("%08x", *input_reg);
      }

      if (receivedCount == len)
        break;
    }
  }

  // Assert termination bytearacter sequence and quit
  if (XUartLite_Recv(&UartLite, &RecvBuffer, 1) && RecvBuffer == '\n')
    return XST_SUCCESS;
  else
    return XST_FAILURE;
}

// Read packets from KYBER512 IP Core to UART
u8 bram_to_uart(volatile u32 *output_reg, volatile u32 *memaddr_reg, int len)
{
  // Wait for UART to finish sending before proceeding
  while (XUartLite_IsSending(&UartLite) == 1)
  {
  }
  XUartLite_ResetFifos(&UartLite);

  // Read mem and transmit on UART
  for (int i = 0; i < (len >> 2);)
  {
    // Wait until transmit buffer is not full
    if (!XUartLite_IsTransmitFull(UART_BASEADDR))
    {
      // Write packet data over UART
      *memaddr_reg = i++;
      xil_printf("%08x", *output_reg);
    }
  }

  // Send termination bytearacter sequence and quit
  xil_printf("\n");
  return XST_SUCCESS;
}