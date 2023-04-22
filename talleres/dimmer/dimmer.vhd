library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dimmer is
    generic(N : natural := 3);
    port(
        clk_i : in std_logic;
        duty_cycle_i : in std_logic_vector(N-1 downto 0);
        led_o : out std_logic
    );
end entity;

architecture logic of dimmer is
    signal counter : unsigned(N-1 downto 0) := (others => '0');
    signal max_counter : std_logic_vector(N-1 downto 0) := (others => '1');
begin
    increment_counter : process(clk_i)
    begin
        if rising_edge(clk_i) then
            counter <= counter + 1;
        end if;
    end process;

    led_o <= '1' when (
        (duty_cycle_i = max_counter)
        or
        (counter < unsigned(duty_cycle_i))
    ) else '0';
end architecture;
