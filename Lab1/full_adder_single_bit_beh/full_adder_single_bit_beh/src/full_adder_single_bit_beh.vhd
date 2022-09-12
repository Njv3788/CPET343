-------------------------------------------------------------------------------
-- Nathaniel Valla
-- single bit full adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_single_bit_beh is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_beh;

architecture beh of full_adder_single_bit_beh is
  signal guard_a   : std_logic_vector(1 downto 0); 
  signal guard_b   : std_logic_vector(1 downto 0);
  signal guard_cin : std_logic_vector(1 downto 0);
  signal outputs   : std_logic_vector(1 downto 0);
begin 
  guard_a   <=  '0' & a;   --  add guard  bit  to a 
  guard_b   <=  '0' & b;   --  add guard  bit  to b 
  guard_cin <=  '0' & cin; --  add guard  bit  to cin  

  outputs <= std_logic_vector(unsigned(guard_a) + unsigned(guard_b) 
			+ unsigned(guard_cin)); 
  sum  <= outputs(0);      -- assign first output to sum 
  cout <= outputs(1);      -- assign second output to cout


end beh;