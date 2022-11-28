-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.pro_parts.all;

entity processor  is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    sync            : in  std_logic;
    instruction     : in  std_logic_vector (7 downto 0)
  );  
end; 

architecture beh of processor is
  signal pro_state        :std_logic_vector(4 downto 0);

  alias play               :std_logic is pro_state(0);
  alias repeat             :std_logic is pro_state(1);
  alias pause              :std_logic is pro_state(2);
  alias seek               :std_logic is pro_state(3);
  alias stop               :std_logic is pro_state(4);
begin 
  
  change:pro_machine
    port map(
      clk             => clk,
      reset           => reset,
      instruction     => instruction,
      pro_state       => pro_state
    );  
  
  
  
  
  
  
  
  
  
  
end beh;