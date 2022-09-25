-------------------------------------------------------------------------------
-- Dr. Kaputa
-- four paradigmns demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity four_paradigms is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    a               : in  std_logic;
    b_comb          : out std_logic;
    b_sync          : out std_logic;
    b_conc          : out std_logic;
    b_sequ          : out std_logic
  );  
end four_paradigms;  

architecture beh of four_paradigms  is

begin

-- combinational
b_comb <= a;

-- synchronous
process(clk,reset)
  begin
    if (reset = '1') then 
      b_sync <= '0';
    elsif (clk'event and clk = '1') then
      b_sync <= a;
    end if;
  end process;
  
-- concurrent
b_conc <= a;

-- sequential
process(clk,reset)
  begin
    b_sequ <= reset;
    b_sequ <= a;
  end process;
end beh;