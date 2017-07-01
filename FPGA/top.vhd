----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2017 15:08:11
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port (
        clk : in STD_LOGIC;
        -- switches
        sw : in STD_LOGIC_VECTOR( 15 downto 0 );
        -- buttons
        btnC : in STD_LOGIC;
        btnU : in STD_LOGIC;
        btnL : in STD_LOGIC;
        btnR : in STD_LOGIC;
        btnD : in STD_LOGIC;
        
        -- PMOD OLEDrgb
        CS, MOSI, SCK, D_C, RES, VCCEN, PMODEN : out STD_LOGIC;        
        
        -- LEDS
        led : out STD_LOGIC_VECTOR( 15 downto 0 );
        --7 Segment
        seg : out STD_LOGIC_VECTOR( 6 downto 0 );
        dp : out STD_LOGIC;
        an : out STD_LOGIC_VECTOR( 3 downto 0 )
        );
end top;

architecture Behavioral of top is

    ---
    -- mapping of external periphery to signals
    ---
    
    -- switches
    alias number : std_logic_vector (7 downto 0) is sw(15 downto 8);
    alias segment_drive : STD_LOGIC_VECTOR(6 downto 0) is seg;
    alias sw_an : std_logic_vector ( 3 downto 0 ) is sw(7 downto 4);
    alias sw_dp : std_logic is sw(3);
    alias enable_7 : STD_LOGIC is sw(1);
    alias drive_high : std_logic is sw(0);
    
    -- buttons
    alias reset : STD_LOGIC is btnC;
    
    -- LEDs
    alias led_blinky : STD_LOGIC is led(0);
    
    ----------------------------------------------------------
    -- SIGNAL DECLARATIONS
    ----------------------------------------------------------
    signal number1, number2, number3, number4 : std_logic_vector(7 downto 0);
    signal dp1, dp2, dp3, dp4 : STD_LOGIC;

    ----------------------------------------------------------
    -- COMPONENT DESCRIPTIONS
    ----------------------------------------------------------
    component clk_div 
    GENERIC (
        F_clk_in : integer := 100000000;
        F_clk_out : integer := 1;
        N_counter_bitsize : integer := 32
    );
    PORT ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC
    );
    end component;
    
    component seven_seg_4
    Generic (
        F_clk : integer := 100000000; -- Hz
        F_cycle : integer := 10000000 -- Hz
    );
    Port ( 
        clk : in std_logic;
        enable : in std_logic;
        reset : in std_logic;
        
        drive_high : in std_logic;
        
        number1 : in std_logic_vector(7 downto 0);
        number2 : in std_logic_vector(7 downto 0);
        number3 : in std_logic_vector(7 downto 0);
        number4 : in std_logic_vector(7 downto 0);
        
        dp1 : in std_logic;
        dp2 : in std_logic;
        dp3 : in std_logic;
        dp4 : in std_logic;     
        
        segment_drive : out std_logic_vector (6 downto 0);
        dp_drive : out std_logic;
        
        -- an_drive will be used to multiplex the segments, only one bit may be active!
        an_drive : out std_logic_vector(3 downto 0)
       );
    end component;
    
    component spi_phy
        Generic ( 
                N_slaves : natural := 1;
                F_clk_in : natural := 100;
                F_clk_out : natural := 25
                );
        Port ( 
                -- GENERAL SIGNALS
                clk_in : in STD_LOGIC;
                reset : in STD_LOGIC := '0';
                
                -- SPI MASTER CONTROL SIGNALS
                kickout : in STD_LOGIC := '0'; -- Lathes in data input signals and begins SPI transmit, active high
                                       
                -- DATA INPUT SIGNALS
                data_send : in STD_LOGIC_VECTOR (7 downto 0);
                slave_addr : in STD_LOGIC_VECTOR ( N_slaves - 1 downto 0 ) := (OTHERS => '0');
               
                -- DATA OUTPUT SIGNALS
                data_rec : out STD_LOGIC_VECTOR (7 downto 0);
               
                -- STATUS OUTPUT SIGNALS
                data_rec_valid : out STD_LOGIC;
                busy : out STD_LOGIC;
               
                -- SPI PINS
                clk_out : out STD_LOGIC;
                cs : out STD_LOGIC_VECTOR (N_slaves-1 downto 0);
                mosi : out STD_LOGIC;
                miso : in STD_LOGIC := '1'
             );
    end component;

begin
    
    ----------------------------------------------------------
    -- COMPONENT INSTATIONATIONS
    ----------------------------------------------------------
    blinky : clk_div
    generic map (
        F_clk_in => 100000000,
        F_clk_out => 1
    )
    port map (
        clk => clk,
        reset => reset,
        clk_out => led_blinky
    );
    
    seven_segment : seven_seg_4
    generic map(
        F_cycle => 60*4
    )
    port map (
        clk => clk,
        reset => reset,
        enable => enable_7,
        
        number1 => number1,
        number2 => number2,
        number3 => number3,
        number4 => number4,
        
        dp1 => dp1,
        dp2 => dp2,
        dp3 => dp3,
        dp4 => dp4,
        
        drive_high => drive_high,
        segment_drive => segment_drive,
        dp_drive => dp,
        
        an_drive => an
    );
    
    spi_PMOD_oled : spi_phy
    GENERIC MAP(
        N_slaves => 1,
        F_clk_in => 100,
        F_clk_out => 1
    )
    PORT MAP(
        clk_in  => clk,
        reset  => reset,
        kickout  => btnR,
        data_send  => sw(15 downto 8),
        slave_addr  => (OTHERS => '0'),
        --data_rec  => data_rec,
        --data_rec_valid  => data_rec_valid,
        --busy  => busy,
        clk_out  => SCK,
        cs(0)  => CS, --, OTHERS => '0'),
        mosi  => MOSI,
        miso =>  '1'
    );
    
    ----------------------------------------------------------
    -- BEHAVIOUR CODE
    ----------------------------------------------------------
    
    D_C <= sw(3);
    VCCEN <= sw(4);
    PMODEN <= sw(5);
    RES <= btnL;
    
    
    number1(7 downto 4) <= "0000";
    number1(3 downto 0) <= sw(15 downto 12);
    number2(7 downto 4) <= "0000";
    number2(3 downto 0) <= sw(11 downto 8);
    number3 <= x"FF";
    number4 <= x"FF";
    
    dp1 <= '0';
    dp2 <= '1';
    dp3 <= '0';
    dp4 <= '0';    
    
end Behavioral;
