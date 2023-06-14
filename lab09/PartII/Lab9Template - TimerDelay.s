/*
* Engr220L - Lab 9
* Date: Oct 26, 2022
* Author: ZeAi Sun
*
* <TODO describe the program summary>
*/

/************/
/* INCLUDES */
/************/
.include "nios_macros.s"
.include "nios_defs.s"   /* .equ statements specific to this system */

/*************/
/* CONSTANTS */
/*************/
.equ MS100,     5000000    /* number of clock cycles in 100 msec provided as example */
.equ MS100LOW,  0x4b40     /* 16 least signif bits */
.equ MS100HIGH, 0x4c       /* 16 most signif bits */

/****************/
/* TEXT SECTION */
/****************/
.text
/* Place the main routine at the reset address */
.org RESET_VECTOR 

/* Program start location must be identified */
.global _start
_start:

/*********************/
/* MAIN PROGRAM CODE */
/*********************/

MAIN_PROG_INIT:

	/* Initialize the value of i. */
	movia r6, LEDR_BASE
	movi r7, 0
	movi r8, 0x40000
	stwio r7, 0(r6)
	
	/* Initialize the timer. */
	movia r9, TIMER_BASE
	
	movia r10, 0x7840  # Store the value in the PeriodL register.
	stwio r10, PERIODL_OFFSET(r9)
	movia r11, 0x17D   # Store the value in the PeriodH register.
	stwio r11, PERIODH_OFFSET(r9)
	
	movia r12, 0b10    # Store the value in the Status register.
	stwio r12, STATUS_OFFSET(r9)
	movia r13, 0b0110  # Store the value in the Control register.
	stwio r13, CONTROL_OFFSET(r9)
	
	movia r14, 0b01    # Store the AND-MASK and the ideal Status value.
	movia r15, 0b00

MAIN_PROG:
	
	/* Set up the while loop and increment the value of i each time the loop runs. */
	LOOP_START:	
		bge r7, r8, MAIN_PROG_END
		addi r7, r7, 1
		stwio r7, 0(r6)
		
		/* Set up the while loop and check if the timer has reached the TO. */
		TIMER_LOOP_START:
			ldwio r16, STATUS_OFFSET(r9)   # Load the current status value into r16.
			and r17, r16, r14  			   # Use bit masking to mask the run bit and store the result in r17.
			beq r14, r17, TIMER_LOOP_END   # Check if the TO bit is equal to 1.
			br TIMER_LOOP_START
			
		TIMER_LOOP_END:
			stwio r15, STATUS_OFFSET(r9)   # Clear the TO bit.

		br LOOP_START

MAIN_PROG_END:
    /* infinite loop to keep out of global memory, useful for final breakpoint */
    br MAIN_PROG_END

/****************/
/* DATA SECTION */
/****************/
.data

/* if any global variables are needed, place them here */

.end
