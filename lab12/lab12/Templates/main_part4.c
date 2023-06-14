/*
* Engr220L - Lab 12
* Date: Nov 30, 2022
* Author: ZeAi Sun
*
* Allows interaction with the LCD screen from Putty
* 
*/

// include for LCD device from the BSP
#include "altera_up_avalon_character_lcd.h"

// include for UART device from the BSP
#include "altera_up_avalon_rs232.h"

int main( void )
{
    // open the LCD device
    alt_up_character_lcd_dev * char_lcd_dev;
	char_lcd_dev = alt_up_character_lcd_open_dev ("/dev/LCD");
    
    // open the UART device
    alt_up_rs232_dev * rs232_dev;
	rs232_dev = alt_up_rs232_open_dev("/dev/UART");
    
    // if either device failed to open... return -1
    if (char_lcd_dev == NULL) {
		return -1;
	} else if (rs232_dev == NULL) {
		return -1;
	}
    
    // initialize the LCD device
    alt_up_character_lcd_init (char_lcd_dev);
    
    // declare working variables (partiy & character)
	int x = 1;
	int y = 2;
    alt_u8 * data = &x;
	alt_u8 * parity_error = &y;
    
    // loop infinitely...
    //   read UART device
    //   if read was success...
    //     write character to LCD
    //     echo reversed-case character to Putty
    while (1) {
		int result = alt_up_rs232_read_data(rs232_dev, data, parity_error);
		if (result == 0) {
			alt_up_character_lcd_string(char_lcd_dev, data);
			
			if (isupper(*data)) {
				alt_u8 new_R = tolower(*data);
				alt_up_rs232_write_data(rs232_dev, new_R);
			} else if (islower(*data)) {
				alt_u8 new_R = toupper(*data);
				alt_up_rs232_write_data(rs232_dev, new_R);
			} else {
				alt_up_rs232_write_data(rs232_dev, *data);
			}
		}
    }
	
    // Return Success
    return 0;
}
