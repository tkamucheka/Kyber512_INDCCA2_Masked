#ifndef SIMPLESERIAL_H
#define SIMPLESERIAL_H

#include "xil_types.h"
#include "xparameters.h"

#include "xuartlite.h"
#include "xuartlite_l.h"

u8 check_version(u8 *v);
void simpleserial_init();
int simpleserial_addcmd(char c, unsigned int len, u8 (*fp)(u32 len));
void simpleserial_get(void);
void simpleserial_put(char c, int size, u8 *output);

#endif // !__SIMPLESERIAL_H
