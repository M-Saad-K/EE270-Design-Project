----------------------------------------------------------------------------------
-- Company: Strathclyde University
-- Engineer: Finlay Robb, Muhammad Saad Khan
-- 
-- Create Date: 20.03.2026 12:37:52
-- Design Name: Attendance Monitor
-- Module Name: AttendanceMonitor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: An attendance monitoring system capable of keeping track of
--              the occupancy of a sports venue.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


-- Description: 4 sections, each holding 250 people
-- Tasks:
-- [ ] 4 counters up to 250
-- [ ] 4 lights for 90% full for each section
-- [ ] button to reset attendance to 0
-- [ ] obtain overall attendance figure
-- [ ] display attendance on displays

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- import custom array type
use work.Common.int_array_4x1;

entity AttendanceMonitor is
    Port ( clk, rst : in STD_LOGIC;
           enable: in std_logic_vector(0 to 3); -- input for each section
           warning_lights : out std_logic_vector(0 to 3);
           segments : out std_logic_vector(0 to 6);  -- segments of the display to light up
           disp_choice : out std_logic_vector(0 to 3)); -- which display to light up
           
    constant section_num : integer := 4;
    constant section_capacity : integer := 250;
    constant section_cap_warn : integer := section_capacity * 90 / 100; -- 90%
    
    signal total_count : integer := 0;
    
end AttendanceMonitor;

architecture Behavioral of AttendanceMonitor is
    component disp_driver is
        Port ( count : in integer;
               segments : out std_logic_vector(0 to 6);  -- segments of the display to light up
               disp_choice : out std_logic_vector(0 to 3));
    end component;
    
    signal section_counts : int_array_4x1 := (others => 0);
    for DD : disp_driver use entity work.disp_driver(Behavioral);

begin    
    -- counter for each section
    COUNT_GEN: for i in 0 to section_num-1 generate
        watch_clk_rst: process (clk, rst) is
        begin
            -- if reset pressed set count to zero and deactivate any warning lights
            if rst = '1' then
                section_counts(i) <= 0;
                warning_lights(i) <= '0';
            
            -- increment the count
            elsif rising_edge(clk) then
                if enable(i) = '1' and section_counts(i) < section_capacity then
                    section_counts(i) <= section_counts(i) + 1;
                    
                    -- if capacity > 90% turn on warning light
                    if section_counts(i) > section_cap_warn then
                        warning_lights(i) <= '1';
                    end if;
                end if;
            end if;
        end process;
    end generate;
    
    sum_counts : process (clk) is
    begin 
        total_count <= section_counts(0) + section_counts(1) + section_counts(2) + section_counts(3);
--        total_count <= 0;
--        for i in 0 to section_num-1 loop
--            total_count <= total_count + section_counts(i);
--        end loop;
    
    end process;
    
    -- call disp_driver 
    DD: disp_driver port map(count => total_count, segments => segments, disp_choice => disp_choice);
    -- map segments and disp_driver from display_driver to output

end Behavioral;
