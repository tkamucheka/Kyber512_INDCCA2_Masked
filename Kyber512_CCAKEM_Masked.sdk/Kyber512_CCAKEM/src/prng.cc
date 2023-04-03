#include "prng.h"

static XUartLite UartLite; /* Instance of the UartLite Device */

// Control register
// volatile u32 *PRNGControlRegister = (u32 *)(XPAR_PRNG_IP_0_S00_AXI_BASEADDR);

// Data register
