library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bitcrusher is
    port(
        clk:         in std_logic;
        sample_rate: in std_logic_vector(7 downto 0);
        resolution:  in std_logic_vector(3 downto 0);
        data_i:      in std_logic_vector(7 downto 0);
        data_o:      out std_logic_vector(7 downto 0)
    );
end bitcrusher;

architecture behavioral of bitcrusher is
    signal data: std_logic_vector(7 downto 0) := (others => '0');
    signal counter: unsigned(7 downto 0) := (others => '0');
    signal next_counter: unsigned(7 downto 0) := (others => '0');
begin
    next_counter <= counter + 1 when counter < unsigned(sample_rate) else (others => '0');

    clk_process: process(clk)
    begin
        if rising_edge(clk) then
            counter <= next_counter;
            if next_counter = to_unsigned(0, 8) then
                data <= std_logic_vector(shift_left(shift_right(signed(data_i), to_integer(8 - unsigned(resolution))), to_integer(8 - unsigned(resolution))));
            end if;
        end if;
    end process;
    
    data_o <= data;
end behavioral;
