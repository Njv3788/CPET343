-------------------------------------------------------------------------------
-- Nathaniel Vall 
-- generic synchronizer 
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity synchronizer is
  generic (
      bits    : integer := 4
    );
  port (
    clk               : in  std_logic;
    reset             : in  std_logic;
    async_in          : in  std_logic_vector (bits-1 downto 0);
    sync_out          : out std_logic_vector (bits-1 downto 0)
  );
end synchronizer;

architecture beh of synchronizer is
-- signal declarations
signal flop1     : std_logic_vector (bits-1 downto 0);
signal flop2     : std_logic_vector (bits-1 downto 0);
signal flop3     : std_logic_vector (bits-1 downto 0);

constant zero    : std_logic_vector (bits-1 downto 0):= (others => '0');

begin 
double_flop :process(reset,clk,async_in)
  begin
    if reset = '1' then
      flop1 <= zero;
      flop2 <= zero;
      flop3 <= zero;
    elsif rising_edge(clk) then
      flop1 <= async_in;
      flop2 <= flop1;
      flop3 <= flop2;
    end if;
end process;

sync_out <= flop3;
end beh; 