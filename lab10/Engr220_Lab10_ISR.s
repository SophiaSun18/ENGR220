/*
* Engr220L - Lab 10
* Date: Nov 9, 2022
* Author: ZeAi Sun
*
* The lab 10 program.
* 
*/

/************/
/* INCLUDES */
/************/
.include "nios_macros.s"
.include "nios_defsISR.s" /* system specific definitions */

/*************/
/* CONSTANTS */
/*************/
.equ MEM_END_ADDR, 0x8000

/****************/
/* TEXT SECTION */
/****************/
.text
/* Place the main routine at the reset address */
.org RESET_VECTOR

/* Program start location must be identified */
.global _start
_start:

/* jump over the ISR code in order to begin execution at MAIN_PROG_INIT */
br MAIN_PROG_INIT

/************/
/* ISR CODE */
/************/
/* ISR = Interrupt Service Routine */

/* The following happens when an external interrupt occurs:  The cpu:
   1. Copies the contents of the status register (ctl0) to estatus
      (ctl1) saving the processor’s pre-exception status
   2. Clears the U bit of the status register, forcing the processor 
      into supervisor mode
   3. Clears the PIE bit of the status register, disabling external
      processor interrupts
   4. Writes the address of the instruction after the exception to 
      the ea register (r29)
   5. Transfers execution to the address of the exception handler that
      determines the cause of the interrupt
*/
.org EXCEPTION_VECTOR
ISR:
    /* these three lines of code should not be changed */
    rdctl et, ctl4 /* Check if an external (hardware) intr has occurred */
    beq et, r0, EXCEPTION_ACTION 
    subi ea, ea, 4 /* If yes, decrement ea to re-execute interrupted  
                      instruction when you return from the ISR */

EXCEPTION_ACTION:
/* The interrupt-service/exception-handler routine: After determining
   the source of the interrupt, the interrupt condition must be cleared.
   Note that if any register besides r0, et, ea, and sp are used, they must
   first be pushed on the stack and then pulled off the stack before
   returning from the interrupt (eret). */

	addi sp, sp, -36              # Push registers onto the stack.
	stw r6, 32(sp)
	stw r11, 28(sp)
	stw r12, 24(sp)
	stw r13, 20(sp)
	stw r14, 16(sp)
	stw r15, 12(sp)
	stw r16, 8(sp)
	stw r17, 4(sp)
	stw r18, 0(sp)
   
CHECK_FOR_INTR_0:
	rdctl et, ctl4 		 		  # Read the IPENDING register ctl4.
	andi et, et, TIMER_MASK       # Mask other bits except the bit 0.
	beq r0, et, CHECK_FOR_INTR_1  # If bit 0 is 0, check for the next interrupt.

RESPOND_TO_INTR_0:
	stwio r0, STATUS_OFFSET(r6)   # Clear the TO flag.
	movia r11, ledDisplayValue    # Store the global count value in r11.
	ldw r12, 0(r11)   			  # Load the global count value into r12.
	addi r12, r12, 1			  # Increment the value of r13.
	
	movia r13, 0x40000            # Store the max value 0x40000 in r14.
	beq r12, r13, GLOBAL_RESET    # Check if the global count value needs to be reset.
	br NEXT_STEP				  # If not, branch to the next step.
	
	GLOBAL_RESET:             	  # If the global count >= 0x40000, reset to 0.
		movia r12, 0
	NEXT_STEP:
		stw r12, 0(r11)   		  # Store the value on r13 back into the global count value.
	
	movia r14, LEDR_BASE          # Display the global count value on the LEDs.
	stwio r12, 0(r14)

CHECK_FOR_INTR_1:
	rdctl et, ctl4 		 		  # Read the IPENDING register ctl4.
	andi et, et, KEY_MASK         # Mask other bits except the bit 1.
	beq r0, et, END_ISR           # If bit 1 is 0, jump to the end of ISR.

