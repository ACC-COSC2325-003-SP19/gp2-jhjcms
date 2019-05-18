#include "config.h"
    .global      delay
    .section    .text
delay:
	ldi	r18, 80
  ldi r17, 0
1:	
	dec	r16
	cp 	r16, r17
	brne 1b
  ret
