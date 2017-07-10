----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2017 19:49:13
-- Design Name: 
-- Module Name: spi_phy_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_phy_tb is
--  Port ( );
end spi_phy_tb;

ARCHITECTURE Behavioral OF spi_phy_tb IS
    
    CONSTANT N_slaves_tb : natural := 2;
    
    SIGNAL clk_in : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL kickout : STD_LOGIC := '0'; -- Lathes dataput signals and begins SPI transmit, active high
    SIGNAL data_send : STD_LOGIC_VECTOR (7 downto 0); -- here we want MSB left like it is in usual case with data
    SIGNAL slave_addr : STD_LOGIC_VECTOR ( N_slaves_tb - 1 downto 0 ) := (OTHERS => '0');
    SIGNAL data_rec : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL data_rec_valid : STD_LOGIC;
    SIGNAL busy : STD_LOGIC;
    SIGNAL clk_out : STD_LOGIC;
    SIGNAL cs : STD_LOGIC_VECTOR (N_slaves_tb-1 downto 0);
    SIGNAL mosi : STD_LOGIC;
    SIGNAL miso : STD_LOGIC; 
    
    
BEGIN

spi_DUT : entity work.spi_master_phy
GENERIC MAP(
    N_slaves => N_slaves_tb,
    F_clk_in => 100,
    F_clk_out => 10
)
PORT MAP(
    clk  => clk_in,
    reset  => reset,
    kickout  => kickout,
    data_tx  => data_send,
    slave_addr  => slave_addr,
    data_rx  => data_rec,
    rx_valid  => data_rec_valid,
    busy  => busy,
    sck  => clk_out,
    cs  => cs,
    mosi  => mosi,
    miso =>  miso
);

clk_generator : PROCESS
BEGIN
    clk_in <= '0';
    WAIT FOR 5 ns;
    clk_in <= '1';
    WAIT FOR 5 ns;
END PROCESS;

stimulus_generator : PROCESS
BEGIN
    reset <= '0';
    data_send <= x"55";
    kickout <= '0';
    slave_addr <= "00";
    --miso <= '0';
    WAIT FOR 20 ns;
    reset <= '1';
    WAIT FOR 20 ns;
    reset <= '0';
    WAIT FOR 20 ns;
    kickout <= '1';
    WAIT FOR 20 ns;
    kickout <= '0';
    slave_addr <= "01";
    WAIT FOR 20 ns;
    data_send <= x"aa";
    WAIT FOR 2000 ns;
    kickout <= '1';
    WAIT FOR 100 ns;
    --slave_addr <= "10";
    WAIT FOR 1000 ns;
    kickout <= '0';

    -- endless wait...
    WAIT;
END PROCESS;

miso <= mosi;

END Behavioral;
