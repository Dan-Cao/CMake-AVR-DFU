/*
 *  Copyright (c) 2014 Álan Crístoffer
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

#include <avr/io.h>
#include <util/delay.h>

#include "utils.h"

#define LED      PD7
#define LED_DDR  DDRD
#define LED_PORT PORTD

#define BTN      PB1   // pin number
#define BTN_DDR  DDRB  // data direction
#define BTN_PORT PORTB // for OUTPUT write
#define BTN_PIN  PINB  // for INPUT read

#define DELAYTIME 1000

int main(void)
{
    DDRD  = 0xFF; // all ports on D to OUTPUT
    DDRB  = 0xFF; // all ports on B to OUTPUT
    PORTD = 0x0;  // all ports on D to LOW
    PORTB = 0x0;  // all ports on B to LOW

    CBIT(BTN_DDR, BTN);  // set BTN port to INPUT
    SBIT(BTN_PORT, BTN); // activate pull-up resistor on BTN

    while ( true ) {
        if ( RBIT(BTN_PIN, BTN) == 1 ) {
            SBIT(LED_PORT, LED); // OUTPUT to HIGH
            _delay_ms(DELAYTIME);

            CBIT(LED_PORT, LED); // OUTPUT to LOW
            _delay_ms(DELAYTIME);
        } else {
            PORTD = 0x0;
        }
    }
}
