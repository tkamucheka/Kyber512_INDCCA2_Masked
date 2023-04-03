#include "xil_types.h"

#include "simple_serial.h"

typedef struct ss_cmd
{
  u8 c;
  u32 len;
  u8 (*fp)(u32 len);
} ss_cmd;

#define MAX_SS_CMDS 20
static ss_cmd commands[MAX_SS_CMDS];
static int num_commands = 0;

//static XUartLite UartLite; /* Instance of the UartLite Device */

// Callback function for "v" command.
// This can exist in v1.0 as long as we don't actually send back an ack ("z")
u8 check_version(u32 _)
{
  return 0x01;
}

void simpleserial_init()
{
  u8 status[1];
  simpleserial_addcmd('v', 0, check_version);

  status[0] = 1;
  simpleserial_put('z', 1, status);
}

int simpleserial_addcmd(char c, unsigned int len, u8 (*fp)(u32 len))
{
  if (num_commands >= MAX_SS_CMDS)
    return 1;

  commands[num_commands].c = c;
  commands[num_commands].len = len;
  commands[num_commands].fp = fp;
  num_commands++;

  return 0;
}

void simpleserial_get(void)
{
  u8 status = 0;
  u8 RecvBuffer;
  short readBytes = 1;
  short recvCount = 0;

  if (!XUartLite_IsReceiveEmpty(XPAR_AXI_UARTLITE_0_BASEADDR))
  {

    // Receive byte from UART
//		  status  = XUartLite_Recv(&UartLite, &RecvBuffer, 0);
//		  while(1) {
//			  recvCount += XUartLite_Recv(&UartLite, &RecvBuffer, readBytes - recvCount);
//		  	  if (recvCount == readBytes) break;
//		  }
    RecvBuffer = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);

    // If nothing received from UART buffer return early
	//    if (status == 0)
	//      return;

    // DEBUG:
    // xil_printf("Received: %c", RecvBuffer);

    // Find which command we're receiving
    int cmd;
    for (cmd = 0; cmd < num_commands; cmd++)
      if (commands[cmd].c == RecvBuffer)
        break;

    // If we didn't find a match, give up right away
    if (cmd == num_commands)
      return;

    // Callback
    u8 ret[1];
    ret[0] = commands[cmd].fp(commands[cmd].len);

    // Send ACK
    simpleserial_put('z', 1, ret);
  }
}

void simpleserial_put(char c, int size, u8 *output)
{
  // Write first character
  xil_printf("%c", c);

  // Write each byte as two nibbles
  for (int i = 0; i < size; i++)
    xil_printf("%02x", output[i]);

  // Write trailing '\n'
  xil_printf("\n");
}
