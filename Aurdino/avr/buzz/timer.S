#include "config.h"

	.section	.text
	.global		timer_delay

timer_delay:
	out	_(TCNT0), r1	; zero counter
	ldi	r24, 0x3c	; set compare value
	out	_(OCR0A), r24
	ldi	r24, (1 << WGM01)	; CTC max trigger
	out	_(TCCR0A), r24
	ldi	r24, (1 << CS02) | (1 << CS00)	; clk/1024
	out	_(TCCR0B), r24
1:	sbis	_(TIFR0), 1 ; (1 << TOV0) ; check interrupt flag
	rjmp	1b
	out	_(TCCR0B), r1
	ldi	r24, (1 << OCF0A)
	out	_(TIFR0), r24
	ret
