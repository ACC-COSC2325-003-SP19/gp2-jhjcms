#include <avr/io.h>

#define BUZZ_PIN    4
#define BUZZ_DIR    DDRB
#define BUZZ_PORT   PORTB

#define _(s)    _SFR_IO_ADDR(s)
