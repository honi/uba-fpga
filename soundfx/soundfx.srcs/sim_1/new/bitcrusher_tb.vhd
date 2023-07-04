library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bitcrusher_tb is
end bitcrusher_tb;

architecture behavioral of bitcrusher_tb is
    constant clk_period: time := 1 ns;
    signal clk: std_logic := '0';
    signal data: std_logic_vector(7 downto 0) := (others => '0');
begin
    clk_process: process
    begin
        clk <= '1';
        wait for clk_period / 2;
        clk <= '0';
        wait for clk_period / 2;
    end process;
    
    sawtooth: entity work.sawtooth
        port map(
            clk => clk,
            data_o => data
        );   

    bitcrusher: entity work.bitcrusher
        port map(
            clk => clk,
            sample_rate => std_logic_vector(to_unsigned(37, 8)),
            resolution => std_logic_vector(to_unsigned(4, 4)),
            data_i => data,
            data_o => open
        );
        
--    data <= std_logic_vector(to_signed(0, 8)),
--            std_logic_vector(to_signed(1, 8)) after 4ns,
--            std_logic_vector(to_signed(2, 8)) after 12ns,
--            std_logic_vector(to_signed(3, 8)) after 20ns,
--            std_logic_vector(to_signed(4, 8)) after 28ns,
--            std_logic_vector(to_signed(5, 8)) after 36ns,
--            std_logic_vector(to_signed(6, 8)) after 44ns,
--            std_logic_vector(to_signed(7, 8)) after 52ns;
end behavioral;
