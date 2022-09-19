-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink led demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity seven_sig is
  port (
    binary          : in  std_logic_vector(3 downto 0); 
    output          : out std_logic_vector(3 downto 0)
  );  
end seven_sig;  

architecture beh of seven_sig is

begin
  
  process(clk,reset)
  begin
   
  end process;
  
end seven_sig;