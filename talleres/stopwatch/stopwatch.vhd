library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch is
    port(
        clk_i : in std_logic;
        run_i : in std_logic;
        reset_i : in std_logic;
        counts_o : out vector_of_integers(2 downto 0)
    );
end entity;

architecture logic of stopwatch is
    constant DIGITS : natural := 3;

    signal counts : vector_of_integers(DIGITS-1 downto 0);
    signal run : std_logic_vector(DIGITS-1 downto 0) := (others => '0');
begin
    counter_0 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => run_i,
        reset_i => reset_i,
        count_o => counts(0),
        max_o => run(1)
    );

    counter_1 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => run(1),
        reset_i => reset_i,
        count_o => counts(1),
        max_o => run(2)
    );

    counter_2 : entity work.bcd_counter
    port map(
        clk_i => clk_i,
        run_i => run(2),
        reset_i => reset_i,
        count_o => counts(2)
        -- max_o => run(3)
    );

    counts_o <= counts;
end architecture;
