----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2017 07:40:23
-- Design Name: 
-- Module Name: seven_seg_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_seg_tb is
--  Port ( );
end seven_seg_tb;

architecture Behavioral of seven_seg_tb is

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

    signal clk : std_logic := '0';
    signal reset, enable, drive_high, dp, dp_drive : STD_LOGIC;
    signal number : STD_LOGIC_VECTOR( 7 downto 0);
    signal segment_drive : STD_LOGIC_VECTOR( 6 downto 0);

    
begin

    seven_segment_DUT : seven_seg
    port map (
        clk => clk,
        reset => reset,
        enable => enable,
        dp => dp,
        drive_high => drive_high,
        number => number,
        segment_drive => segment_drive,
        dp_drive => dp_drive
    );

    clk <= not clk after 5 ns;
    
    stimulus : process
        variable loop_count : integer := 0;
    begin
        --clk <= '0';
        reset <= '0';
        enable <= '0';
        number <= "00000000";
        drive_high <= '0';
        dp <= '0';
        
        wait for 15 ns;
        reset <= '1';
        wait for 15 ns;
        reset <= '0';
        wait for 15 ns;
        enable <= '1';
        
        while loop_count < 16 loop
            --number <= number + 1;
            wait for 27 ns;
            loop_count := loop_count + 1;
            number <= std_logic_vector(to_unsigned(loop_count, number'length));
        end loop;
        
        dp <= '1';
        
        wait;
    end process;


end Behavioral;
