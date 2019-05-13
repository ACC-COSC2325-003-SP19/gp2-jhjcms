#include "config.h"

extern	void timer_delay();

#define BUZZ_ON          (BUZZ_PORT |= (1<<BUZZ_PIN))
#define BUZZ_OFF         (BUZZ_PORT &= ~(1<<BUZZ_PIN))

void setup() {
  BUZZ_DIR |= (1 << BUZZ_PIN);
  PORTB = 0;
}

void loop() {
  BUZZ_ON;
  timer_delay();
  BUZZ_OFF;
  timer_delay();
}

int main(void) {
    setup();
    while(1) {
        loop();
    }
}
