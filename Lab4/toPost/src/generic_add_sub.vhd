-------------------------------------------------------------------------------
-- Nathaniel Valla
-- generic adder [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_add_sub is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    add_SUB : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end entity generic_add_sub;

architecture beh of generic_add_sub is

  signal sum_temp   : std_logic_vector(bits downto 0);
  signal cin_guard  : std_logic_vector(bits-1 downto 0) := (others => '0');

begin

  process(add_SUB,a,b)
  begin
    case(add_SUB) is
      when '0' => sum_temp <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b) + unsigned(cin_guard & cin));
      when others=> sum_temp <= std_logic_vector(unsigned('0' & a) - unsigned('0' & b) - unsigned(cin_guard & cin));
     end case;
  end process;

  sum       <= sum_temp(bits-1 downto 0);
  cout      <= sum_temp(bits); -- Carry is the most significant bit
end beh;