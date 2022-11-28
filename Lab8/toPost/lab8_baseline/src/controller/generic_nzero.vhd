-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_7 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity generic_nzero is
  generic (
    bits : integer := 8
  );
  port (
    sel             : in  std_logic_vector(bits-1 downto 0);
    output          : out std_logic
  );
end;

architecture beh of generic_nzero is
  constant zero             :  std_logic_vector(bits-1 downto 0) := (others => '0');

begin
  process(sel)
  begin
    if (sel = zero ) then 
      output <= '0';
    else 
      output <= '1';
    end if;
  end process;
end;