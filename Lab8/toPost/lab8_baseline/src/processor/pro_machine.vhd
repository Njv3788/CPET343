-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.pro_parts.all;

entity pro_machine is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    is_end          : in  std_logic;
    instruction     : in  std_logic_vector (7 downto 0);
    command         : out std_logic_vector (1 downto 0);
    pro_state       : out std_logic_vector (4 downto 0)
  );  
end; 

architecture beh of pro_machine is
  signal current_state        :std_logic_vector(4 downto 0);
  signal next_state           :std_logic_vector(4 downto 0);
  
  alias CMD                   :std_logic_vector is instruction(7 downto 6);
  alias RPT                   :std_logic is instruction(5);

 
  constant play               :std_logic_vector(4 downto 0) := "00001";
  constant repeat             :std_logic_vector(4 downto 0) := "00010";
  constant pause              :std_logic_vector(4 downto 0) := "00100";
  constant seek               :std_logic_vector(4 downto 0) := "01000";
  constant stop               :std_logic_vector(4 downto 0) := "10000";
  
begin
  
  process (reset,clk)
  begin
    if (reset = '1') then
      current_state <= stop;
    elsif(clk'event and clk = '1')  then
      current_state <= next_state;
    end if;
  end process;
  
  process (CMD,RPT)
  begin 
    case CMD is
      when "00" => 
        if RPT = '1' then
          next_state <= repeat;
        else 
          next_state <= play;
        end if;
      when "01" =>
        next_state <= pause;
      when "10" =>
        next_state <= seek;
      when "11" => 
        next_state <= stop;
      when others  =>
        next_state <= stop;
    end case;
  end process;
  
  process(current_state,is_end)
  begin
    case current_state is 
      when play   =>
        if is_end = '1' then 
          command <= "00";
        else
          command <= "01";
        end if;
      when repeat =>
        command <= "01";
      when pause  =>
        command <= "00";
      when seek   =>
        command <= "10";
      when stop   =>
        command <= "11";
      when others => 
        command <= "00";
    end case;
  end process;
  
  pro_state <= current_state;
end beh;