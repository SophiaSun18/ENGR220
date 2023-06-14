/*
* Engr220L - Lab 11
* Date: Nov 16
* Author: ZeAi Sun
*
* This simple program displays "Hello, I am Sophia Sun" to the DE2 board.
* 
*/
#include "altera_up_avalon_character_lcd.h"

int main()
{
	alt_up_character_lcd_dev * char_lcd_dev;
	
	// open the Character LCD port
	char_lcd_dev = alt_up_character_lcd_open_dev ("/dev/LCD");
	
	/* Initialize the character display */
	alt_up_character_lcd_init (char_lcd_dev);
	
	/* Write "Hello, I am" in the first row */
	alt_up_character_lcd_string(char_lcd_dev, "   Hello, I am");
	
	/* Write "Sophia Sun" in the second row */
	char second_row[] = "   Sophia Sun\0";
	alt_up_character_lcd_set_cursor_pos(char_lcd_dev, 0, 1);
	alt_up_character_lcd_string(char_lcd_dev, second_row);
}
