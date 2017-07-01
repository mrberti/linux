----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2017 11:21:53
-- Design Name: 
-- Module Name: seven_seg_4_tb - Behavioral
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

entity seven_seg_4_tb is
--  Port ( );
end seven_seg_4_tb;

architecture Behavioral of seven_seg_4_tb is

    component seven_seg_4
    Generic (
        F_clk : integer := 100000000; -- Hz
        F_cycle : integer := 10000000 -- Hz
    );
    Port ( 
        clk : in STD_LOGIC;
        enable : in STD_LOGIC;
        reset : in STD_LOGIC;
        
        drive_high : in STD_LOGIC;
        
        number1 : in std_logic_vector(7 downto 0);
        number2 : in std_logic_vector(7 downto 0);
        number3 : in std_logic_vector(7 downto 0);
        number4 : in std_logic_vector(7 downto 0);
        
        dp1 : in std_logic;
        dp2 : in std_logic;
        dp3 : in std_logic;
        dp4 : in std_logic;     
        
        segment_drive : out STD_LOGIC_VECTOR (6 downto 0);
        dp_drive : out STD_LOGIC;
        
        -- an_drive will be used to multiplex the segments, only one bit may be active!
        an_drive : out STD_LOGIC_VECTOR(3 downto 0)
       );
    end component;

    signal clk : std_logic := '0';
    signal reset, enable, drive_high, dp1, dp2, dp3, dp4, dp_drive : STD_LOGIC;
    signal number1, number2, number3, number4 : STD_LOGIC_VECTOR( 7 downto 0);
    signal segment_drive : STD_LOGIC_VECTOR( 6 downto 0);
    signal an_drive : STD_LOGIC_VECTOR( 3 downto 0);

    
begin

    seven_segment_4_DUT : seven_seg_4
    port map (
        clk => clk,
        reset => reset,
        enable => enable,
        
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
        dp_drive => dp_drive,    
        
        an_drive => an_drive
    );

    clk <= not clk after 5 ns;
    
    stimulus : process
        variable loop_count : integer := 0;
    begin
        reset <= '0';
        enable <= '0';
        number1 <= "00000001";
        number2 <= "00000010";
        number3 <= "00000011";
        number4 <= "00000100";
        drive_high <= '0';
        dp1 <= '0';
        dp2 <= '0';
        dp3 <= '1';
        dp4 <= '0';
        
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
            --number1 <= std_logic_vector(to_unsigned(loop_count, number1'length));
            --number2 <= 
        end loop;
        
        dp1 <= '1';
        
        wait;
    end process;


end Behavioral;
