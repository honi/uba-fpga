library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio_codec_config is
    port(
        clk: in std_logic;
        rst: in std_logic;
        scl: inout std_logic;
        sda: inout std_logic
    );
end audio_codec_config;

architecture behavioral of audio_codec_config is
    -- I2C master
    constant I2C_WRITE: std_logic := '0';
    constant I2C_READ:  std_logic := '1';
    
    -- Audio codec device address (SSM2603)
    constant AUDIO_CODEC_DEVICE_ADDR: std_logic_vector(6 downto 0) := "0011010";
    
    -- Audio codec registers
    constant AUDIO_CODEC_REG_PWR_MGMT: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(6, 8));
    
    constant CONFIG_COUNT: integer := 2;

    type i2c_data_array is array (integer range <>) of std_logic_vector(7 downto 0);
    
    signal I2C_DATA: i2c_data_array(0 to CONFIG_COUNT-1) := (
        AUDIO_CODEC_REG_PWR_MGMT,
        "00001111" -- chip power up, out power up
    );

    -- State machine
    type state_t is (IDLE, SEND, WAIT_ACK, FINISHED);
    signal state: state_t;
    signal next_state: state_t;
    signal config_index: integer;
    
    -- Internal signals
    signal enabled: std_logic;
    signal addr: std_logic_vector(6 downto 0);
    signal data_wr: std_logic_vector(7 downto 0);
    signal data_rd: std_logic_vector(7 downto 0);
    signal rw: std_logic;
    signal busy: std_logic;
begin
    i2c_master: entity work.i2c_master
        generic map(
            input_clk => 125_000_000,
            bus_clk => 100_000
        )
        port map(
            clk => clk,
            reset_n => not rst, -- active low
            ena => enabled,
            addr => addr,
            data_wr => data_wr,
            data_rd => data_rd,
            rw => rw,
            busy => busy,
            scl => scl,
            sda => sda
        );

    CLOCK_LOGIC: process(clk, rst) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= IDLE;
            else
                state <= next_state;
            end if;
        end if;    
    end process;
    
    NEXT_STATE_LOGIC: process(state, config_index, busy) is
    begin
        next_state <= state;
        case state is
            when IDLE =>
                next_state <= SEND;
            when SEND =>
                if busy = '1' then
                    next_state <= WAIT_ACK;
                end if;
            when WAIT_ACK =>
                if busy = '0' then
                    next_state <= SEND when config_index < CONFIG_COUNT else FINISHED;
                end if;
            when FINISHED =>
        end case;
    end process;
    
    STATE_LOGIC: process(state) is
    begin
        case state is
            when IDLE =>
                config_index <= 0;
                enabled <= '0';
            when SEND =>
                addr <= AUDIO_CODEC_DEVICE_ADDR;
                data_wr <= I2C_DATA(config_index);
                rw <= I2C_WRITE;
                enabled <= '1';
            when WAIT_ACK =>
                config_index <= config_index + 1;
            when FINISHED =>
                enabled <= '0';
        end case;
    end process;
end behavioral;

