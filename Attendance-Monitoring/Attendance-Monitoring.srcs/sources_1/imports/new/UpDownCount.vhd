----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2026 09:41:33
-- Design Name: 
-- Module Name: UpDownCount - Behavioral
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

entity UpDownCount is
    Port ( Clk, Reset, Enable, Load, UpDn : in std_logic;
           Data : in std_logic_vector(7 downto 0);
           Q : out std_logic_vector(7 downto 0));
end UpDownCount;

architecture Behavioral of UpDownCount is    
begin
    process (Clk, Reset)
        variable count : unsigned(7 downto 0) := "00000000";
        
    begin
        if reset = '1' then
            count := "00000000";
        
        elsif rising_edge(Clk) and Enable = '1' then
            if Load = '1'  then
                count := unsigned(Data);
                
            else
                if UpDn = '1' then
                    count := count + 1;
                else
                    count := count - 1;
                
                end if;
            end if;
        end if;
            
    Q <= std_logic_vector(count);
    end process;

end Behavioral;
