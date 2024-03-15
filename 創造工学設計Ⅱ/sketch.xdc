# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLOCK]
set_property IOSTANDARD LVCMOS33 [get_ports CLOCK]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# Buttons
#set_property PACKAGE_PIN U18 [get_ports rst]
#set_property IOSTANDARD LVCMOS33 [get_ports rst]

# VGA Connector
set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
set_property PACKAGE_PIN P19 [get_ports Hsync]
set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
set_property PACKAGE_PIN R19 [get_ports Vsync]
set_property IOSTANDARD LVCMOS33 [get_ports Vsync]

# Configuration options, can be used for all designs
#set_property CONFIG_VOLTAGE 3.3 [current_design]
#set_property CFGBVS VCCO [current_design]

set_property PACKAGE_PIN V17 [get_ports stage_1]
set_property PACKAGE_PIN V16 [get_ports stage_2]
set_property PACKAGE_PIN W16 [get_ports stage_3]
set_property PACKAGE_PIN W17 [get_ports stage_4]
set_property PACKAGE_PIN W15 [get_ports stage_5]
set_property IOSTANDARD LVCMOS33 [get_ports stage_1]
set_property IOSTANDARD LVCMOS33 [get_ports stage_2]
set_property IOSTANDARD LVCMOS33 [get_ports stage_3]
set_property IOSTANDARD LVCMOS33 [get_ports stage_4]
set_property IOSTANDARD LVCMOS33 [get_ports stage_5]

set_property PACKAGE_PIN T18 [get_ports {btn[0]}]
set_property PACKAGE_PIN W19 [get_ports {btn[3]}]
set_property PACKAGE_PIN U17 [get_ports {btn[1]}]
set_property PACKAGE_PIN T17 [get_ports {btn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[0]}]

set_property PACKAGE_PIN U18 [get_ports {btn[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn[4]}]

#set_property PACKAGE_PIN V17 [get_ports {brush[0]}]
#set_property PACKAGE_PIN V16 [get_ports {brush[1]}]
#set_property PACKAGE_PIN W16 [get_ports {brush[2]}]
#set_property PACKAGE_PIN W17 [get_ports {brush[3]}]
#set_property PACKAGE_PIN W15 [get_ports {brush[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {brush[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {brush[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {brush[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {brush[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {brush[0]}]
#set_property PACKAGE_PIN V15 [get_ports {color[0]}]
#set_property PACKAGE_PIN W14 [get_ports {color[1]}]
#set_property PACKAGE_PIN W13 [get_ports {color[2]}]
#set_property PACKAGE_PIN V2 [get_ports {color[3]}]
#set_property PACKAGE_PIN T3 [get_ports {color[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {color[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {color[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {color[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {color[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {color[0]}]
#set_property PACKAGE_PIN T2 [get_ports {shape[0]}]
#set_property PACKAGE_PIN R3 [get_ports {shape[1]}]
#set_property PACKAGE_PIN W2 [get_ports {shape[2]}]
#set_property PACKAGE_PIN U1 [get_ports {shape[3]}]
#set_property PACKAGE_PIN T1 [get_ports {shape[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {shape[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {shape[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {shape[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {shape[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {shape[0]}]
set_property PACKAGE_PIN R2 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

#set_property PACKAGE_PIN W6 [get_ports {seg1[1]}]
#set_property PACKAGE_PIN V8 [get_ports {seg1[3]}]
#set_property PACKAGE_PIN U8 [get_ports {seg1[2]}]
#set_property PACKAGE_PIN U5 [get_ports {seg1[4]}]
#set_property PACKAGE_PIN V5 [get_ports {seg1[5]}]
#set_property PACKAGE_PIN U7 [get_ports {seg1[6]}]
#set_property PACKAGE_PIN V7 [get_ports {seg1[7]}]
#set_property PACKAGE_PIN U2 [get_ports {seg1[8]}]
#set_property PACKAGE_PIN U4 [get_ports {seg1[9]}]
#set_property PACKAGE_PIN V4 [get_ports {seg1[10]}]
#set_property PACKAGE_PIN W4 [get_ports {seg1[11]}]
#set_property PACKAGE_PIN W7 [get_ports {seg1[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {seg1[0]}]

