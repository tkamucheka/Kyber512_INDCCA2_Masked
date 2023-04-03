/*
 * main.cc
 *
 *  Created on: Sep 27, 2020
 *      Author: Tendayi Kamucheka
 */

#include "simple_serial_kyber512.h"

int main(void)
{
	platform_init();

	simpleserial_init();
	simpleserial_addcmd('x', 0, device_reset);
	simpleserial_addcmd('e', 0, device_enable);
	simpleserial_addcmd('m', 1, set_mode);
	simpleserial_addcmd('r', KYBER_RAND_BYTES, set_rand_bytes_ciphertext);
	simpleserial_addcmd('k', KYBER_PUBLIC_KEY_BYTES, set_public_key_secret_key);
	simpleserial_addcmd('c', KYBER_CIPHERTEXT_BYTES, set_rand_bytes_ciphertext);
	simpleserial_addcmd('s', KYBER_SECRET_KEY_BYTES, set_public_key_secret_key);
	simpleserial_addcmd('t', KYBER_CIPHERTEXT_BYTES, get_ciphertext);
	simpleserial_addcmd('a', KYBER_SHAREDSECRET_BYTES, get_shared_secret);

	while (1)
	{
	  simpleserial_get();
	}

	return XST_SUCCESS;
}
