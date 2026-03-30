----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2026 11:03:14
-- Design Name: 
-- Module Name: num_to_segments - Behavioral
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

-- converts number to a bit array of segments to activate
-- segments:
--  -A-     -0-
--  F B     5 1
--  -G-  =  -6-
--  E C     4 2
--  -D-     -3-

entity num_to_segments is
    Port (num : in integer;
          seg : out std_logic_vector(0 to 6));
end num_to_segments;

architecture Behavioral of num_to_segments is
begin
    process (num) is
    begin
        -- configure which segments should be activated for each number
        case num is
            when 0 => 
                seg <= (0|1|2|3|4|5 => '0', others => '1');
            when 1 => 
                seg <= (1|2 => '0', others => '1');
            when 2 => 
                seg <= (0|1|3|4|6 => '0', others => '1');
            when 3 => 
                seg <= (0|1|2|3|6 => '0', others => '1');
            when 4 => 
                seg <= (1|2|5|6 => '0', others => '1');
            when 5 => 
                seg <= (0|2|3|5|6 => '0', others => '1');
            when 6 => 
                seg <= (0|2|3|4|5|6 => '0', others => '1');
            when 7 => 
                seg <= (0|1|2 => '0', others => '1');
            when 8 => 
                seg <= (0|1|2|3|4|5|6 => '0', others => '1');
            when 9 => 
                seg <= (0|1|2|3|5|6 => '0', others => '1');
                
            -- error case, show E
            when others => 
                seg <= (0|3|4|5|6 => '0', others => '1'); 
        
        end case;
    end process;

end Behavioral;
