library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch is
    port(
        clk_i : in std_logic;
        run_i : in std_logic;
        reset_i : in std_logic;
        counts_o : out digits(2 downto 0)
    );
end entity;

architecture logic of stopwatch is
    signal counts : digits(2 downto 0);
    signal max : std_logic_vector(2 downto 0) := (others => '0');
begin
    counter_0 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => run_i,
        reset_i => reset_i,
        count_o => counts(0),
        max_o => max(0)
    );

    counter_1 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => max(0),
        reset_i => reset_i,
        count_o => counts(1),
        max_o => max(1)
    );

    counter_2 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => max(1) and max(0),
        reset_i => reset_i,
        count_o => counts(2),
        max_o => max(2)
    );

    counts_o <= counts;
end architecture;
