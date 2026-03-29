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

entity disp_driver is
    Port ( count : in integer;
           segments : out std_logic_vector(0 to 6);  -- segments of the display to light up
           disp_choice : out std_logic_vector(0 to 3));
end disp_driver;



architecture Behavioral of disp_driver is

    component num_to_segments is
    Port (num : in integer;
          seg : out std_logic_vector(0 to 6));
    end component;
    
    component digit_getter is
    	Port (
        	currNum          : in integer; -- Taking in the current Number
        	digitVectorArray : out vector_array -- Geting the output
    		);
	end component;
    
    for seg_converter : num_to_segments use entity work.num_to_segments(Behavioral);
    for dig_converter : digit_getter use entity work.digit_getter(main);
    
    -- This is for the int array that will hold the numbers
    type int_arr is array (3 downto 0) of integer;  
    -- This is for all the array of segements that will hold all total segments
    type seg_arr is array(3 downto 0) of std_logic_vector(0 to 6);
    
    type vector_array is array (0 to 3) of std_logic_vector(0 downto 3);
    
	begin
    
    -- Count will hold the current population
    -- Separate the components of the count
    -- Feed each unit into the num_to_seg and get the displays
    -- Relate the display values to each display
    
    -- Use the mod operator to get digits
    getSegs : process(count) is -- Change at every count adjustment
    
    variable digits : int_arr := (others => 0); -- This is for holding the digits
    variable allSegments : seg_arr := (others => (others => '0')); -- TODO: resolve this issue
    -- This temp will hold the count
    variable temp : integer := 0;
    -- This is a conversion variable for the vector_array out
    variable digitArray : vector_array;
    
    begin
    
    ConvertsToDigit : dig_converter
    port map(currNum => count, digitalVectorArray => digitArray); -- this gets the digits as an array 
    -- (0, std_logic_v(9), std_logic_v(9), std_logic_v(9)) example
    
    -- Next we need to convert this array of std_logic_vectors into integers
    for i is 0 to 3 loop
    	digit(i) := to_integer(digitalVectorArray(i)); -- Convert the element to an integer 
        -- store it in digit
    end loop;
    
    -- So now we have an array of ints: (0, 9, 9, 9)
    
    getSegs_GEN : for i in 3 downto 0 generate
     
	-- Next add them to the num_segment and save their result
    -- We will send each digit into the num_seg one by one
    -- Then we will save the num_segement but for the display choice
	num_to_seg_inst: seg_converter
	port map (num => digits(i), seg => allSegments(i)); -- relate to the segments!
    
	end generate;
    
    -- in theory we would have now gotten an array of all the segements corresponding to the numbers
    -- hopefully
    -- Now we map them the segment
    -- And to the display choice
    for j is 0 to 3 loop
    segments <= allSegments(disp_choice);
    disp_choice <= (j => '0', others => '1');
    end loop;
    
    end process;
    

end Behavioral;
