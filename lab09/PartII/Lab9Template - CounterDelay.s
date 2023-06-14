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
  
/* TODO: initialize PIO devices if needed */

/* TODO: initialize the timer with the proper timeout period */

MAIN_PROG: 
	
	/* Initialize the value of i. */
	movia r6, LEDR_BASE
	movi r7, 0
	movi r8, 0x40000
	movi r9, 0x500000
	stwio r7, 0(r6)
	
	/* Set up the while loop and increment the value of i each time the loop runs. */
	LOOP_START:
		movi r10, 0
		
		bge r7, r8, MAIN_PROG_END
		addi r7, r7, 1
		stwio r7, 0(r6)
		
		INNER_LOOP_START:
			bge r10, r9, INNER_LOOP_END
			addi r10, r10, 1
			br INNER_LOOP_START
		
		INNER_LOOP_END:
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
