----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2026 12:43:05
-- Design Name: 
-- Module Name: digit_getter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- import custom array types
use work.Common.int_array_4x1;

entity digit_getter is
    Port (currNum : in integer; -- Taking in the current Number
          digitVectorArray : out int_array_4x1); -- each digit of number

end digit_getter;

architecture main of digit_getter is
begin

	getDigits : process(currNum) is
		variable temp : integer; -- This will hold an altering currNum
        -- Values to fit into array elements
        variable digit0 : integer;
        variable digit1 : integer;
        variable digit2 : integer;
        variable digit3 : integer;
        
	begin 
    	temp := currNum; -- Make the temp current number for good editing
        
        digit0 := temp / 1000; -- Extract thousand
        temp := temp - (digit0 * 1000); -- Move all unwanted!
        
        digit1 := temp / 100; -- Extract hundred
        temp := temp - (digit1 * 100); -- Move all unwanted!
        
        digit2 := temp / 10; -- Extract tens
        temp := temp - (digit2 * 10); -- Move all unwanted!
        
        digit3 := temp; -- Just add the single unit

		-- All add to the output array!
        digitVectorArray(0) <= digit0;
        digitVectorArray(1) <= digit1;
        digitVectorArray(2) <= digit2;
        digitVectorArray(3) <= digit3;
	end process;

end main;
