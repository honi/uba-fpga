library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_test is
    port(
        sysclk: in std_logic;
        btn: in std_logic_vector(1 downto 0);
        led: out std_logic_vector(3 downto 0);
        ac_muten: out std_logic;
        ac_mclk: out std_logic;
        ac_bclk: out std_logic;
        ac_pblrc: out std_logic;
        ac_reclrc: out std_logic;
        ac_scl: inout std_logic;
        ac_sda: inout std_logic
    );
end i2c_test;

architecture behavioral of i2c_test is
    signal clk_12_288: std_logic;
    signal clk_6_144: std_logic;
    signal clk_locked: std_logic;
begin
    audio_codec_config: entity work.audio_codec_config
        port map(
            clk => sysclk,
            rst => not clk_locked or btn(0),
            ready => led(1),
            scl => ac_scl,
            sda => ac_sda,
            error => led(2)
        );

    clk_wiz_0: entity work.clk_wiz_0
        port map(
            clk_in1 => sysclk,
            clk_out1 => clk_12_288,
            clk_out2 => clk_6_144,
            reset => btn(0),
            locked => clk_locked
        );

    ac_mclk <= clk_12_288; -- audio codec master clock
    ac_bclk <= clk_6_144;
    ac_muten <= '1'; -- unmute (active low)
    
    led(0) <= clk_locked;
    led(3) <= btn(0);
end behavioral;

