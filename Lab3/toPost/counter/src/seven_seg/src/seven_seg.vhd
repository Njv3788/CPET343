-------------------------------------------------------------------------------
-- Nathaniel
-- seven segment display
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity seven_seg is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);    --input
    seven_seg_out   : out std_logic_vector(6 downto 0)    --display
  );  
end; 

architecture beh of seven_seg is
begin
    
  process (reset,bcd,clk)
  begin
    if (reset = '1') then                                  --if reset then
      seven_seg_out<="1111111";                            --all off
    elsif(clk'event and clk = '1')  then                   --clk bc waveform 
      case bcd is                                          --input todisplay
        when "0000" =>seven_seg_out<="1000000";
        when "0001" =>seven_seg_out<="1111001";
        when "0010" =>seven_seg_out<="0100100";
        when "0011" =>seven_seg_out<="0110000";
        when "0100" =>seven_seg_out<="0011001";
        when "0101" =>seven_seg_out<="0010010";
        when "0110" =>seven_seg_out<="0000010";
        when "0111" =>seven_seg_out<="1111000";
        when "1000" =>seven_seg_out<="0000000";
        when "1001" =>seven_seg_out<="0011000";
        when others =>seven_seg_out<="1111111";
      end case;
    end if;
  end process;
  
end beh;