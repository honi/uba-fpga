library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio_codec_config is
    port(
        clk: in std_logic;
        rst: in std_logic
    );
end audio_codec_config;

architecture behavioral of audio_codec_config is
    -- I2C-Core register addresses
    constant I2C_REG_PRERlo: std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(0, 3)); -- Prescale low
    constant I2C_REG_PRERhi: std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(1, 3)); -- Prescale high
    constant I2C_REG_CTR:    std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(2, 3)); -- Control
    constant I2C_REG_TXR:    std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(3, 3)); -- Transmit
    constant I2C_REG_RXR:    std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(3, 3)); -- Receive
    constant I2C_REG_CR:     std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(4, 3)); -- Command
    constant I2C_REG_SR:     std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(4, 3)); -- Status
    
    -- I2C-Core clock prescale
    -- 125 MHz / 5 * 100 KHz - 1 = 249
    constant I2C_CLK_PRESCALE_LO: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(249, 8));
    constant I2C_CLK_PRESCALE_HI: std_logic_vector(7 downto 0) := (others => '0');
    
    -- Audio codec device address (SSM2603)
    constant AUDIO_CODEC_DEVICE_ADDR: std_logic_vector(7 downto 0) := "00110100";
    
    -- Audio codec registers
    constant AUDIO_CODEC_REG_PWR_MGMT: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(6, 8));
    
    signal wb_addr: std_logic_vector(2 downto 0) := (others => '0');
    signal wb_data: std_logic_vector(7 downto 0) := (others => '0');

    constant CONFIG_COUNT: integer := 9;

    type i2c_reg_array is array (integer range <>) of std_logic_vector(2 downto 0);
    type i2c_data_array is array (integer range <>) of std_logic_vector(7 downto 0);
    
    signal i2c_config_addr: i2c_reg_array(0 to CONFIG_COUNT-1) := (
        I2C_REG_PRERlo,
        I2C_REG_PRERhi,
        I2C_REG_CTR,
        I2C_REG_TXR,
        I2C_REG_CR,
        I2C_REG_TXR,
        I2C_REG_CR,
        I2C_REG_TXR,
        I2C_REG_CR
    );
    
    signal i2c_config_data: i2c_data_array(0 to CONFIG_COUNT-1) := (
        I2C_CLK_PRESCALE_LO,
        I2C_CLK_PRESCALE_HI,
        "10000000", -- I2C core enabled
        AUDIO_CODEC_DEVICE_ADDR and "11111110", -- LSB == 0 -> writing to slave
        "10010000", -- STA, WR
        AUDIO_CODEC_REG_PWR_MGMT,
        "00010000", -- WR
        "00001111", -- chip power up, out power up
        "10010000" -- STO, WR
    );

    type state_t is (IDLE, SEND, WAIT_ACK, FINISHED);
    signal state: state_t;
    signal next_state: state_t;
    signal config_index: integer;
    signal wb_stb: std_logic;
    signal wb_cyc: std_logic;
    signal wb_ack: std_logic;
begin
    i2c_master: entity work.i2c_master_top
        port map(
            wb_clk_i => clk,
            wb_rst_i => rst,
            arst_i => '1',
            wb_adr_i => wb_addr,
            wb_dat_i => wb_data,
            wb_dat_o => open,
            wb_we_i => '1',
            wb_stb_i => wb_stb,
            wb_cyc_i => wb_cyc,
            wb_ack_o => wb_ack,
            scl_pad_i => '0',
            scl_pad_o => open,
            scl_padoen_o => open,
            sda_pad_i => '0',
            sda_pad_o => open,
            sda_padoen_o => open
        );
        
--    scl <= scl_pad_o when (scl_padoen_oe = '0') else 'Z';
--    sda <= sda_pad_o when (sda_padoen_oe = '0') else 'Z';
--    scl_pad_i <= scl;
--    scl_pad_i <= sda;
        
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
    
    NEXT_STATE_LOGIC: process(state, config_index) is
    begin
        next_state <= state;
        case state is
            when IDLE =>
                next_state <= SEND;
            when SEND =>
                next_state <= WAIT_ACK;
            when WAIT_ACK =>
                if wb_ack = '1' then
                    next_state <= SEND when config_index < CONFIG_COUNT else FINISHED;
                end if;
            when FINISHED =>
        end case;
    end process;
    
    STATE_LOGIC: process(state) is
    begin
        wb_cyc <= '0';
        wb_stb <= '0';
        case state is
            when IDLE =>
                config_index <= 0;
            when SEND =>
                wb_cyc <= '1';
                wb_stb <= '1';
                wb_addr <= i2c_config_addr(config_index);
                wb_data <= i2c_config_data(config_index);
            when WAIT_ACK =>
                config_index <= config_index + 1;
            when FINISHED =>
        end case;
    end process;
end behavioral;

