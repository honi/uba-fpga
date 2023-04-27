GHDL_OPTS = --std=08
GHDL_SIM_OPTS = --disp-time --stop-time=10ms

stopwatch:
	ghdl -a $(GHDL_OPTS) stopwatch_pkg.vhd bcd_counter.vhd bcd_dimmer.vhd display.vhd stopwatch.vhd stopwatch_top.vhd stopwatch_tb.vhd
	ghdl -e $(GHDL_OPTS) stopwatch_tb
	ghdl -r $(GHDL_OPTS) stopwatch_tb --wave=stopwatch.ghw $(GHDL_SIM_OPTS)

view_stopwatch: stopwatch
	gtkwave stopwatch.ghw

bcd_counter:
	ghdl -a $(GHDL_OPTS) bcd_counter.vhd bcd_counter_tb.vhd
	ghdl -e $(GHDL_OPTS) bcd_counter_tb
	ghdl -r $(GHDL_OPTS) bcd_counter_tb --wave=bcd_counter.ghw $(GHDL_SIM_OPTS)

view_bcd_counter: bcd_counter
	gtkwave bcd_counter.ghw

clean:
	rm -f *.ghw
	rm -f *.cf
