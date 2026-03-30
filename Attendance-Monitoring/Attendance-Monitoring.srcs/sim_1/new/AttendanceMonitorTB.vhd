----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2026 16:26:31
-- Design Name: 
-- Module Name: AttendanceMonitorTB - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity AttendanceMonitorTB is
--  Port ( );
end AttendanceMonitorTB;

architecture Behavioral of AttendanceMonitorTB is
    component AttendanceMonitor is
        Port ( clk, rst : in STD_LOGIC;
               enable: in std_logic_vector(0 to 3); -- input for each section
               warning_lights : out std_logic_vector(0 to 3);
               segments : out std_logic_vector(0 to 6);  -- segments of the display to light up
               disp_choice : out std_logic_vector(0 to 3)); -- which display to light up
    end component;
    
    signal rst_in, clk_in :  std_logic;
    signal enable_in : std_logic_vector(0 to 3) := (others => '0');
    signal warning_lights_out : std_logic_vector(0 to 3);
    signal segments_out : std_logic_vector(0 to 6);
    signal disp_choice_out : std_logic_vector(0 to 3);
    
    for G1 : AttendanceMonitor use entity work.AttendanceMonitor(Behavioral);
    
begin

    clock_gen : process
        begin
            while now <= 130 ns loop
            clk_in <= '1'; wait for 10 ns;
            clk_in <= '0'; wait for 10 ns;
        end loop;
        wait;
    end process; 
    
    stimuli: process
    begin
        rst_in <= '1'; wait for 10ns; 
        rst_in <= '0';
        enable_in(0) <= '1'; wait for 20ns;
        enable_in(0) <= '0'; enable_in(1) <= '1'; wait for 20ns;
        enable_in(1) <= '0'; enable_in(2) <= '1'; wait for 20ns;
        rst_in <= '1';
        enable_in(2) <= '0'; enable_in(3) <= '1'; wait for 20ns;        
                
        rst_in <= '0'; wait for 40ns;

    end process;
    
    G1: AttendanceMonitor port map(
        rst => rst_in, clk => clk_in, enable => enable_in, 
        warning_lights => warning_lights_out, segments => segments_out, disp_choice => disp_choice_out);

end Behavioral;
