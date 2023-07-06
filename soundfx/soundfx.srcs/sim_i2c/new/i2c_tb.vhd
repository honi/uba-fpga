library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_tb is
end i2c_tb;

architecture behavioral of i2c_tb is
    constant clk_period: time := 8 ns; -- 125 MHz
    signal sysclk: std_logic := '0';
    signal rst: std_logic := '1';
    signal clk_12_288: std_logic;
begin
    clk_process: process
    begin
        sysclk <= '1';
        wait for clk_period / 2;
        sysclk <= '0';
        wait for clk_period / 2;
    end process;
    
    audio_codec_config: entity work.audio_codec_config
        port map(
            clk => sysclk,
            rst => rst
        );
        
    x: entity work.clk_wiz_0
        port map(
            sysclk => sysclk,
            clk_12_288 => clk_12_288,
            reset => rst
        );
    
    rst <= '1', '0' after clk_period;
end behavioral;
