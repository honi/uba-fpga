library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sawtooth is
    port(
        clk:    in std_logic;
        data_o: out std_logic_vector(7 downto 0)
    );
end sawtooth;

architecture behavioral of sawtooth is
    signal value: unsigned(7 downto 0) := to_unsigned(0, 8);
begin
    clk_process: process(clk)
    begin
        if rising_edge(clk) then
            value <= value + 1;
        end if;
    end process;
    
    data_o <= std_logic_vector(value);
end behavioral;
