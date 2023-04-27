library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch is
    port(
        clk_i : in std_logic;
        run_i : in std_logic;
        reset_i : in std_logic;
        counts_o : out matrix(3 downto 0)
    );
end entity;

architecture logic of stopwatch is
    constant DIGITS : natural := 4;

    signal counts : matrix(DIGITS-1 downto 0) := (others => (others => '0'));
    signal run : std_logic_vector(DIGITS downto 0) := (others => '0');
begin
    -- El primer counter está enganchado directamente a la señal de entrada run_i.
    run(0) <= run_i;

    -- Generamos DIGITS counters conectados en cascada.
    COUNTERS : for i in 0 to DIGITS-1 generate
        bcd_counter : entity work.bcd_counter
        port map(
            clk_i => clk_i,
            run_i => run(i),
            reset_i => reset_i,
            count_o => counts(i),
            -- No podemos usar un if generate acá para evitar el bit extra de run?
            max_o => run(i + 1)
        );
    end generate;

    counts_o <= counts;
end architecture;
