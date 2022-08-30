-------------------------------------------------------------------------------
-- Dr. Kaputa
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
  guard_a   <=  '0' & a;
  guard_b   <=  '0' & b;
  guard_cin <=  '0' & cin;

  outputs <= std_logic_vector(unsigned(guard_a) + unsigned(guard_b) + unsigned(guard_cin));
  sum  <= outputs(0);
  cout <= outputs(1);

--  cout <= ((a xor b) xor cin);
--  s    <= ((a and b) or ((a xor b) and cin));
end beh;