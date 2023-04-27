library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stopwatch_pkg.all;

entity stopwatch_tb is
end entity;

architecture behavior of stopwatch_tb is
    constant sysclk_period : time := 8 ns; -- 125MHz
    signal sysclk : std_logic := '1';

    signal run : std_logic := '1';
    signal reset : std_logic := '0';
begin
    sysclk_process : process
    begin
        sysclk <= '1';
        wait for sysclk_period / 2;
        sysclk <= '0';
        wait for sysclk_period / 2;
    end process;

    stopwatch_top : entity work.stopwatch_top
        port map(
            sysclk => sysclk,
            run_i => '1',
            reset_i => '0'
        );
end architecture;
