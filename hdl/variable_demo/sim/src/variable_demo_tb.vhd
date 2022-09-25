-------------------------------------------------------------------------------
-- Dr. Kaputa
-- variable demo test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity variable_demo_tb is
end variable_demo_tb;

architecture beh of variable_demo_tb is

signal y : integer := 5;

begin
process
  variable x,z : integer := 0;
  begin 
    x := 1;
    y <= x; 
    z := y;
    wait;
  end process;
end beh;