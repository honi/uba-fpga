
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2$
create_project: 2default:default2
00:00:062default:default2
00:00:062default:default2
1274.0432default:default2
0.0232default:default2
205602default:default2
277742default:defaultZ17-722h px� 
t
Command: %s
53*	vivadotcl2C
/link_design -top i2c_test -part xc7z020clg400-12default:defaultZ4-113h px� 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px� 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px� 
V
Loading part %s157*device2#
xc7z020clg400-12default:defaultZ21-403h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2p
\/home/jb/fpga/soundfx/soundfx.runs/impl_1/.Xil/Vivado-92127-macbuntu/clk_wiz_0/clk_wiz_0.dcp2default:default2
x2default:defaultZ1-454h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1651.2932default:default2
0.0002default:default2
202252default:default2
274402default:defaultZ17-722h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
182default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2023.12default:defaultZ1-479h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
�
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt2'
x/inst/clkin1_ibufg2default:default2
sysclk2default:defaultZ31-35h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2 
IBUF_LOW_PWR2default:default2
x/sysclk2default:default2 
IBUF_LOW_PWR2default:default8Z18-550h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2c
M/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2default:default2
x/inst	2default:default8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2c
M/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2default:default2
x/inst	2default:default8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2]
G/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2default:default2
x/inst	2default:default8Z20-848h px� 
�
%Done setting XDC timing constraints.
35*timing2]
G/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2default:default2
572default:default8@Z38-35h px� 
�
Deriving generated clocks
2*timing2]
G/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2default:default2
572default:default8@Z38-2h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
get_clocks: 2default:default2
00:00:132default:default2
00:00:132default:default2
2386.6412default:default2
582.7892default:default2
196742default:default2
268762default:defaultZ17-722h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2]
G/home/jb/fpga/soundfx/soundfx.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2default:default2
x/inst	2default:default8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default8Z20-179h px� 
�
No ports matched '%s'.
584*	planAhead2
ac_bclk2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
452default:default8@Z12-584h px� 
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
452default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
ac_pbdat2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
482default:default8@Z12-584h px� 
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
482default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
ac_pblrc2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
492default:default8@Z12-584h px� 
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
492default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
	ac_recdat2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
502default:default8@Z12-584h px� 
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
502default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
	ac_reclrc2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
512default:default8@Z12-584h px� 
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default2
512default:default8@Z17-55h px�
�
Finished Parsing XDC File [%s]
178*designutils2b
L/home/jb/fpga/soundfx/soundfx.srcs/constrs_1/imports/fpga/Zybo-Z7-Master.xdc2default:default8Z20-178h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:002default:default2
2386.6412default:default2
0.0002default:default2
196742default:default2
268762default:defaultZ17-722h px� 
�
!Unisim Transformation Summary:
%s111*project2k
W  A total of 2 instances were transformed.
  IOBUF => IOBUF (IBUF, OBUFT): 2 instances
2default:defaultZ1-111h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
102default:default2
72default:default2
52default:default2
02default:defaultZ4-41h px� 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2!
link_design: 2default:default2
00:00:202default:default2
00:00:202default:default2
2386.6412default:default2
1092.7852default:default2
196742default:default2
268762default:defaultZ17-722h px� 


End Record