RESPOND_TO_INTR_1:
/* TODO: The interrupt 1 action goes here, this should only execute if check-1==yes */
	movia r15, KEY_BASE
	stwio r0, EDGE_OFFSET(r15)    # Clear the EDGE register.
	movia r15, SW_BASE
	ldwio r16, DATA_OFFSET(r15)   # Load the SW data into r16.
	movia r17, TIMER_BASE
	stwio r16, PERIODH_OFFSET(r17)# Store the SW data into PERIODH register.
	stwio r0, STATUS_OFFSET(r17)  # Clear the STATUS register.
	movia r18, 0b0111             
	stwio r18, CONTROL_OFFSET(r17)# Store the value in the Control register.

CHECK_FOR_INTR_2:
/* TODO: check if intr 2 needs service by checking bit 2 of ipending (ctl4). */
/* TODO: this should execute every time the ISR is called, even if another check-#==yes */

RESPOND_TO_INTR_2:
/* TODO: The interrupt 2 action goes here, this should only execute if check-2==yes */

/* The cpu does the following when you return from the interrupt:  
   1. Copies contents of estatus (ctl1) to status (ctl0) (restores it).
   2. Transfers program execution to the address in ea register (r29)
      by copying what is in ea to the program counter (pc).
   NOTE: If you pushed any registers on the stack, pop them off now. */
END_ISR:
    eret /* Return from exception */
	ldw r6, 32(sp)                # Pop registers out from the stack.
	ldw r11, 28(sp)
	ldw r12, 24(sp)
	ldw r13, 20(sp)
	ldw r14, 16(sp)
	ldw r15, 12(sp)
	ldw r16, 8(sp)
	ldw r17, 4(sp)
	ldw r18, 0(sp)
	addi sp, sp, 36
	
/****************/
/* END ISR CODE */
/****************/

/*********************/
/* MAIN PROGRAM CODE */
/*********************/

MAIN_PROG_INIT:

	# br MAIN_PROG_INIT  # An infinite loop that does nothing.

    SP_INIT:
	movia sp, MEM_END_ADDR

    GLOBAL_VARIABLES_INIT:
	movia r15, ledDisplayValue
    stw r0, 0(r15)

    IO_BASE_INIT:
    /* TODO: setup registers with I/O base addresses if needed */

    IO_DEVICE_INIT:
    /* TODO: initialize PIO devices if needed */

    TIMER_INIT:
    movia r6, TIMER_BASE
	movia r7, 0x7840   # Store the value in the PeriodL register.
	stwio r7, PERIODL_OFFSET(r6)
	movia r8, 0x17D    # Store the value in the PeriodH register.
	stwio r8, PERIODH_OFFSET(r6)

    SET_PORT_INTR:
	movia r9, 0b10     # Store the value in the Status register.
	stwio r9, STATUS_OFFSET(r6)
	movia r10, 0b0111  # Store the value in the Control register.
	stwio r10, CONTROL_OFFSET(r6)
	
	movia r11, KEY_BASE
	stwio r0, EDGE_OFFSET(r11)    # Clear the EDGE register.
	movia r12, 0b0100             # Set the value of MASK register so that KEY2 can cause interrupt.
	stwio r12, MASK_OFFSET(r11)

    SET_IENABLE:
        /* Set the IENABLE for control register 3 */
        rdctl et, ctl3 /* Read the interrupt enable register = ctrl_reg3 */
        ori et, et, TIMER_MASK  /* set the timer interrupt enable bit high */
		ori et, et, KEY_MASK    # Set the key interrupt enable bit high.
        wrctl ctl3, et  /* write the final pattern back to IENABLE (ctl3) */

    SET_STATUS:
        /* Now enable interrupts globally in the processor status register. */
        rdctl et, ctl0 /* Read the status register = ctrl_reg0 */
        ori et, et, PIE_MASK  /* set the PIE bit to enable all interrupts */
        wrctl ctl0, et  /* write the pattern back to STATUS (ctl0) */

/* End MAIN_PROG_INIT */
/*********************/

MAIN_PROG:
/* TODO  write main program functionality as needed here */

MAIN_PROG_END:
    /* infinite loop to keep out of global memory, useful for final breakpoint */
    br MAIN_PROG_END  

/*************************/
/* END MAIN PROGRAM CODE */
/*************************/

/****************/
/* DATA SECTION */
/****************/
.data
/* TODO: if needed, add .word or .skip declarations here for global variables */

ledDisplayValue:     /* Renamed global variable */
    .word 0      	 /* allocate 4 bytes and initialize them to 0 */

.end


