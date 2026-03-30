----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2026 12:43:05
-- Design Name: 
-- Module Name: disp_driver - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- import custom array types
use work.Common.int_array_4x1;

entity disp_driver is
    Port ( count : in integer;
           segments : out std_logic_vector(0 to 6);     -- segments of the display to light up
           disp_choice : out std_logic_vector(0 to 3)); -- which display to ouput to
end disp_driver;


architecture Behavioral of disp_driver is
    component num_to_segments is
        Port (num : in integer;
              seg : out std_logic_vector(0 to 6));
    end component;
    
    component digit_getter is
    	Port (currNum          : in integer;        -- Taking in the current Number
        	  digitVectorArray : out int_array_4x1); -- Geting the output
	end component;
    
    for seg_converter : num_to_segments use entity work.num_to_segments(Behavioral);
    for convertsToDigit : digit_getter use entity work.digit_getter(main);
    
begin
    
    -- Count will hold the current population
    -- Separate the components of the count
    -- Feed each unit into the num_to_seg and get the displays
    -- Relate the display values to each display
    
    getSegs : process(count) is -- Change at every count adjustment
        variable digits : int_array_4x1 := (others => 0); -- This is for holding the digits
    
    begin
        -- this gets the digits as an array  
        convertsToDigit: digit_getter port map(currNum => count, digitalVectorArray => digits); 
        -- So now we have an array of ints: e.g. (0, 9, 9, 9)
        
        GEN: for i in 0 to 3 generate
            -- Next add them to the num_segment and save their result
            -- We will send each digit into the num_seg one by one
            -- Then we will save the num_segement but for the display choice
            seg_converter: num_to_segments port map (num => digits(i), seg => segments); -- relate to the segments!
            disp_choice <= (i => '0', others => '1');
            
        end generate;
        
    
    end process;
    

end Behavioral;
