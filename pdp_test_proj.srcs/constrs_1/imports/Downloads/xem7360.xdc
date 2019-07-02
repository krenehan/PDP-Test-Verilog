set_property PACKAGE_PIN C26 [get_ports {okUHU[8]}]
set_property PACKAGE_PIN E21 [get_ports {okUHU[18]}]
set_property PACKAGE_PIN J24 [get_ports {okUHU[28]}]
set_property PACKAGE_PIN H26 [get_ports {okUHU[30]}]
set_property PACKAGE_PIN E26 [get_ports {okUHU[31]}]
set_property PACKAGE_PIN A20 [get_ports {okUHU[3]}]
set_property PACKAGE_PIN B20 [get_ports {okUHU[4]}]
set_property PACKAGE_PIN C22 [get_ports {okUHU[5]}]
set_property PACKAGE_PIN D21 [get_ports {okUHU[6]}]
set_property PACKAGE_PIN C24 [get_ports {okUHU[7]}]
set_property PACKAGE_PIN B21 [get_ports {okUHU[0]}]
set_property PACKAGE_PIN A24 [get_ports {okUHU[10]}]
set_property PACKAGE_PIN A23 [get_ports {okUHU[11]}]
set_property PACKAGE_PIN A22 [get_ports {okUHU[12]}]
set_property PACKAGE_PIN B22 [get_ports {okUHU[13]}]
set_property PACKAGE_PIN A25 [get_ports {okUHU[14]}]
set_property PACKAGE_PIN B24 [get_ports {okUHU[15]}]
set_property PACKAGE_PIN G21 [get_ports {okUHU[16]}]
set_property PACKAGE_PIN E23 [get_ports {okUHU[17]}]
set_property PACKAGE_PIN H22 [get_ports {okUHU[19]}]
set_property PACKAGE_PIN C21 [get_ports {okUHU[1]}]
set_property PACKAGE_PIN D23 [get_ports {okUHU[20]}]
set_property PACKAGE_PIN J21 [get_ports {okUHU[21]}]
set_property PACKAGE_PIN K22 [get_ports {okUHU[22]}]
set_property PACKAGE_PIN D24 [get_ports {okUHU[23]}]
set_property PACKAGE_PIN K23 [get_ports {okUHU[24]}]
set_property PACKAGE_PIN H24 [get_ports {okUHU[25]}]
set_property PACKAGE_PIN F24 [get_ports {okUHU[26]}]
set_property PACKAGE_PIN D25 [get_ports {okUHU[27]}]
set_property PACKAGE_PIN B26 [get_ports {okUHU[29]}]
set_property PACKAGE_PIN E22 [get_ports {okUHU[2]}]
set_property PACKAGE_PIN D26 [get_ports {okUHU[9]}]
############################################################################
# XEM7360 - Xilinx constraints file
#
# Pin mappings for the XEM7360.  Use this as a template and comment out
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2016 Opal Kelly Incorporated
############################################################################

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

############################################################################
## FrontPanel Host Interface
############################################################################
set_property PACKAGE_PIN F23 [get_ports {okHU[0]}]
set_property PACKAGE_PIN H23 [get_ports {okHU[1]}]
set_property PACKAGE_PIN J25 [get_ports {okHU[2]}]
set_property SLEW FAST [get_ports {okHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okHU[*]}]

