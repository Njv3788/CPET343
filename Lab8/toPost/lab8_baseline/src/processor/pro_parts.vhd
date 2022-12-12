-------------------------------------------------------------------------------
-- Dr. Kaputa
-- components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pro_parts is
  
  component pro_machine is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      is_end          : in  std_logic;
      instruction     : in  std_logic_vector (7 downto 0);
      command         : out std_logic_vector (1 downto 0);
      pro_state       : out std_logic_vector (4 downto 0)
    );  
  end component; 
  
  component processor  is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      sync            : in  std_logic;
      instruction     : in  std_logic_vector (7 downto 0);
      address         : out std_logic_vector (13 downto 0)
    );  
  end component; 

end pro_parts;