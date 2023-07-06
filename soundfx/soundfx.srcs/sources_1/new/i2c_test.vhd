library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_test is
    port(
        sysclk: in std_logic;
        btn: in std_logic_vector(0 downto 0);
        led: out std_logic_vector(2 downto 0);
        ac_mclk: out std_logic;
        ac_muten: out std_logic;
        ac_scl: inout std_logic;
        ac_sda: inout std_logic
    );
end i2c_test;

architecture behavioral of i2c_test is
    signal clk_12_288: std_logic;
begin
    audio_codec_config: entity work.audio_codec_config
        port map(
            clk => sysclk,
            rst => btn(0),
            scl => ac_scl,
            sda => ac_sda
        );

    x: entity work.clk_wiz_0
        port map(
            sysclk => sysclk,
            clk_12_288 => clk_12_288,
            reset => btn(0)
        );

    ac_mclk <= clk_12_288; -- audio codec master clock
    ac_muten <= '1'; -- unmute
    
    led(0) <= ac_scl;
    led(1) <= ac_sda;
    led(2) <= btn(0);
end behavioral;

