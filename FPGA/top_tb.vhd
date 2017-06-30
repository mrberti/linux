----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2017 15:12:18
-- Design Name: 
-- Module Name: top_tb - Behavioral
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

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

    component top 
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        led_status : out STD_LOGIC
        );
    end component;
    
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal led_status : std_logic;

begin
    
    top_DUT : top
    port map(
        clk => clk,
        reset => reset,
        led_status => led_status
    );
    
    clk <= not clk after 10 ns;
    
    stimulus : process
    begin
        reset <= '1';
        wait for 35 ns;
        reset <= '0';
        wait;
    end process;


end Behavioral;
