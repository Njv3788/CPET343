-------------------------------------------------------------------------------
-- Nathaniel Valla
-- single bit full adder [structural]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_single_bit_str is 
  port (
    a       : in std_logic;
    b       : in std_logic;
    cin     : in std_logic;
    
    sum     : out std_logic;
    cout    : out std_logic
  );
end full_adder_single_bit_str;

architecture str of full_adder_single_bit_str is
begin 
  cout <= ((a xor b) xor cin);                 -- carry out 
  sum  <= ((a and b) or ((a xor b) and cin));  -- sum bit 
end str;