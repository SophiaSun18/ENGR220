/*
* Engr220L - Lab 7 Prelab
* Date: <Oct 11, 2022>
* Author: <ZeAi Sun>
*
* This file defines the factorial function 
* previously declared in main.c.  It recursively 
* calculates the factorial of the received input value.
* 
*/

int factorial(int n)
{    
	int value = n;

    if (n == 0) {
        value = 1;
    } else {
        value = n * factorial(n - 1);
    }
	
	return value;
}
