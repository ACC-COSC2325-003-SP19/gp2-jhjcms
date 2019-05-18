; Ping for AVR
; Author: Group jhjcms

#include "config.h"

	.section .data
dummy: 	.byte 0		; dummy global variable

        .section .text
        .global     main
;        .extern     delay          
        .org        0x0000

main:
	; clear the SREG register
        eor     r1, r1                  ; cheap zero
        out     _(SREG), r1                ; clear flag register


        ; set up the stack
        ldi         r28, (RAMEND & 0x00ff)
        ldi         r29, (RAMEND >> 8)
        out         _(SPH), r29
        out         _(SPL), r28

	; initialize the CPU clock to run at full speed
	ldi         r24, 0x80
        sts         CLKPR, r24              ; allow access to clock setup
        sts         CLKPR, r1               ; run at full speed
        
	; set up the LED port
	sbi         LED_DIR, LED_PIN        ; set LED pin to output
        cbi         LED_PORT, LED_PIN       ; start with the LED off

        ; set up the PING port
        sbi         PING_DIR, PING_PIN        ; set PING pin to output
        cbi         PING_PORT, PING_PIN       ; start with the PING off


        ; enter the blink loop
1:    	; call       toggle
	rcall       delTwoMs
	rcall       togglePing
	rcall	    delayFiveMs
	rcall	    togglePing
	sbi         PING_READ, PING_PIN
	
	ldi	    r19, 50
;	ldi         r20, 93
	rcall	    2f

	; checks if pulse got back before timer expired, if expired skip 
	; turning on led
	cpse        r19, 0
	rcall       toggleLed	

	; make code to calc distance
;	call 	    print ; will be c++ function
	; 

	rcall	    togglePing
	rcall       toggleLed
        rjmp        1b

	; checking for sound to come back
2:      ; decrements first reg, gets PING_PORT and returns if gets pulse
	; back or timer reaches 0
	dec	    r19
	ldi         r20, 93
	in          r24, PING_PORT
	cpse	    r24, 0 ; checks if r24 has ping toggle, if not it skips ret
	ret
	cp          r19, 1
	brsh        3f
	ret

3:
	dec         r20
	cp          r20, 0
	breq        2b
	jmp         3b
	

togglePing:
        in          r24, PING_PORT           ; get current bits
        ldi         r25, (1 << PING_PIN)     ; PING is pin 7
        eor         r24, r25                 ; flip the bit
        out         PING_PORT, r24           ; write the bits back
        ret

toggleLed:
        in          r26, LED_PORT           ; get current bits
        ldi         r27, (1 << LED_PIN)     ; LED is pin 5
        eor         r26, r27                ; flip the bit
        out         LED_PORT, r26           ; write the bits back
        ret

; delays machine for 5 microseconds
delayFiveMs:
	ldi         r18, 80
  	ldi	    r17, 0

loopForFiveOne:	
	dec         r16
	cp          r16, r17
	brne        1b
        ret

; delays machine for 2 microseconds
delTwoMs:
	ldi         r16, 32
 	ldi         r17, 0

loopForTwoOne:	
	dec         r16
	cp          r16, r17
	brne        1b
	ret
