library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_dimmer is
    port(
        clk_i : in std_logic;
        duty_cycle_i : in std_logic_vector(3 downto 0);
        led_o : out std_logic
    );
end entity;

architecture logic of bcd_dimmer is
    signal count : std_logic_vector(3 downto 0) := (others => '0');
begin
    bcd_counter : entity work.bcd_counter
        port map(
            clk_i => clk_i,
            run_i => '1',
            reset_i => '0',
            count_o => count,
            max_o => open
        );

    led_o <= '1' when (
        -- (unsigned(count) < unsigned(duty_cycle_i))
        (count < duty_cycle_i)
        or
        (duty_cycle_i = "1001")
    ) else '0';
end architecture;
