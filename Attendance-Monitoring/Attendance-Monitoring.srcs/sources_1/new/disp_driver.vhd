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
    
    for converter : num_to_segments use entity work.num_to_segments(Behavioral);
begin
    -- TODO: turn number into output for 4x 7-segment displays
    

end Behavioral;
