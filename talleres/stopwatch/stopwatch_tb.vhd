library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch_tb is
end entity;

architecture behavior of stopwatch_tb is
    constant stopwatch_clk_period : time := 1 ms;
    signal stopwatch_clk : std_logic := '1';

    constant dimmer_clk_period : time := 100 us;
    signal dimmer_clk : std_logic := '1';

    signal run : std_logic := '1';
    signal reset : std_logic := '0';
    signal counts : matrix(3 downto 0) := (others => (others => '0'));
begin
    stopwatch_clk_process : process
    begin
        stopwatch_clk <= '1';
        wait for stopwatch_clk_period / 2;
        stopwatch_clk <= '0';
        wait for stopwatch_clk_period / 2;
    end process;

    dimmer_clk_process : process
    begin
        dimmer_clk <= '1';
        wait for dimmer_clk_period / 2;
        dimmer_clk <= '0';
        wait for dimmer_clk_period / 2;
    end process;

    stopwatch : entity work.stopwatch
        port map(
            clk_i => stopwatch_clk,
            run_i => run,
            reset_i => reset,
            counts_o => counts
        );

    display : entity work.display
        port map(
            clk_i => dimmer_clk,
            counts_i => counts,
            leds_o => open
        );

end architecture;
