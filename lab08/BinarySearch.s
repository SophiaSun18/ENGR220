/*
* Engr220L - Lab 8
* Date: Oct 19, 2022
* Author: ZeAi Sun
*
* This assembly code defines the BinarySearch() function 
* as explained below.  It is intended for use in Engr220L-#8
* with the associated Lab 8 main.c file.  
* 
*/

/*
    C-STYLE DECLARATION:
    int BinarySearch(int* arrayToSearchIn, int valueBeingSearchedFor, 
                     unsigned int startIndex, unsigned int endIndex);
    
    REGISTERS:
	r2: the return value, either the index or -1
	r4: arrayToSearchIn
	r5: valueBeingSearchedFor
	r6: startIndex
	r7: endIndex
	r16: midIndex
	r17: midValue
    
    CASES:
	Case 1: midValue == valueBeingSearchedFor, found, return midIndex
	Case 2: startIndex == endIndex, not found, return -1
	Case 3: valueBeingSearchedFor < midValue, search in the left-half, endIndex = midIndex - 1
	Case 4: valueBeingSearchedFor > midValue, search in the right-half, startIndex = midIndex + 1
*/

.global BinarySearch
BinarySearch:

/*****************/
/* push to stack */
	
	/* push the value of r6, r7, r8, r9, r10, r16, r17 and ra to the stack. */
	addi sp, sp, -32
	stw r6, 28(sp)
	stw r7, 24(sp)
	stw r8, 20(sp)
	stw r9, 16(sp)
	stw r10, 12(sp)
	stw r16, 8(sp)
	stw r17, 4(sp)
	stw ra, 0(sp)

/*****************************/
/* calculate local variables */

	/* calculate the value of midIndex and store it in r16. */
	sub r8, r7, r6   /* r8: store the result of endIndex - startIndex. */
	srli r8, r8, 1
	add r16, r8, r6
	
	/* calculate the value of midValue and store it in r17. */
	muli r9, r16, 4  /* r9: store the offset. */
	add r10, r4, r9 
	ldw r17, 0(r10)

/***************/
/* check cases */

	/* check if (midValue == valueBeingSearchedFor) */
	CHECK_CASE_A:
		bne r17, r5, CASE_DONE_A
	EXECUTE_CASE_A:
		mov r2, r16
		br END
	CASE_DONE_A:
		/* nothing needs to be done. */
	
	/* check if (startIndex == endIndex) */
	CHECK_CASE_B:
		bne r6, r7, CASE_DONE_B
	EXECUTE_CASE_B:
		movi r2, -1
		br END
	CASE_DONE_B:
	/* nothing needs to be done. */
	
	/* check if (midValue > valueBeingSearchedFor) */
	CHECK_CASE_C:
		ble r17, r5, CASE_DONE_C
	EXECUTE_CASE_C:
		subi r7, r16, 1
		call BinarySearch
		br END
	CASE_DONE_C:
	/* nothing needs to be done. */
	
	/* check if (midValue < valueBeingSearchedFor) */
	CHECK_CASE_D:
		bge r17, r5, CASE_DONE_D
	EXECUTE_CASE_D:
		addi r6, r16, 1
		call BinarySearch
		br END
	CASE_DONE_D:
		/* nothing needs to be done. */

/******************/
/* pop from stack */

	END:
		/* pop the value of r6, r7, r8, r9, r10, r16, r17 and ra from the stack. */
		ldw r6, 28(sp)
		ldw r7, 24(sp)
		ldw r8, 20(sp)
		ldw r9, 16(sp)
		ldw r10, 12(sp)
		ldw r16, 8(sp)
		ldw r17, 4(sp)
		ldw ra, 0(sp)
		addi sp, sp, 32

ret

