GHDL_OPTS = --std=08
GHDL_SIM_OPTS = --stop-time=64ms

dimmer:
	ghdl -a $(GHDL_OPTS) dimmer.vhd dimmer_tb.vhd
	ghdl -e $(GHDL_OPTS) dimmer_tb
	ghdl -r $(GHDL_OPTS) dimmer_tb --wave=dimmer.ghw $(GHDL_SIM_OPTS)

view: dimmer
	gtkwave dimmer.ghw

clean:
	rm -f *.ghw
	rm -f *.cf
