library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    generic(
        MAX_VALUE: natural := 10
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        enabled: in std_logic;
        ready: out std_logic;
        value: out natural
    );
end counter;

architecture behavioral of counter is
    signal value_internal: natural;
begin
    CLOCK_LOGIC: process(clk, enabled) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ready <= '0';
                value_internal <= 0;
            else
                if value_internal = MAX_VALUE then
                    ready <= '1';
                else
                    ready <= '0';
                end if;
                if enabled = '1' and value_internal < MAX_VALUE then
                    value_internal <= value_internal + 1;
                end if;
            end if;
        end if;
    end process;
    
    value <= value_internal;
end behavioral;
