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

    -- Esta señal se actualiza inmediatamente cuando cambia counter, pero nosotros
    -- solo la usamos en el flanco ascendente del clock.
    next_counter <= counter + 1 when counter < 9 else (others => '0');

    -- La señal counter se actualiza al valor next_counter únicamente en el flanco
    -- ascendente del clock. Cuando activamos la salida max_o porque counter vale 9,
    -- el flanco ascendente ya pasó, entonces el bcd_counter del siguiente dígito que
    -- está conectado a max_o recién va a observar ese 1 en el próximo clock,
    -- incrementando su counter interno al mismo tiempo que éste counter de acá se
    -- resetea a 0 (porque si counter = 9 entonces next_counter = 0).
    count_o <= std_logic_vector(counter);
    max_o <= '1' when counter = 9 else '0';
end architecture;
