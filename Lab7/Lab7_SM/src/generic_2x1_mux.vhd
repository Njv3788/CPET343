-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_7 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity generic_2x1_mux is
  generic (
    bits : integer := 8
  );
  port (
    sel             : in  std_logic;
    a               : in  std_logic_vector(bits-1 downto 0);
    b               : in  std_logic_vector(bits-1 downto 0);
    output          : out std_logic_vector(bits-1 downto 0)
  );
end;

architecture beh of generic_2x1_mux is
begin
  process(sel,a,b)
  begin
    case sel is
      when '0' => output <= a;
      when others => output <= b;
    end case;
  end process;
end;