-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity seven_sig is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end seven_sig;  

architecture beh of seven_sig is

begin
  
  process(clk,reset)
  begin
    if (reset = '1') then 
      seven_seg_out <= '1111111';
    elsif (clk'event and clk = '1') then
      case bcd is 
      when '0000'=>seven_seg_out <= '1111111';
      when '0001'=>seven_seg_out <= '1111111';
      when '0010'=>seven_seg_out <= '1111111';
      when '0011'=>seven_seg_out <= '1111111';
      when '0100'=>seven_seg_out <= '1111111';
      when '0101'=>seven_seg_out <= '1111111';
      when '0110'=>seven_seg_out <= '1111111';
      when '0111'=>seven_seg_out <= '1111111';
      when '1000'=>seven_seg_out <= '1111111';
      when '1001'=>seven_seg_out <= '1111111';
      when others  seven_seg_out <= '1111111';
      end case;
    end if;
  end process;
  
end seven_sig;