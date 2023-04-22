library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dimmer_tb is
end entity;

architecture behavior of dimmer_tb is
    constant N : natural := 3;

    signal clk_i : std_logic := '1';
    -- Como inicializar en un valor definido en base 10?
    signal duty_cycle_i : std_logic_vector(N-1 downto 0) := (others => '0');
    signal led_o : std_logic;

    constant clk_period : time := 1 ms;
begin
    clk_process : process
    begin
        clk_i <= '1';
        wait for clk_period / 2;
        clk_i <= '0';
        wait for clk_period / 2;
    end process;

    dimmer : entity work.dimmer
        generic map(N => N)
        port map(
            clk_i => clk_i,
            duty_cycle_i => duty_cycle_i,
            led_o => led_o
        );

    duty_cycle_i <= std_logic_vector(to_unsigned(0, N)),
                    std_logic_vector(to_unsigned(1, N)) after 8 ms,
                    std_logic_vector(to_unsigned(2, N)) after 16 ms,
                    std_logic_vector(to_unsigned(3, N)) after 24 ms,
                    std_logic_vector(to_unsigned(4, N)) after 32 ms,
                    std_logic_vector(to_unsigned(5, N)) after 40 ms,
                    std_logic_vector(to_unsigned(6, N)) after 48 ms,
                    std_logic_vector(to_unsigned(7, N)) after 56 ms;
end architecture;
