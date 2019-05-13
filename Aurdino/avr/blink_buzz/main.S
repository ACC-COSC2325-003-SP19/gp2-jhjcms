; main.S - avr-gcc assembly language

#include "config.h"

        .extern Timer0Setup
        .extern trigger

        .extern buzz_task
        .extern buzz_init
        .extern led_task
        .extern led_init
        ; .extern pulse_task
        ; .extern pulse_init

        .section    .text
        .global main

main: 
        ; set up the system clock
        ldi     r24, 0x80               ; set up prescaler
        sts     CLKPR, r24
        sts     CLKPR, r1               ; set to full speed
