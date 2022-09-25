-------------------------------------------------------------------------------
-- Dr. Kaputa
-- falling edge synchronizer
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity falling_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
end falling_edge_synchronizer;

architecture beh of falling_edge_synchronizer is
-- signal declarations
signal input_z     : std_logic;
signal input_zz    : std_logic;
signal input_zzz   : std_logic;

begin 
synchronizer: process(reset,clk,input)
  begin
    if reset = '1' then
      input_z     <= '0';
      input_zz    <= '0';
    elsif rising_edge(clk) then
      input_z   <= input;
      input_zz  <= input_z;
    end if;
end process;  

falling_edge_detector: process(reset,clk,input_zz)
  begin
    if reset = '1' then
      edge        <= '0';
      input_zzz   <= '0';
    elsif rising_edge(clk) then
      input_zzz   <= input_zz;
      edge <= (input_zz xor input_zzz) and (not input_zz);
    end if;
end process;  
end beh; 