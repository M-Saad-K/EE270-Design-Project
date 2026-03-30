## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports {enable[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable[0]}]
set_property PACKAGE_PIN V16 [get_ports {enable[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable[1]}]
set_property PACKAGE_PIN W16 [get_ports {enable[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable[2]}]
set_property PACKAGE_PIN W17 [get_ports {enable[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {enable[3]}]

## LEDs
set_property PACKAGE_PIN U16 [get_ports {warning_lights[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {warning_lights[0]}]
set_property PACKAGE_PIN E19 [get_ports {warning_lights[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {warning_lights[1]}]
set_property PACKAGE_PIN U19 [get_ports {warning_lights[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {warning_lights[2]}]
set_property PACKAGE_PIN V19 [get_ports {warning_lights[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {warning_lights[3]}]
			
	
##7 segment display
set_property PACKAGE_PIN W7 [get_ports {segments[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[0]}]
set_property PACKAGE_PIN W6 [get_ports {segments[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[1]}]
set_property PACKAGE_PIN U8 [get_ports {segments[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[2]}]
set_property PACKAGE_PIN V8 [get_ports {segments[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[3]}]
set_property PACKAGE_PIN U5 [get_ports {segments[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[4]}]
set_property PACKAGE_PIN V5 [get_ports {segments[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[5]}]
set_property PACKAGE_PIN U7 [get_ports {segments[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {segments[6]}]

## dont need the decimal point
#set_property PACKAGE_PIN V7 [get_ports dp]							
	#set_property IOSTANDARD LVCMOS33 [get_ports dp]

## TODO
#set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {disp_choice[0]}]
#set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {disp_choice[1]}]
#set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {disp_choice[2]}]
#set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {disp_choice[3]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
 