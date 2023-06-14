/*
* Engr220L - Lab 7 Prelab
* Date: <Oct 11, 2022>
* Author: <ZeAi Sun>
*
* This simple program calculates the values of n! for 
* the range of 0 <= n <= 10 and stores them in a global 
* array.  
* 
*/

// Global Array to store the factorial values
int Fact[10];

// Function Prototype Declaration to be defined and linked 
// against the defintion code written in factorial.c
int factorial( int n );

int main()
{
    int n = 0;
    for ( n = 0 ; n < 11 ; n++ )
    {
        Fact[n] = factorial(n); // call factorial() to do the calculation
    }
    
    return 0;  // 0 indicates success
}