set_property PACKAGE_PIN F22 [get_ports {okUH[0]}]
set_property PACKAGE_PIN G24 [get_ports {okUH[1]}]
set_property PACKAGE_PIN J26 [get_ports {okUH[2]}]
set_property PACKAGE_PIN G26 [get_ports {okUH[3]}]
set_property PACKAGE_PIN C23 [get_ports {okUH[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUH[*]}]

set_property SLEW FAST [get_ports {okUHU[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports {okUHU[*]}]

set_property PACKAGE_PIN R26 [get_ports okAA]
set_property IOSTANDARD LVCMOS33 [get_ports okAA]


create_clock -period 9.920 -name okUH0 [get_ports {okUH[0]}]

set_input_delay -clock [get_clocks okUH0] -max -add_delay 8.000 [get_ports {okUH[*]}]
set_input_delay -clock [get_clocks okUH0] -min -add_delay 10.000 [get_ports {okUH[*]}]
set_multicycle_path -setup -from [get_ports {okUH[*]}] 2

set_input_delay -clock [get_clocks okUH0] -max -add_delay 8.000 [get_ports {okUHU[*]}]
set_input_delay -clock [get_clocks okUH0] -min -add_delay 2.000 [get_ports {okUHU[*]}]
set_multicycle_path -setup -from [get_ports {okUHU[*]}] 2

set_output_delay -clock [get_clocks okUH0] -max -add_delay 2.000 [get_ports {okHU[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay -0.500 [get_ports {okHU[*]}]

set_output_delay -clock [get_clocks okUH0] -max -add_delay 2.000 [get_ports {okUHU[*]}]
set_output_delay -clock [get_clocks okUH0] -min -add_delay -0.500 [get_ports {okUHU[*]}]


############################################################################
## System Clock
############################################################################
set_property IOSTANDARD LVDS [get_ports sys_clkp]

set_property IOSTANDARD LVDS [get_ports sys_clkn]
set_property PACKAGE_PIN AB11 [get_ports sys_clkp]
set_property PACKAGE_PIN AC11 [get_ports sys_clkn]

create_clock -period 5.000 -name sys_clk [get_ports sys_clkp]
set_clock_groups -asynchronous -group [get_clocks sys_clk] -group [get_clocks okUH0]
set_clock_groups -asynchronous -group [get_clocks sys_clk] -group [get_clocks mmcm0_clk0]

############################################################################
## User Reset
############################################################################
set_property PACKAGE_PIN G22 [get_ports reset_board]
set_property IOSTANDARD LVCMOS18 [get_ports reset_board]


set_property IOSTANDARD LVDS_25 [get_ports {anodep[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {anoden[*]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {anode[0]}]
set_property DIFF_TERM TRUE [get_ports {anodep[*]}]
set_property DIFF_TERM TRUE [get_ports {anoden[*]}]

# MC1-1 - L3P
#set_property IOSTANDARD LVDS [get_ports {}]

# MC1-2 - L4P
#set_property PACKAGE_PIN C19 [get_ports {anodep[1]}]
#set_property IOSTANDARD LVDS [get_ports {}]

# MC1-3 - L3N
set_property PACKAGE_PIN B17 [get_ports {anodep[0]}]
set_property PACKAGE_PIN A17 [get_ports {anoden[0]}]
#set_property IOSTANDARD LVDS [get_ports {}]

# MC1-4 - L4N
#set_property PACKAGE_PIN B19 [get_ports {anoden[1]}]
#set_property IOSTANDARD LVDS [get_ports {}]

# MC1-5 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-6 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-7  - L11P
#set_property PACKAGE_PIN G17 [get_ports {anodep[2]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-8 - L2P
#set_property PACKAGE_PIN A18 [get_ports {anodep[3]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-9 - L11N
#set_property PACKAGE_PIN F18 [get_ports {anoden[2]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-10 -L2N
#set_property PACKAGE_PIN A19 [get_ports {anoden[3]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-11 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-12 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-13 - L16P
#set_property PACKAGE_PIN G19 [get_ports {anodep[4]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-14 - L10P
#set_property PACKAGE_PIN E15 [get_ports {anodep[5]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-15 - L16N
#set_property PACKAGE_PIN F20 [get_ports {anoden[4]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-16 - L10N
#set_property PACKAGE_PIN E16 [get_ports {anoden[5]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-17 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-18 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-19 - L17P
#set_property PACKAGE_PIN F19 [get_ports {anodep[6]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-20 - L18P
#set_property PACKAGE_PIN H19 [get_ports {anodep[7]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-21 - L17N
#set_property PACKAGE_PIN E20 [get_ports {anoden[6]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-22 - L18N
#set_property PACKAGE_PIN G20 [get_ports {anoden[7]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-23 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-24 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-25 - L12P
#set_property PACKAGE_PIN F17 [get_ports {anodep[8]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-26 - L5P
#set_property PACKAGE_PIN C17 [get_ports {anodep[9]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-27 - L12N
#set_property PACKAGE_PIN E17 [get_ports {anoden[8]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-28 - L5N
#set_property PACKAGE_PIN C18 [get_ports {anoden[9]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-29 - IO
#set_property PACKAGE_PIN K15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-30 - L6P
#set_property PACKAGE_PIN D15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-31 - L21P
#set_property PACKAGE_PIN L19 [get_ports {anodep[10]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-32 - L1P
#set_property PACKAGE_PIN C16 [get_ports {anodep[11]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-33 - L21N
#set_property PACKAGE_PIN L20 [get_ports {anoden[10]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-34 - L1N
#set_property PACKAGE_PIN B16 [get_ports {anoden[11]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-35 - L23P
#set_property PACKAGE_PIN M17 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-36 - L19P
#set_property PACKAGE_PIN K20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-37 - L20P
#set_property PACKAGE_PIN J18 [get_ports {anodep[11]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-38 - L14P
#set_property PACKAGE_PIN H17 [get_ports {anodep[12]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-39 - L20N
#set_property PACKAGE_PIN J19 [get_ports {anoden[11]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-40 - L14N
#set_property PACKAGE_PIN H18 [get_ports {anoden[12]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-41 - L23N
#set_property PACKAGE_PIN L18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-42 - L24N
#set_property PACKAGE_PIN K18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-43 - L8P
#set_property PACKAGE_PIN G15 [get_ports {anodep[13]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-44 - L15P
#set_property PACKAGE_PIN D19 [get_ports {anodep[14]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-45 - L8N
#set_property PACKAGE_PIN F15 [get_ports {anoden[13]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-46 - L15N
#set_property PACKAGE_PIN D20 [get_ports {anoden[14]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-47 - L24P
#set_property PACKAGE_PIN L17 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-48 - IO
#set_property PACKAGE_PIN M16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-49 - L7P
#set_property PACKAGE_PIN H16 [get_ports {anodep[15]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-50 - L13P
#set_property PACKAGE_PIN E18 [get_ports {anodep[16]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-51 - L7N
#set_property PACKAGE_PIN G16 [get_ports {anoden[15]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-52 - L13N
#set_property PACKAGE_PIN D18 [get_ports {anoden[16]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-53 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-54 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-55 - L22P
#set_property PACKAGE_PIN K16 [get_ports {anodep[17]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-56 - L9P
#set_property PACKAGE_PIN J15 [get_ports {anodep[18]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-57 - L22N
#set_property PACKAGE_PIN K17 [get_ports {anoden[17]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-58 - L9N
#set_property PACKAGE_PIN J16 [get_ports {anoden[18]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-59 - VADJ1
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-60 - VADJ1
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-61 - L14P
#set_property PACKAGE_PIN E11 [get_ports {anodep[19]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-62 - L5P
#set_property PACKAGE_PIN H14 [get_ports {anodep[20]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-63 - L14N
#set_property PACKAGE_PIN D11 [get_ports {anoden[19]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-64 - L5N
#set_property PACKAGE_PIN G14 [get_ports {anoden[20]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-65 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-66 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-67 - L3P
#set_property PACKAGE_PIN J13 [get_ports {anodep[21]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-68 - L16P
#set_property PACKAGE_PIN G12 [get_ports {anodep[22]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-69 - L3N
#set_property PACKAGE_PIN H13 [get_ports {anoden[21]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-70 - L16N
#set_property PACKAGE_PIN F12 [get_ports {anoden[22]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-71 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-72 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-73 - L17P
#set_property PACKAGE_PIN D14 [get_ports {anodep[23]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-74 - L15P
#set_property PACKAGE_PIN F14 [get_ports {anodep[24]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-75 - L17N
#set_property PACKAGE_PIN D13 [get_ports {anoden[23]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-76 - L15N
#set_property PACKAGE_PIN F13 [get_ports {anoden[24]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-77 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-78 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-79 - L18P
#set_property PACKAGE_PIN E13 [get_ports {anodep[25]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-80 - L20P
#set_property PACKAGE_PIN B12 [get_ports {anodep[26]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-81 - L18N
#set_property PACKAGE_PIN E12 [get_ports {anoden[25]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-82 - L20N
#set_property PACKAGE_PIN B11 [get_ports {anoden[26]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-83 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-84 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-85 - L12P
#set_property PACKAGE_PIN E10 [get_ports {anodep[27]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-86 - L13P
#set_property PACKAGE_PIN C12 [get_ports {anodep[28]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-87 - L12N
#set_property PACKAGE_PIN D10 [get_ports {anoden[27]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-88 - L13N
#set_property PACKAGE_PIN C11 [get_ports {anoden[28]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-89 - IO
#set_property PACKAGE_PIN J8 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-90 - L23P
#set_property PACKAGE_PIN B15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-91 - L8P
#set_property PACKAGE_PIN D9 [get_ports {anodep[29]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-92 - L21P
#set_property PACKAGE_PIN B14 [get_ports {anodep[30]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-93 - L8N
#set_property PACKAGE_PIN D8 [get_ports {anoden[29]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-94 - L21N
#set_property PACKAGE_PIN A14 [get_ports {anoden[30]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-95 - L24P
#set_property PACKAGE_PIN A13 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-96 - L23N
#set_property PACKAGE_PIN A15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-97 - L7P
#set_property PACKAGE_PIN F9 [get_ports {anodep[31]}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-98 - L11P
#set_property PACKAGE_PIN G11 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC1-99 - L7N
#set_property PACKAGE_PIN F8 [get_ports {anoden[31]}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-100 - L11N
#set_property PACKAGE_PIN F10 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-101 - L24N
#set_property PACKAGE_PIN A12 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-102 - IO
#set_property PACKAGE_PIN J14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-103 - L4P
#set_property PACKAGE_PIN J11 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-104 - L22P
#set_property PACKAGE_PIN B10 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-105 - L4N
#set_property PACKAGE_PIN J10 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-106 - L22N
#set_property PACKAGE_PIN A10 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-107 - L6P
#set_property PACKAGE_PIN H12 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-108 - L19P
#set_property PACKAGE_PIN C14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-109 - L2P
#set_property PACKAGE_PIN G10 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-110 - L10P
#set_property PACKAGE_PIN C9 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-111  - L2N
#set_property PACKAGE_PIN G9 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-112 - L10N
#set_property PACKAGE_PIN B9 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-113 - Ground
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-114 - VREF
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-115 - L1P
#set_property PACKAGE_PIN H9 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-116 - L9P
#set_property PACKAGE_PIN A9 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-117 - L1N
#set_property PACKAGE_PIN H8 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-118 - L9N
#set_property PACKAGE_PIN A8 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-119 - VADJ1
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-120 - VADJ1
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-121
#set_property PACKAGE_PIN H2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-122
#set_property PACKAGE_PIN A4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-123
#set_property PACKAGE_PIN H1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-124
#set_property PACKAGE_PIN A3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-125
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-126
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-127
#set_property PACKAGE_PIN K2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-128
#set_property PACKAGE_PIN B2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-129
#set_property PACKAGE_PIN K1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-130
#set_property PACKAGE_PIN B1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-131
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-132
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-133
#set_property PACKAGE_PIN M2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-134
#set_property PACKAGE_PIN D2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-135
#set_property PACKAGE_PIN M1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-136
#set_property PACKAGE_PIN D1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-137
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-138
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-139
#set_property PACKAGE_PIN P2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-140
#set_property PACKAGE_PIN F2 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-141
#set_property PACKAGE_PIN P1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-142
#set_property PACKAGE_PIN F1 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-143
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-144
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-145
#set_property PACKAGE_PIN H6 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-146
#set_property PACKAGE_PIN D6 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-147
#set_property PACKAGE_PIN H5 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-148
#set_property PACKAGE_PIN D5 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-149
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-150
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-151
#set_property PACKAGE_PIN J4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-152
#set_property PACKAGE_PIN B6 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-153
#set_property PACKAGE_PIN J3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-154
#set_property PACKAGE_PIN B5 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-155
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-156
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-157
#set_property PACKAGE_PIN L4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-158
#set_property PACKAGE_PIN C4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-159
#set_property PACKAGE_PIN L3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-160
#set_property PACKAGE_PIN C3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-161
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-162
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-163
#set_property PACKAGE_PIN N4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-164
#set_property PACKAGE_PIN E4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-165
#set_property PACKAGE_PIN N3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-166
#set_property PACKAGE_PIN E3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-167
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-168
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-169
#set_property PACKAGE_PIN R4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-170
#set_property PACKAGE_PIN G4 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-171
#set_property PACKAGE_PIN R3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-172
#set_property PACKAGE_PIN G3 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-173
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-174
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-175
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-176
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-177
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-178
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-179
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC1-180
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC2-1 - L22P
set_property PACKAGE_PIN AE23 [get_ports latch_pin]
set_property IOSTANDARD LVTTL [get_ports latch_pin]

# MC2-2 - L4P
set_property PACKAGE_PIN U26 [get_ports clear_n_pin]
set_property IOSTANDARD LVTTL [get_ports clear_n_pin]

# MC2-3 - L22N
set_property PACKAGE_PIN AF23 [get_ports enable_n_pin]
set_property IOSTANDARD LVTTL [get_ports enable_n_pin]

# MC2-4 - L4P
set_property PACKAGE_PIN V26 [get_ports clock_pin]
set_property IOSTANDARD LVTTL [get_ports clock_pin]

## MC2-5
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD [get_ports {}]

## MC2-6
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC2-7
set_property PACKAGE_PIN AC23 [get_ports data_pin]
set_property IOSTANDARD LVTTL [get_ports data_pin]

## MC2-8
#set_property PACKAGE_PIN V21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-9
#set_property PACKAGE_PIN AC24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-10
#set_property PACKAGE_PIN W21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-11
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-12
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-13
#set_property PACKAGE_PIN AF24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-14
#set_property PACKAGE_PIN W25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-15
#set_property PACKAGE_PIN AF25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-16
#set_property PACKAGE_PIN W26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-17
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-18
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-19
#set_property PACKAGE_PIN Y25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-20
#set_property PACKAGE_PIN W23 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-21
#set_property PACKAGE_PIN Y26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-22
#set_property PACKAGE_PIN W24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-23
#set_property PACKAGE_PIN Y20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-24
#set_property PACKAGE_PIN AA22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-25
#set_property PACKAGE_PIN Y23 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-26
#set_property PACKAGE_PIN AB21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-27
#set_property PACKAGE_PIN AA24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-28
#set_property PACKAGE_PIN AC21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-29
#set_property PACKAGE_PIN Y22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-30
#set_property PACKAGE_PIN V24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-31
#set_property PACKAGE_PIN AD26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-32
#set_property PACKAGE_PIN AA25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-33
#set_property PACKAGE_PIN AE26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-34
#set_property PACKAGE_PIN AB25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-35
#set_property PACKAGE_PIN U24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-36
#set_property PACKAGE_PIN U25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-37
#set_property PACKAGE_PIN AD25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-38
#set_property PACKAGE_PIN AA23 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-39
#set_property PACKAGE_PIN AE25 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-40
#set_property PACKAGE_PIN AB24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-41
#set_property PACKAGE_PIN V23 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-42
#set_property PACKAGE_PIN V22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-43
#set_property PACKAGE_PIN AD23 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-44
#set_property PACKAGE_PIN AB22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-45
#set_property PACKAGE_PIN AD24 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-46
#set_property PACKAGE_PIN AC22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-47
#set_property PACKAGE_PIN U22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-48
#set_property PACKAGE_PIN U21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-49
#set_property PACKAGE_PIN AD21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-50
#set_property PACKAGE_PIN W20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-51
#set_property PACKAGE_PIN AE21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-52
#set_property PACKAGE_PIN Y21 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-53
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-54
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-55
#set_property PACKAGE_PIN AE22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-56
#set_property PACKAGE_PIN AB26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-57
#set_property PACKAGE_PIN AF22 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-58
#set_property PACKAGE_PIN AC26 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-59
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-60
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC2-61
set_property PACKAGE_PIN AE17 [get_ports array_section_b1]
set_property IOSTANDARD LVCMOS18 [get_ports array_section_b1]

# MC2-62
set_property PACKAGE_PIN W18 [get_ports array_section_b2]
set_property IOSTANDARD LVCMOS18 [get_ports array_section_b2]

# MC2-63
set_property PACKAGE_PIN AF17 [get_ports array_section_b0]
set_property IOSTANDARD LVCMOS18 [get_ports array_section_b0]

# MC2-64
set_property PACKAGE_PIN W19 [get_ports spad_b0]
set_property IOSTANDARD LVCMOS18 [get_ports spad_b0]

## MC2-65
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-66
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC2-67
set_property PACKAGE_PIN AF19 [get_ports board_b2]
set_property IOSTANDARD LVCMOS18 [get_ports board_b2]

# MC2-68
set_property PACKAGE_PIN Y17 [get_ports halo_b0]
set_property IOSTANDARD LVCMOS18 [get_ports halo_b0]

# MC2-69
set_property PACKAGE_PIN AF20 [get_ports board_b1]
set_property IOSTANDARD LVCMOS18 [get_ports board_b1]

# MC2-70
set_property PACKAGE_PIN Y18 [get_ports nir_b0]
set_property IOSTANDARD LVCMOS18 [get_ports nir_b0]

## MC2-71
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-72
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# MC2-73
set_property PACKAGE_PIN AA17 [get_ports board_b0]
set_property IOSTANDARD LVCMOS18 [get_ports board_b0]

# MC2-74
set_property PACKAGE_PIN V16 [get_ports jan_b0]
set_property IOSTANDARD LVCMOS18 [get_ports jan_b0]

## MC2-75
#set_property PACKAGE_PIN AA18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-76
#set_property PACKAGE_PIN V17 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-77
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-78
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-79
#set_property PACKAGE_PIN AA14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-80
#set_property PACKAGE_PIN Y15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-81
#set_property PACKAGE_PIN AA15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-82
#set_property PACKAGE_PIN Y16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-83
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-84
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-85
#set_property PACKAGE_PIN AB16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-86
#set_property PACKAGE_PIN AC14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-87
#set_property PACKAGE_PIN AC16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-88
#set_property PACKAGE_PIN AD14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-89
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-90
#set_property PACKAGE_PIN AD16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-91
#set_property PACKAGE_PIN AE18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-92
#set_property PACKAGE_PIN AD20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-93
#set_property PACKAGE_PIN AF18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-94
#set_property PACKAGE_PIN AE20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-95
#set_property PACKAGE_PIN W14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-96
#set_property PACKAGE_PIN W16 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-97
#set_property PACKAGE_PIN AB17 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-98
#set_property PACKAGE_PIN AC19 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-99
#set_property PACKAGE_PIN AC17 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-100
#set_property PACKAGE_PIN AD19 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-101
#set_property PACKAGE_PIN V18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-102
#set_property PACKAGE_PIN V19 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-103
#set_property PACKAGE_PIN AB14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-104
#set_property PACKAGE_PIN AC18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-105
#set_property PACKAGE_PIN AB15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-106
#set_property PACKAGE_PIN AD18 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-107
#set_property PACKAGE_PIN V14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-108
#set_property PACKAGE_PIN W15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-109
#set_property PACKAGE_PIN AF14 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-110
#set_property PACKAGE_PIN AB19 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-111
#set_property PACKAGE_PIN AF15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-112
#set_property PACKAGE_PIN AB20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-113
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-114
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-115
#set_property PACKAGE_PIN AD15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-116
#set_property PACKAGE_PIN AA19 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-117
#set_property PACKAGE_PIN AE15 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-118
#set_property PACKAGE_PIN AA20 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-119
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-120
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-121
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-122
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-123
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-124
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-125
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-126
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-127
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-128
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-129
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-130
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]
#171
## MC2-131
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-132
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-133
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-134
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-135
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-136
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-137
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-138
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-139
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-140
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-141
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-142
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-143
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-144
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-145
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-146
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-147
#set_property PACKAGE_PIN N12 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-148
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-149
#set_property PACKAGE_PIN P11 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-150
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-151
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-152
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-153
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-154
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-155
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-156
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-157
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-158
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-159
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-160
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-161
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-162
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-163
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-164
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-165
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-166
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-167
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-168
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-169
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-170
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-171
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-172
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-173
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-174
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-175
#set_property PACKAGE_PIN N8 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-176
#set_property PACKAGE_PIN L8 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-177
#set_property PACKAGE_PIN R6 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-178
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-179
#set_property PACKAGE_PIN R7 [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## MC2-180
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# LEDs #####################################################################
set_property PACKAGE_PIN T24 [get_ports {led_activelow[0]}]
set_property PACKAGE_PIN T25 [get_ports {led_activelow[1]}]
set_property PACKAGE_PIN R25 [get_ports {led_activelow[2]}]
set_property PACKAGE_PIN P26 [get_ports {led_activelow[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_activelow[*]}]

## Flash ####################################################################
#set_property PACKAGE_PIN N17 [get_ports {spi_dq0}]
#set_property PACKAGE_PIN N16 [get_ports {spi_c}]
#set_property PACKAGE_PIN R16 [get_ports {spi_s}]
#set_property PACKAGE_PIN U17 [get_ports {spi_dq1}]
#set_property PACKAGE_PIN U16 [get_ports {spi_w_dq2}]
#set_property PACKAGE_PIN T17 [get_ports {spi_hold_dq3}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dq0}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_c}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_s}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dq1}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_w_dq2}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_hold_dq3}]

## DRAM #####################################################################
#set_property PACKAGE_PIN U7 [get_ports {ddr3_dq[0]}]
#set_property PACKAGE_PIN W3 [get_ports {ddr3_dq[1]}]
#set_property PACKAGE_PIN U5 [get_ports {ddr3_dq[2]}]
#set_property PACKAGE_PIN V4 [get_ports {ddr3_dq[3]}]
#set_property PACKAGE_PIN U2 [get_ports {ddr3_dq[4]}]
#set_property PACKAGE_PIN V6 [get_ports {ddr3_dq[5]}]
#set_property PACKAGE_PIN U1 [get_ports {ddr3_dq[6]}]
#set_property PACKAGE_PIN V3 [get_ports {ddr3_dq[7]}]
#set_property PACKAGE_PIN W1 [get_ports {ddr3_dq[8]}]
#set_property PACKAGE_PIN Y1  [get_ports {ddr3_dq[9]}]
#set_property PACKAGE_PIN Y2  [get_ports {ddr3_dq[10]}]
#set_property PACKAGE_PIN AA3 [get_ports {ddr3_dq[11]}]
#set_property PACKAGE_PIN V1 [get_ports {ddr3_dq[12]}]
#set_property PACKAGE_PIN AC2 [get_ports {ddr3_dq[13]}]
#set_property PACKAGE_PIN V2 [get_ports {ddr3_dq[14]}]
#set_property PACKAGE_PIN AB2 [get_ports {ddr3_dq[15]}]
#set_property PACKAGE_PIN AD6 [get_ports {ddr3_dq[16]}]
#set_property PACKAGE_PIN AB4 [get_ports {ddr3_dq[17]}]
#set_property PACKAGE_PIN AC6 [get_ports {ddr3_dq[18]}]
#set_property PACKAGE_PIN Y6 [get_ports {ddr3_dq[19]}]
#set_property PACKAGE_PIN AC3 [get_ports {ddr3_dq[20]}]
#set_property PACKAGE_PIN Y5 [get_ports {ddr3_dq[21]}]
#set_property PACKAGE_PIN AC4 [get_ports {ddr3_dq[22]}]
#set_property PACKAGE_PIN AA4 [get_ports {ddr3_dq[23]}]
#set_property PACKAGE_PIN AF3 [get_ports {ddr3_dq[24]}]
#set_property PACKAGE_PIN AF2  [get_ports {ddr3_dq[25]}]
#set_property PACKAGE_PIN AE3  [get_ports {ddr3_dq[26]}]
#set_property PACKAGE_PIN AE2 [get_ports {ddr3_dq[27]}]
#set_property PACKAGE_PIN AE6 [get_ports {ddr3_dq[28]}]
#set_property PACKAGE_PIN AE1 [get_ports {ddr3_dq[29]}]
#set_property PACKAGE_PIN AE5 [get_ports {ddr3_dq[30]}]
#set_property PACKAGE_PIN AD1 [get_ports {ddr3_dq[31]}]
#set_property SLEW FAST [get_ports {ddr3_dq[*]}]
#set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[*]}]

#set_property PACKAGE_PIN AD8 [get_ports {ddr3_addr[0]}]
#set_property PACKAGE_PIN AC8 [get_ports {ddr3_addr[1]}]
#set_property PACKAGE_PIN AA7 [get_ports {ddr3_addr[2]}]
#set_property PACKAGE_PIN AA8 [get_ports {ddr3_addr[3]}]
#set_property PACKAGE_PIN AF7 [get_ports {ddr3_addr[4]}]
#set_property PACKAGE_PIN AE7 [get_ports {ddr3_addr[5]}]
#set_property PACKAGE_PIN W8 [get_ports {ddr3_addr[6]}]
#set_property PACKAGE_PIN V9 [get_ports {ddr3_addr[7]}]
#set_property PACKAGE_PIN Y10 [get_ports {ddr3_addr[8]}]
#set_property PACKAGE_PIN Y11 [get_ports {ddr3_addr[9]}]
#set_property PACKAGE_PIN Y7 [get_ports {ddr3_addr[10]}]
#set_property PACKAGE_PIN Y8 [get_ports {ddr3_addr[11]}]
#set_property PACKAGE_PIN V7 [get_ports {ddr3_addr[12]}]
#set_property PACKAGE_PIN V8 [get_ports {ddr3_addr[13]}]
#set_property PACKAGE_PIN W11 [get_ports {ddr3_addr[14]}]
#set_property PACKAGE_PIN V11 [get_ports {ddr3_addr[15]}]
#set_property SLEW FAST [get_ports {ddr3_addr[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[*]}]

#set_property PACKAGE_PIN AA9 [get_ports {ddr3_ba[0]}]
#set_property PACKAGE_PIN AC7 [get_ports {ddr3_ba[1]}]
#set_property PACKAGE_PIN AB7 [get_ports {ddr3_ba[2]}]
#set_property SLEW FAST [get_ports {ddr3_ba[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[*]}]

#set_property PACKAGE_PIN AB9 [get_ports {ddr3_ras_n}]
#set_property SLEW FAST [get_ports {ddr3_ras_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]

#set_property PACKAGE_PIN AC9 [get_ports {ddr3_cas_n}]
#set_property SLEW FAST [get_ports {ddr3_cas_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]

#set_property PACKAGE_PIN AD9 [get_ports {ddr3_we_n}]
#set_property SLEW FAST [get_ports {ddr3_we_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]

#set_property PACKAGE_PIN AA2 [get_ports {ddr3_reset_n}]
#set_property SLEW FAST [get_ports {ddr3_reset_n}]
#set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]

#set_property PACKAGE_PIN AC12 [get_ports {ddr3_cke[0]}]
#set_property PACKAGE_PIN AA12 [get_ports {ddr3_cke[1]}]
#set_property SLEW FAST [get_ports {ddr3_cke[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[*]}]

#set_property PACKAGE_PIN AA13 [get_ports {ddr3_odt[0]}]
#set_property PACKAGE_PIN AD13 [get_ports {ddr3_odt[1]}]
#set_property SLEW FAST [get_ports {ddr3_odt[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[*]}]

#set_property PACKAGE_PIN AB12 [get_ports {ddr3_cs_n[0]}]
#set_property PACKAGE_PIN AC13 [get_ports {ddr3_cs_n[1]}]
#set_property SLEW FAST [get_ports {ddr3_cs_n[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_cs_n[*]}]

#set_property PACKAGE_PIN U6 [get_ports {ddr3_dm[0]}]
#set_property PACKAGE_PIN Y3 [get_ports {ddr3_dm[1]}]
#set_property PACKAGE_PIN AB6 [get_ports {ddr3_dm[2]}]
#set_property PACKAGE_PIN AD4 [get_ports {ddr3_dm[3]}]
#set_property SLEW FAST [get_ports {ddr3_dm[*]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[*]}]

#set_property PACKAGE_PIN W6 [get_ports {ddr3_dqs_p[0]}]
#set_property PACKAGE_PIN W5 [get_ports {ddr3_dqs_n[0]}]
#set_property PACKAGE_PIN AB1 [get_ports {ddr3_dqs_p[1]}]
#set_property PACKAGE_PIN AC1 [get_ports {ddr3_dqs_n[1]}]
#set_property PACKAGE_PIN AA5 [get_ports {ddr3_dqs_p[2]}]
#set_property PACKAGE_PIN AB5 [get_ports {ddr3_dqs_n[2]}]
#set_property PACKAGE_PIN AF5 [get_ports {ddr3_dqs_p[3]}]
#set_property PACKAGE_PIN AF4 [get_ports {ddr3_dqs_n[3]}]
#set_property SLEW FAST [get_ports {ddr3_dqs*}]
#set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs*}]

#set_property PACKAGE_PIN W10 [get_ports {ddr3_ck_p[0]}]
#set_property PACKAGE_PIN W9 [get_ports {ddr3_ck_n[0]}]
#set_property SLEW FAST [get_ports {ddr3_ck*}]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_*}]

## OnBoard 100Mhz MGTREFCLK #################################################
#set_property PACKAGE_PIN K6 [get_ports {mgtrefclk_p}]
#set_property PACKAGE_PIN K5 [get_ports {mgtrefclk_n}]

# Fake clock for asynchronous counter input
create_clock -period 50.000 -name {anodep[0]} -waveform {0.000 25.000} [get_ports {anodep[0]}]

#create_generated_clock -name core/decoder_read -source [get_pins core/decoder_read_reg/C] -divide_by 1 [get_pins core/decoder_read_reg/Q]
#create_generated_clock -name core/encoder_write -source [get_pins core/encoder_write_reg/C] -divide_by 1 [get_pins core/encoder_write_reg/Q]
#create_generated_clock -name core/set_relay -source [get_pins core/set_relay_reg/C] -divide_by 1 [get_pins core/set_relay_reg/Q]


create_generated_clock -name {decoder_fast_32b/state[0]} -source [get_pins {decoder_fast_32b/state_reg[0]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[0]/Q}]
create_generated_clock -name {decoder_fast_32b/state[1]} -source [get_pins {decoder_fast_32b/state_reg[1]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[1]/Q}]
create_generated_clock -name {decoder_fast_32b/state[2]} -source [get_pins {decoder_fast_32b/state_reg[2]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[2]/Q}]
create_generated_clock -name {decoder_fast_32b/state[3]} -source [get_pins {decoder_fast_32b/state_reg[3]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[3]/Q}]
create_generated_clock -name {decoder_fast_32b/state[4]} -source [get_pins {decoder_fast_32b/state_reg[4]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[4]/Q}]
create_generated_clock -name {decoder_fast_32b/state[5]} -source [get_pins {decoder_fast_32b/state_reg[5]/C}] -divide_by 1 [get_pins {decoder_fast_32b/state_reg[5]/Q}]
create_generated_clock -name {encoder_fast_32b/state[0]} -source [get_pins {encoder_fast_32b/state_reg[0]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[0]/Q}]
create_generated_clock -name {encoder_fast_32b/state[1]} -source [get_pins {encoder_fast_32b/state_reg[1]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[1]/Q}]
create_generated_clock -name {encoder_fast_32b/state[2]} -source [get_pins {encoder_fast_32b/state_reg[2]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[2]/Q}]
create_generated_clock -name {encoder_fast_32b/state[3]} -source [get_pins {encoder_fast_32b/state_reg[3]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[3]/Q}]
create_generated_clock -name {encoder_fast_32b/state[4]} -source [get_pins {encoder_fast_32b/state_reg[4]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[4]/Q}]
create_generated_clock -name {encoder_fast_32b/state[5]} -source [get_pins {encoder_fast_32b/state_reg[5]/C}] -divide_by 1 [get_pins {encoder_fast_32b/state_reg[5]/Q}]
create_generated_clock -name frontpanel_fifo_32b_fpgatopc/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwhf.whf/wr_ack -source [get_pins frontpanel_fifo_32b_fpgatopc/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwhf.whf/gwa.WR_ACK_reg/C] -divide_by 1 [get_pins frontpanel_fifo_32b_fpgatopc/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwhf.whf/gwa.WR_ACK_reg/Q]
create_generated_clock -name frontpanel_fifo_32b_pctofpga/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/grhf.rhf/valid -source [get_pins frontpanel_fifo_32b_pctofpga/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/grhf.rhf/gv.ram_valid_d1_reg/C] -divide_by 1 [get_pins frontpanel_fifo_32b_pctofpga/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/grhf.rhf/gv.ram_valid_d1_reg/Q]
create_generated_clock -name okHI/core0/core0/a0/d0/l380f95c05ffaf9f64e84defb5d30e949 -source [get_pins okHI/mmcm0/CLKOUT0] -divide_by 1 [get_pins {okHI/core0/core0/a0/d0/lc4da648cb12eeeb24e4d199c1195ed93_reg[4]/Q}]
create_generated_clock -name {relay_controller/relay_clock_generator/S[0]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/C}] -divide_by 1 [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}]
create_generated_clock -name {relay_controller/relay_shift_register/state_0[0]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/relay_shift_register/state_reg[0]/Q}]
create_generated_clock -name {relay_controller/relay_shift_register/state_0[1]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/relay_shift_register/state_reg[1]/Q}]
create_generated_clock -name {relay_controller/relay_shift_register/state_0[2]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/relay_shift_register/state_reg[2]/Q}]
create_generated_clock -name {relay_controller/relay_shift_register/state_0[3]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/relay_shift_register/state_reg[3]/Q}]
create_generated_clock -name {relay_controller/state[0]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[0]/Q}]
create_generated_clock -name {relay_controller/state[1]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[1]/Q}]
create_generated_clock -name {relay_controller/state[5]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[5]/Q}]
create_generated_clock -name {relay_controller/state[6]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[6]/Q}]
create_generated_clock -name {relay_controller/state_reg_n_0_[2]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[2]/Q}]
create_generated_clock -name {relay_controller/state_reg_n_0_[3]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[3]/Q}]
create_generated_clock -name {relay_controller/state_reg_n_0_[4]} -source [get_pins {relay_controller/relay_clock_generator/counter_reg[14]/Q}] -divide_by 1 [get_pins {relay_controller/state_reg[4]/Q}]

# IO pin constraint (useless because these are DC signals)
create_clock -period 9.920 -name VIRTUAL_mmcm0_clk0 -waveform {0.000 4.960}
set_multicycle_path -setup -from [get_clocks VIRTUAL_mmcm0_clk0] -to [get_clocks mmcm0_clk0] 2
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports array_section_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports array_section_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports array_section_b1]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports array_section_b1]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports array_section_b2]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports array_section_b2]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports board_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports board_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports board_b1]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports board_b1]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports board_b2]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports board_b2]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports halo_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports halo_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports jan_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports jan_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports nir_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports nir_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -min -add_delay 0.600 [get_ports spad_b0]
set_input_delay -clock [get_clocks VIRTUAL_mmcm0_clk0] -max -add_delay 1.100 [get_ports spad_b0]
