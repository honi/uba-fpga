library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio_codec_config is
    generic(
        MASTER_CLK: natural := 125_000_000;
        CAPACITOR_DELAY: natural := 1250000000
    );
    port(
        clk: in std_logic;
        rst: in std_logic;
        scl: inout std_logic;
        sda: inout std_logic;
        ready: out std_logic;
        error: buffer std_logic
    );
end audio_codec_config;

architecture behavioral of audio_codec_config is
    -- I2C master constants.
    constant I2C_WRITE: std_logic := '0';
    constant I2C_READ:  std_logic := '1';
    
    -- Audio codec device address (SSM2603).
    constant AC_DEVICE_ADDR: std_logic_vector(6 downto 0) := "0011010";
    
    -- Audio codec registers.
    constant AC_R0_L_ADC_VOL:        std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(0, 7));
    constant AC_R1_R_ADC_VOL:        std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(1, 7));
    constant AC_R2_L_DAC_VOL:        std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(2, 7));
    constant AC_R3_R_DAC_VOL:        std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(3, 7));
    constant AC_R4_ANALOG_PATH:      std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(4, 7));
    constant AC_R5_DIGITAL_PATH:     std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(5, 7));
    constant AC_R6_PWR_MGMT:         std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(6, 7));
    constant AC_R7_DIGITAL_AUDIO_IF: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(7, 7));
    constant AC_R8_SAMPLE_RATE:      std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(8, 7));
    constant AC_R9_ACTIVE:           std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(9, 7));
    constant AC_R15_RESET:           std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(15, 7));
    constant AC_R16_ALC_CTRL_1:      std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16, 7));
    constant AC_R17_ALC_CTRL_2:      std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(17, 7));
    constant AC_R18_NOISE_GATE:      std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(18, 7));
    
    -- Audio codec bits.
    constant PWR_CHIP:    integer := 7;
    constant PWR_CLK_OUT: integer := 6;
    constant PWR_OSC:     integer := 5;
    constant PWR_OUT:     integer := 4;
    constant PWR_DAC:     integer := 3;
    constant PWR_ADC:     integer := 2;
    constant PWR_MIC:     integer := 1;
    constant PWR_LINE_IN: integer := 0;
    constant ACTIVE:      integer := 0;
    
    -- Total number of audio codec register writes.
    constant CONFIG_COUNT: integer := 11 * 2;

    -- Which index correspondes to setting the active bit.
    constant ACTIVE_BYTE_INDEX: integer := 18;

    -- Config sequence to configui2c_enabledre audio codec.
    type i2c_data_array is array (integer range <>) of std_logic_vector(7 downto 0);
    signal I2C_DATA: i2c_data_array(0 to CONFIG_COUNT) := (
--        AC_R15_RESET & '0',
--        "00000000",

        AC_R6_PWR_MGMT & '0',
        (   -- Power management bits are active low.
            PWR_CHIP => '0',
            PWR_CLK_OUT => '0',
            PWR_OSC => '1',
            PWR_OUT => '1',
            PWR_DAC => '0',
            PWR_ADC => '0',
            PWR_MIC => '1',
            PWR_LINE_IN => '0'
        ),

        AC_R0_L_ADC_VOL & '0',
        "00010111",

        AC_R1_R_ADC_VOL & '0',
        "00010111",

        AC_R2_L_DAC_VOL & '0',
        "01111001",

        AC_R3_R_DAC_VOL & '0',
        "01111001",

        AC_R4_ANALOG_PATH & '0',
        -- D7:D6             D5          D4     D3     D2    D1      D0
        -- SIDETONE_ATT[1:0] SIDETONE_EN DACSEL Bypass INSEL MUTEMIC MICBOOST
        "00001010",

        AC_R5_DIGITAL_PATH & '0',
        "00000000",

        AC_R7_DIGITAL_AUDIO_IF & '0',
        "00001010", -- 24 bits words, I2S input

        AC_R8_SAMPLE_RATE & '0',
        "00000000",

        AC_R9_ACTIVE & '0',
        (ACTIVE => '0', others => '0'),
        
        AC_R6_PWR_MGMT & '0',
        (   -- Power management bits are active low.
            PWR_CHIP => '0',
            PWR_CLK_OUT => '0',
            PWR_OSC => '1',
            PWR_OUT => '0',
            PWR_DAC => '0',
            PWR_ADC => '0',
            PWR_MIC => '1',
            PWR_LINE_IN => '0'
        ),
        
        -- Terminal value - not used.
        "00000000"
    );
    
    -- Internal signals for I2C master.
    signal i2c_enabled: std_logic;
    signal i2c_addr:    std_logic_vector(6 downto 0);
    signal i2c_data_wr: std_logic_vector(7 downto 0);
    signal i2c_data_rd: std_logic_vector(7 downto 0);
    signal i2c_rw:      std_logic;
    signal i2c_busy:    std_logic;

    -- Counter signals.
    signal config_counter_enabled: std_logic;
    signal config_counter_ready: std_logic;
    signal config_counter_value: natural;
    signal capacitor_counter_enabled: std_logic;
    signal capacitor_counter_ready: std_logic;
    
    -- State machine.
    type state_t is (
        IDLE,
        WAIT_FOR_I2C_INIT,
        SEND_BYTE,
        TX_IN_PROGRESS,
        WAIT_FOR_ACK,
        WAIT_FOR_CAPACITOR, -- VMID decoupling capacitor
        FINISHED
    );
    signal state:      state_t;
    signal next_state: state_t;
