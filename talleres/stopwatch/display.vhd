library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity display is
    port(
        clk_i : in std_logic;
        counts_i : matrix(3 downto 0);
        leds_o : out std_logic_vector(3 downto 0)
    );
end entity;

architecture logic of display is
begin
    DIMMERS : for i in 0 to 3 generate
        bcd_dimmer : entity work.bcd_dimmer
        port map(
            clk_i => clk_i,
            duty_cycle_i => counts_i(i),
            led_o => leds_o(i)
        );
    end generate;
end architecture;
