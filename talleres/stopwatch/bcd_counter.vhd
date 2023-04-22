library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter is
    port(
        clk_i : in std_logic;
        run_i : in std_logic;
        reset_i : in std_logic;
        count_o : out std_logic_vector(3 downto 0);
        max_o : out std_logic
    );
end entity;

architecture logic of bcd_counter is
    signal max : std_logic := '0';
    signal counter : unsigned(3 downto 0) := (others => '0');
    signal next_counter : unsigned(3 downto 0) := (others => '0');
begin
    increment_counter : process(clk_i)
    begin
        if rising_edge(clk_i) then
            if (run_i = '1') then
                counter <= next_counter;
            elsif (reset_i = '1') then
                counter <= (others => '0');
            end if;
        end if;
    end process;

    next_counter <= counter + 1 when counter < 9 else (others => '0');

    max_o <= '1' when counter = 9 else '0';
    count_o <= std_logic_vector(counter);
end architecture;
