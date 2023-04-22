library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter_tb is
end entity;

architecture behavior of bcd_counter_tb is
    constant N : natural := 4;
    constant clk_period : time := 1 ms;

    signal clk : std_logic := '1';
    signal run : std_logic := '1';
    signal reset : std_logic := '0';
    signal count : std_logic_vector(N-1 downto 0);
    signal max : std_logic := '0';
begin
    clk_process : process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;

    bcd_counter : entity work.bcd_counter
        port map(
            clk_i => clk,
            run_i => run,
            reset_i => reset,
            count_o => count,
            max_o => max
        );

    -- run <= '1', '0' after 8 ms;
end architecture;
