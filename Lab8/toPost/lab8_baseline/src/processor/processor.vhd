-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.pro_parts.all;
use work.control_parts.all;

entity processor  is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    sync            : in  std_logic;
    instruction     : in  std_logic_vector  (7 downto 0);
    address         : out std_logic_vector (13 downto 0)
  );  
end; 

architecture beh of processor is
  signal is_end           : std_logic;
  signal pro_state        : std_logic_vector(4 downto 0);
  signal command          : std_logic_vector(1 downto 0);
  signal command_sync     : std_logic_vector(1 downto 0);
  signal address_sig      : std_logic_vector(13 downto 0);
  signal jmp2             : std_logic_vector(13 downto 0);
  constant this_is_ed     : std_logic_vector(13 downto 0) := (others => '1');
begin 
  
  jmp2(13 downto 9) <=  instruction(4 downto 0);
  jmp2(8 downto 0) <= (others => '0');
  address <= address_sig;
  
  change:pro_machine
    port map(
      clk             => clk,
      reset           => reset,
      is_end          => is_end,
      instruction     => instruction,
      command         => command,
      pro_state       => pro_state
    );  
    
  process(sync,command)
  begin
    case sync is
      when '0' => command_sync <="00";
      when others => command_sync <= command;
    end case;
  end process;
  
  find_instructions : program_counter
    generic map(
      bits => 14
    )
    port map (
      clk      => clk,
      reset    => reset,
      enable   => command_sync,
      jmp2addy => jmp2,
      address  => address_sig
    );
  
  process(address_sig) 
  begin
    if address_sig = this_is_ed then 
      is_end <= '1';
    else
      is_end <= '0';
    end if;
  end process;
  
  
end beh;