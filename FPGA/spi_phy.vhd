----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2017 21:17:07
-- Design Name: 
-- Module Name: spi_phy - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity spi_master_phy is
    generic ( 
        N_slaves    : natural := 1;
        F_clk_in    : natural := 100;
        F_clk_out   : natural :=  1;
        N_data_bits : natural range 1 to 10 := 8
    );
    port ( 
        -- GENERAL SIGNALS
        clk : in std_logic := '0';
        reset : in std_logic := '0';
        
        -- SPI MASTER CONTROL SIGNALS
        kickout : in std_logic := '0'; -- Latches in data input signals and begins SPI transmit, active high

        cpol  : in std_logic := '1'; -- 1 => idle high
        cpha  : in std_logic := '1'; -- 1 => sample on second flank after cs low
        slave_addr : in std_logic_vector ( N_slaves - 1 downto 0 ) := (others => '0');

        data_tx : in std_logic_vector (N_data_bits-1 downto 0) := (others => '0');
        data_rx : out std_logic_vector (N_data_bits-1 downto 0) := (others => '0');
       
        -- STATUS OUTPUT SIGNALS
        rx_valid : out std_logic := '0';
        busy : out std_logic := '0';
       
        -- SPI PINS
        sck : out std_logic := '0';
        cs : out std_logic_vector (N_slaves-1 downto 0) := (others => '1');
        mosi : out std_logic := 'Z';
        miso : in std_logic := 'Z'
     );
            
end spi_master_phy;

architecture rtl of spi_master_phy is

    type spi_state_type IS (SPI_IDLE, SPI_TRANSCEIVING, SPI_FINISH);

    constant N_clk_div : integer := F_clk_in / F_clk_out;
    
    signal clk_counter : integer range 0 to N_clk_div - 1 := 0;
    signal bit_counter : natural range 0 to N_data_bits := N_data_bits - 1;
    
    signal spi_state : spi_state_type := SPI_IDLE;
    
    signal flank_1, flank_2 : std_logic := '0';
    signal do_sample : std_logic := '0';
    
    -- latches
    signal cpol_d : std_logic := cpol;
    signal cpha_d : std_logic := cpha;
    signal kickout_d : std_logic := '0';
    signal miso_d : std_logic := '0';
    signal data_rx_d : std_logic_vector( N_data_bits-1 downto 0 ) := (others => '0');
    signal data_tx_d : std_logic_vector( N_data_bits-1 downto 0 ) := (others => '0');
    signal address_d : std_logic_vector( N_slaves-1 downto 0 )    := (others => '0');
    
       
begin

    clock_divider : process( clk )
    begin
        if rising_edge(clk) then
            if spi_state = SPI_TRANSCEIVING then
                if clk_counter = N_clk_div/2-1 then
                    clk_counter <= clk_counter + 1;
                    flank_1 <= '1';
                    flank_2 <= '0';
                elsif clk_counter = N_clk_div-1 then
                    clk_counter <= 0;
                    flank_1 <= '0';
                    flank_2 <= '1';
                else
                    clk_counter <= clk_counter + 1;
                    flank_1 <= '0';
                    flank_2 <= '0';
                end if;
             else
                clk_counter <= 0;
                flank_1 <= '0';
                flank_2 <= '0';
             end if;
        end if;
    end process;

    spi_state_machine : process (clk)
        variable v : std_logic := '0';
    begin
        if rising_edge(clk) then
        
            --sampling miso
            miso_d <= miso;
            kickout_d <= kickout;
        
            case spi_state is 
                when SPI_IDLE =>
                    busy <= '0';
                    mosi <= 'Z';
                    cs <= (OTHERS => '1');
                    sck <= cpol_d;
                    -- while idling, constantly latch in data
                    cpol_d <= cpol;
                    cpha_d <= cpha;
                    
                    data_tx_d <= data_tx;                    
                    address_d <= slave_addr;
                    
                    if cpha_d = '1' then
                        bit_counter <= N_data_bits;
                    else
                        bit_counter <= N_data_bits-1;
                    end if;
                    
                    -- listen for kickout and advance state
                    if kickout_d = '1' then
                        spi_state <= SPI_TRANSCEIVING;    
                    end if;
                    
                when SPI_TRANSCEIVING =>
                    -- set signals
                    busy <= '1';
                    rx_valid <= '0';
                    cs(to_integer(unsigned(address_d))) <= '0';
                    
                    mosi <= data_tx_d( data_rx_d'length-1 ); -- MSB out first
                    
                    if flank_1 = '1' or flank_2 = '1' then
                        sck <= (not cpol_d and flank_1) xor (cpol_d and flank_2);
                        
                        if (flank_1 = '1' and cpha_d = '1') or (flank_2 = '1' and cpha_d = '0') then
                            bit_counter <= bit_counter - 1;
                            if bit_counter > 0 then
                                if bit_counter < N_data_bits then
                                    data_tx_d <= data_tx_d( data_tx_d'length - 2 downto 0 ) & '0';
                                end if;
                            else
                                sck <= cpol_d;
                                spi_state <= SPI_FINISH;
                            end if;
                        elsif (flank_1 = '1' and cpha_d = '0') or (flank_2 = '1' and cpha_d = '1') then
                            data_rx_d <= data_rx_d(data_rx_d'length-2 downto 0) & miso_d;
                        end if;
                    end if;
                    
                when SPI_FINISH =>
                    -- write data to output
                    data_rx <= data_rx_d;
                    rx_valid <= '1';
                 
                    if kickout_d = '1' then
                        -- continue sending but latch in tx_data before
                        data_tx_d <= data_tx;
                        spi_state <= SPI_TRANSCEIVING;
                        if cpha_d = '1' then
                            bit_counter <= N_data_bits;
                        else
                            bit_counter <= N_data_bits-1;
                        end if;
                    else 
                        -- Finished sending, so go back to idling mode
                        spi_state <= SPI_IDLE;
                    end if;
                when others =>
                    -- should not appear, do nothing
            end case;
        end if;
    end process;    

end rtl;
