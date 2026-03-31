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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- import custom array types
use work.Common.int_array_4x1;

entity disp_driver is
    Port ( clk : in std_logic;
           count : in integer;
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
    
    for intToDigits : digit_getter use entity work.digit_getter(main);
    signal digits : int_array_4x1 := (others => 0); -- This is for holding the digits
     
    type segment_array_4x1 is array (0 to 3) of std_logic_vector(0 to 6);
    signal segment_array: segment_array_4x1;

    signal active_digit : unsigned(1 downto 0) := (others => '0');
    -- switch to the next display every 2^16 clock cycles, (1525Hz)
    signal clk_count_disp : unsigned(15 downto 0) := (others => '0'); -- when using testbench, 15 -> 0
    
begin
    
    -- Split the number into 4 seperate digits   
    intToDigits: digit_getter port map(currNum => count, digitVectorArray => digits);
    
    -- Calculate what segemnts will create each digit
    GEN: for i in 0 to 3 generate
       calcSegs: entity work.num_to_segments(Behavioral) port map (num => digits(i), seg => segment_array(i));
    end generate;
    
    -- move to writing to the next digit every 2^16 clock cycles
    dispDigits : process(clk) is
    begin
        if rising_edge(clk) then
            clk_count_disp <= clk_count_disp + 1;

            -- Move to next digit after correct amount of clock cycles counted
            if clk_count_disp = 0 then
               active_digit <= active_digit + 1;
            end if;
        end if; 
    end process;
    
    -- write the segments to the selected display
    segments <= segment_array(TO_INTEGER(active_digit));
    with active_digit select
        disp_choice <= "0111" when "00",
                       "1011" when "01",
                       "1101" when "10",
                       "1110" when others;

end Behavioral;
