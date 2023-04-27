library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch_top is
    port(
        sysclk : in std_logic;
        run_i : in std_logic;
        reset_i : in std_logic;
        leds_o : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behavior of stopwatch_top is
    signal stopwatch_clk : std_logic := '1';
    signal stopwatch_clk_counter : unsigned(31 downto 0) := (others => '0');
    signal next_stopwatch_clk_counter : unsigned(31 downto 0) := (others => '0');

    signal counts : matrix(3 downto 0) := (others => (others => '0'));
begin
    stopwatch_clk_process : process(sysclk)
    begin
        if rising_edge(sysclk) then
            stopwatch_clk_counter <= next_stopwatch_clk_counter;
        end if;
    end process;

    next_stopwatch_clk_counter <= stopwatch_clk_counter + 1
        when stopwatch_clk_counter < 1250000 else (others => '0');
    stopwatch_clk <= '1' when stopwatch_clk_counter = 0 else '0';

    stopwatch : entity work.stopwatch
        port map(
            clk_i => stopwatch_clk,
            run_i => run_i,
            reset_i => reset_i,
            counts_o => counts
        );

    display : entity work.display
        port map(
            clk_i => sysclk,
            counts_i => counts,
            leds_o => leds_o
        );
end architecture;