begin
    -- Generates I2C bit stream to configure audio codec.
    i2c_master: entity work.i2c_master
        generic map(
            input_clk => MASTER_CLK,
            bus_clk => 100_000
        )
        port map(
            clk       => clk,
            reset_n   => not rst, -- Active low
            ena       => i2c_enabled and not config_counter_ready,
            addr      => i2c_addr,
            data_wr   => i2c_data_wr,
            data_rd   => i2c_data_rd,
            rw        => i2c_rw,
            busy      => i2c_busy,
            scl       => scl,
            sda       => sda,
            ack_error => error
        );

    -- Tracks next config byte index to send through I2C.
    config_counter: entity work.counter
        generic map(
            MAX_VALUE => CONFIG_COUNT
        )
        port map(
            clk     => clk,
            rst     => rst,
            enabled => config_counter_enabled,
            ready   => config_counter_ready,
            value   => config_counter_value
        );

    -- Tracks delay required by audio codec to charge a capacitor before activating the output.
    capacitor_counter: entity work.counter
        generic map(
            MAX_VALUE => CAPACITOR_DELAY
        )
        port map(
            clk     => clk,
            rst     => rst,
            enabled => capacitor_counter_enabled,
            ready   => capacitor_counter_ready,
            value   => open -- We just want to wait for the ready signal.
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
    
    NEXT_STATE_LOGIC: process(
        state,
        i2c_busy,
        config_counter_ready,
        config_counter_value,
        capacitor_counter_ready
    ) is
    begin
        next_state <= state;
        case state is
            when IDLE =>
                next_state <= WAIT_FOR_I2C_INIT;

            when WAIT_FOR_I2C_INIT =>
                if i2c_busy = '0' then
                    next_state <= SEND_BYTE;
                end if;

            when SEND_BYTE =>
                if i2c_busy = '1' then
                    next_state <= TX_IN_PROGRESS;
                end if;

            when TX_IN_PROGRESS =>
                next_state <= WAIT_FOR_ACK;

            when WAIT_FOR_ACK =>
                if i2c_busy = '0' then
                    if config_counter_ready = '1' then
                        next_state <= FINISHED;
                    elsif config_counter_value = ACTIVE_BYTE_INDEX then
                        next_state <= WAIT_FOR_CAPACITOR;
                    else
                        next_state <= SEND_BYTE;
                    end if;
                end if;

            when WAIT_FOR_CAPACITOR =>
                if capacitor_counter_ready = '1' then
                    next_state <= SEND_BYTE;
                end if;

            when FINISHED =>
                -- Terminal state.
        end case;
    end process;
    
    OUTPUT_LOGIC: process(state) is
    begin
        -- Defaults.
        ready <= '0';
        i2c_enabled <= '0';
        config_counter_enabled <= '0';
        capacitor_counter_enabled <= '0';
        
        -- We're always writing to the same slave device.
        i2c_addr <= AC_DEVICE_ADDR;
        i2c_rw <= I2C_WRITE;
        
        case state is
            when IDLE =>
                -- Defaults are ok.

            when WAIT_FOR_I2C_INIT =>
                -- Waiting...

            when SEND_BYTE =>
                i2c_enabled <= '1';
                
            when TX_IN_PROGRESS =>
                -- We are in this state for only 1 clock.
                -- Increment config byte index now since I2C has already latched in the byte to send.
                i2c_enabled <= '1';
                config_counter_enabled <= '1';

            when WAIT_FOR_ACK =>
                i2c_enabled <= '1';

            when WAIT_FOR_CAPACITOR =>
                capacitor_counter_enabled <= '1';

            when FINISHED =>
                ready <= '1';
        end case;
    end process;
    
    -- Connect internal signals.
    i2c_data_wr <= I2C_DATA(config_counter_value);
end behavioral;
