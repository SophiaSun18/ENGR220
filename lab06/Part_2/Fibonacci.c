/*
* Engr220L - Lab 6 Prelab
* <TEMPLATE – Oct 05, 2022>
*
* This simple program calculates the first 40 values of the 
* Fibonacci sequence and uses them to fill a global array. 
* 
* The Fibonacci sequence is implemented, according to the 
* mathematical formula:
* | fibVal[0] = 0;
* | fibVal[1] = 1;
* | fibVal[n] = ( fibVal[n-1] + fibVal[n-2] ); // for n > 1
* 
*/


//#include <stdio.h> // for printf()
// Global array to hold the calculated values for the first 
// 40 fibonacci values (n==0 to n==39)
unsigned int fibbonaciValues[40] = {0, 1};


// Entry point for the program, fills the global array 
// of fibonacci values
int main()
{
unsigned int n = 2;
for ( n = 2; n < 40; n++ )
{
unsigned int value = 0;
fibbonaciValues[n] = fibbonaciValues[n-2] + fibbonaciValues[n-1];
//printf( "%u : %u\n", n, fibbonaciValues[n] );
}
return 0;
}


