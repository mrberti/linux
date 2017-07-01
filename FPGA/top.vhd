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
    
    component seven_seg
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable : in STD_LOGIC;
        number : in STD_LOGIC_VECTOR (7 downto 0);
        dp : in STD_LOGIC;
        drive_high : in std_logic;
           
        -- output signals to drive the 7 segment display
        -- MSB := A
        segment_drive : out STD_LOGIC_VECTOR (6 downto 0);
        dp_drive : out STD_LOGIC
     );
    end component;

begin
    
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
    
    seven_segment1 : seven_seg
    port map (
        clk => clk,
        reset => reset,
        enable => enable_7,
        drive_high => drive_high,
        number => number,
        dp => sw_dp,
        segment_drive => segment_drive,
        dp_drive => dp
    );
    
    an <= sw_an;
    
end Behavioral;
