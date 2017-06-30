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
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           led_status : out STD_LOGIC);
end top;

architecture Behavioral of top is

    component clk_div 
    GENERIC (
        F_clk_in : integer := 50000000;
        F_clk_out : integer := 10;
        N_counter_bitsize : integer := 32
    );
    PORT ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC
    );
    end component;

begin
    
    blinky : clk_div
    generic map (
        F_clk_in => 50000000,
        F_clk_out => 5
    )
    port map (
        clk => clk,
        reset => reset,
        clk_out => led_status
    );
        


end Behavioral;
