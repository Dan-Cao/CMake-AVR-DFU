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

/*
 * http://www.nongnu.org/avr-libc/user-manual/group__avr__sfr__notes.html
 * _SFR_IO_ADDR gets the IO addr of a constant
 * _SFR_MEM_ADDR get the memory address of a constant
*/

.global main

.extern delay ; defined in delay_wrapper.c

#define HIGH(x) x >> 8
#define LOW(x)  x & 0xFF

main:
    ldi r16, 0xFF
    out _SFR_IO_ADDR(DDRB), r16  ; Set all pins on port B to OUTPUT
    out _SFR_IO_ADDR(DDRD), r16  ; Set all pins on port D to OUTPUT
    
    ldi r16, 0x0
    out _SFR_IO_ADDR(PORTB), r16 ; Set all pins on port B to LOW
    out _SFR_IO_ADDR(PORTD), r16 ; Set all pins on port D to LOW
    
    cbi _SFR_IO_ADDR(DDRB),  PB1 ; Set PB1 to INPUT
    sbi _SFR_IO_ADDR(PORTB), PB1 ; Activate pull-up resistor on PB1
    
loop:
    sbic _SFR_IO_ADDR(PINB), PB1 ; If PB1 is LOW, skip next line
    rjmp blink                   ; jump to blink
    
    cbi _SFR_IO_ADDR(PORTD), PD7 ; Set PD7 to LOW
    rjmp loop                    ; jump to loop

blink:
    sbi _SFR_IO_ADDR(PORTD), PD7 ; Set PD7 to HIGH
    
    ldi r24, LOW(1000)           ; Write 1000 to the registers r24 and r25, reversed
    ldi r25, HIGH(1000)
    rcall delay                  ; call delay (C function)
    
    cbi _SFR_IO_ADDR(PORTD), PD7 ; Set PD7 to LOW
    
    ldi r24, LOW(1000)           ; Write 1000 to the registers r24 and r25, reversed
    ldi r25, HIGH(1000)
    rcall delay                  ; call delay (C function)
    
    rjmp loop                    ; jump to loop