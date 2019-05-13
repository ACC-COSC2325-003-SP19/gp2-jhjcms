#include "config.h"
    .global      delay
    .section    .text
delay:
        ldi      r26, 41
        ldi      r27, 150
        ldi      r28, 128

1:      dec      r28
        brne     1b
        dec      r27
        brne     1b
        dec      r26
        brne     1b
        ret   
        

        

