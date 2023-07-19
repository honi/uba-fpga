library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

    architecture behavioral of counter_tb is
    constant clk_period: time := 8 ns; -- 125 MHz
    signal sysclk: std_logic;
    signal rst: std_logic;
    signal enabled: std_logic;
begin
    clk_process: process
    begin
        sysclk <= '1';
        wait for clk_period / 2;
        sysclk <= '0';
        wait for clk_period / 2;
    end process;
    
    counter: entity work.counter
        generic map(
            MAX_VALUE => 10
        )
        port map(
            clk => sysclk,
            rst => rst,
            enabled => enabled
        );
    
    tb: process
    begin
        rst <= '1';
        enabled <= '1';
        wait for clk_period / 2;
        rst <= '0';
        wait for clk_period * 5;
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period * 5;
        enabled <= '0';
        wait for clk_period * 2;
        enabled <= '1';
        wait;
    end process;
end behavioral;
