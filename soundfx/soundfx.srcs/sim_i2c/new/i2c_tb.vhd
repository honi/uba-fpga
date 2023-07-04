library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_tb is
end i2c_tb;

architecture behavioral of i2c_tb is
    constant clk_period: time := 8 ns; -- 125 MHz
    signal clk: std_logic := '0';
    signal rst: std_logic := '1';
begin
    clk_process: process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;
    
    audio_codec_config: entity work.audio_codec_config
        port map(
            clk => clk,
            rst => rst
        );
        
    stimulus: process
    begin
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period * 100;
    end process;
    
end behavioral;
