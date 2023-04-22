library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch_tb is
end entity;

architecture behavior of stopwatch_tb is
    constant N : natural := 3;
    constant clk_period : time := 1 ms;

    signal clk : std_logic := '1';
    signal run : std_logic := '1';
    signal reset : std_logic := '0';
    signal counts : digits(2 downto 0);
begin
    clk_process : process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;

    stopwatch : entity work.stopwatch
        port map(
            clk_i => clk,
            run_i => run,
            reset_i => reset,
            counts_o => counts
        );
end architecture;
