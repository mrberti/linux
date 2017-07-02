----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2017 11:03:57
-- Design Name: 
-- Module Name: seven_seg_4 - basys
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

entity seven_seg_4 is
    generic (
        F_clk : integer := 100000000; -- Hz
        F_cycle : integer := 10000000 -- Hz
    );
    port ( 
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
end seven_seg_4;

architecture rtl of seven_seg_4 is
    
    constant N_count_max : integer := F_clk / F_cycle - 1;
    
    signal clk_counter : integer range 0 to N_count_max;
    signal counter_overflow : std_logic;
    
    signal segment_drive1, segment_drive2, segment_drive3, segment_drive4 : std_logic_vector ( 6 downto 0 );
    signal dp_drive1, dp_drive2, dp_drive3, dp_drive4 : std_logic;
    
    
    signal an_drive_d : std_logic_vector( 3 downto 0 );
        
begin

    -- instatiate 4 seven segment digits
    digit1 : entity work.seven_seg port map( clk=>clk, reset=>reset, enable=>enable,number=>number1,dp=>dp1,drive_high=>drive_high,segment_drive=>segment_drive1,dp_drive=>dp_drive1);
    digit2 : entity work.seven_seg port map( clk=>clk, reset=>reset, enable=>enable,number=>number2,dp=>dp2,drive_high=>drive_high,segment_drive=>segment_drive2,dp_drive=>dp_drive2);
    digit3 : entity work.seven_seg port map( clk=>clk, reset=>reset, enable=>enable,number=>number3,dp=>dp3,drive_high=>drive_high,segment_drive=>segment_drive3,dp_drive=>dp_drive3);
    digit4 : entity work.seven_seg port map( clk=>clk, reset=>reset, enable=>enable,number=>number4,dp=>dp4,drive_high=>drive_high,segment_drive=>segment_drive4,dp_drive=>dp_drive4);
    
    counter : process(clk)
    begin
        if reset = '1' then
            clk_counter <= 0;
            counter_overflow <= '0';
        elsif clk'event and clk = '1' then
            if clk_counter < N_count_max then
                counter_overflow <= '0';
                clk_counter <= clk_counter + 1;
            else
                counter_overflow <= '1';
                clk_counter <= 0;
            end if;
        end if; 
    end process;
    
    an_multiplex : process(clk)
    begin
        if reset = '1' then
            an_drive_d <= (0 => drive_high, OTHERS => not drive_high);
        elsif clk'event and clk = '1' then
            if enable = '1' then
                if counter_overflow = '1' then
                    an_drive_d <= ( -- rotating through
                            3 => an_drive_d(2),
                            2 => an_drive_d(1),
                            1 => an_drive_d(0),
                            0 => an_drive_d(3)
                            );
                end if;
                an_drive <= an_drive_d;
            else
                an_drive <= (OTHERS => not drive_high);       
            end if;
        end if;       
    end process;
    
    seg_multiplex : process(clk)
    begin
        --if reset = '1' then
        --elsif clk'event and clk = '1' then
            case an_drive_d is
                when "0001"|"1110" => 
                    segment_drive <= segment_drive4;
                    dp_drive <= dp_drive4;
                when "0010"|"1101" => 
                    segment_drive <= segment_drive3;
                    dp_drive <= dp_drive3;
                when "0100"|"1011" => 
                    segment_drive <= segment_drive2;
                    dp_drive <= dp_drive2;
                when "1000"|"0111" => 
                    segment_drive <= segment_drive1;
                    dp_drive <= dp_drive1;
                when OTHERS =>
                    segment_drive <= (OTHERS => not drive_high);
                    dp_drive <= not drive_high;
            end case;
        --end if;
        
    end process;

end rtl;
