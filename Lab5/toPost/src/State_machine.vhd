-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity State_machine  is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    button          : in std_logic;
    state           : out std_logic_vector(3 downto 0)
  );  
end; 

architecture beh of State_machine is
  signal current_state       :std_logic_vector(3 downto 0);
  signal next_state          :std_logic_vector(3 downto 0);
begin
    
  process (reset,clk)
  begin
    if (reset = '1') then
      current_state <= "0001";
    elsif(clk'event and clk = '1')  then
      if(button = '1') then
        current_state <= next_state;
      end if;
    end if;
  end process;
  
  process (reset,current_state,next_state)
  begin 
    if (reset = '1') then 
        next_state <= "0001";
    else
      case (current_state) is
        when "0001"  => next_state <="0010";
        when "0010"  => next_state <="0100";
        when "0100"  => next_state <="1000";
        when others  => next_state <="0001";
      end case;
    end if;
  end process;
  
  state <= current_state;
end beh;