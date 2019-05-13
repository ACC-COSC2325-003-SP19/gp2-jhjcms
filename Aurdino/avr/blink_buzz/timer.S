; timer.S - Timer1 code for interrupt blink-buzz

#include "config.h"

        .global Timer0Setup
        .global TIMER0_OVF_vect
        .global trigger

.equ    MAX_COUNT,  1                 ; counts per trigger

        .section    .data

trigger:
        .byte   0                       ; set to 1 to fire off tasks
ISRcount:
        .byte   0                       ; interrupts before trigger

        .section    .text

;----------------------------------------------------------------------
; Initialize Timer 0 for interrupts
;
Timer0Setup:
        in      r16, _(TCCR0B)
        andi    r16, 0xf8           ; clear control bits
        ori     r16, (1 << CS01)    ; divide by 8 = 7812Hz
        out     _(TCCR0B), r16      ; set timer clock
        sbi     _(TIFR0), (1<< TOV0); clear interrupt flag
;
        lds     r16, TIMSK0         ; get interrupt mask reg
        ori     r16, (1 << TOIE0)   ; enable interrupts
        sts     TIMSK0, r16
        out     _(TCNT0), r1        ; zero the timer counter
        sts     ISRcount, r1        ; zero the Interrupt counter
        ;
        sei                         ; let the fun begin
        ret
