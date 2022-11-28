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
  
  constant input_a             :std_logic_vector(3 downto 0) := "0001";
  constant input_b             :std_logic_vector(3 downto 0) := "0010";
  constant display_add         :std_logic_vector(3 downto 0) := "0100";
  constant display_sub         :std_logic_vector(3 downto 0) := "1000";
begin
    
  process (reset,clk)
  begin
    if (reset = '1') then
      current_state <= input_a;
    elsif(clk'event and clk = '1')  then
        current_state <= next_state;
    end if;
  end process;
  
  process (button,current_state)
  begin 
    case current_state is
      when input_a     => 
        if (button = '1') then
          next_state <= input_b ;
        else
          next_state <= input_a;
        end if;
      when input_b     =>
        if (button = '1') then
          next_state <= "0100";
        else
          next_state <= input_b ;
         end if;
      when display_add =>
        if (button = '1') then
          next_state <= display_sub;
        else
          next_state <= display_add;
        end if;
      when display_sub => 
        if (button = '1') then
          next_state <= input_a;
        else
          next_state <= display_sub;
        end if;
      when others      =>
          next_state <= input_a;
    end case;
  end process;
  
  state <= current_state;
end beh;