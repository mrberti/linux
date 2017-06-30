----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2017 13:52:29
-- Design Name: 
-- Module Name: clk_div - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div is
    GENERIC (
        F_clk_in : integer := 50000000;
        F_clk_out : integer := 25000000;
        N_counter_bitsize : integer := 32
    );
    PORT ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end clk_div;

architecture Behavioral of clk_div is

    constant N_div : integer := F_clk_in / F_clk_out;
    
    signal CLK_COUNT : unsigned( N_counter_bitsize - 1 downto 0) := (OTHERS => '0');

begin

    counting : process (clk, reset)
    begin
        if (reset = '1') then
            --clk_out <= '0';
            CLK_COUNT <= (OTHERS => '0');        
        elsif (clk'event and clk = '1') then
            if clk_count < N_div - 1 then
                clk_count <= clk_count + 1;
            else
                clk_count <= (OTHERS => '0');
            end if;
        end if;
    end process;
    
    clk_out_process : process (clk, reset)
    begin
        if reset = '1' then
            clk_out <= '1';
        elsif clk'event and clk = '1' then
            if (CLK_COUNT = N_div/2-1) then
                clk_out <= '1';
            elsif (CLK_COUNT = N_DIV-1) then
                clk_out <= '0';
            end if;
        end if;
    end process; 

end Behavioral;
