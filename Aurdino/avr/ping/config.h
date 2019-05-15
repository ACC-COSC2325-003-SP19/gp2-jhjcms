#include <avr/io.h>

#define PING_PIN     7
#define PING_PORT    _(PORTD)
#define PING_DIR     _(DDRD)
#define PING_READ    _(PIND)

// include this line to avoid SFR_REG issues
#define _(s)    _SFR_IO_ADDR(s)

