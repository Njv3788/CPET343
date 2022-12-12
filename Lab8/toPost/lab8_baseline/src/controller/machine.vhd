-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.control_parts.all;

entity machine  is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute         : in  std_logic;
    instruction     : in  std_logic_vector (7 downto 0);
    step            : out std_logic_vector (1 downto 0);
    state           : out std_logic_vector (4 downto 0)
  );  
end; 

architecture beh of machine is
  signal current_state         :std_logic_vector(4 downto 0);
  signal next_state            :std_logic_vector(4 downto 0);
  signal z_execute             :std_logic_vector(3 downto 0);
  
  constant idle               :std_logic_vector(4 downto 0) := "00001";
  constant fetch              :std_logic_vector(4 downto 0) := "00010";
  constant decode             :std_logic_vector(4 downto 0) := "00100";
  constant decode_error       :std_logic_vector(4 downto 0) := "01000";
  constant run                :std_logic_vector(4 downto 0) := "10000";
  
  signal op_3                 :std_logic;
  signal n_zero               :std_logic;
  signal is_valid             :std_logic;
  signal error                :std_logic;
  signal ex_error             :std_logic;
begin
  state    <= current_state;
  op_3     <= (instruction(7) and (not instruction(6)));
  is_valid <= not (op_3 and (not n_zero));
  ex_error <= execute or error ;
  step     <= '0' & ex_error;
  
  process (reset,clk)
  begin
    if (reset = '1') then
      z_execute <= (others => '0');
    elsif(clk'event and clk = '1')  then
      z_execute(0) <= ex_error;
      z_execute(3 downto 1) <= z_execute(2 downto 0);
    end if;
  end process;
  
  process (reset,clk)
  begin
    if (reset = '1') then
      current_state <= idle;
    elsif(clk'event and clk = '1')  then
      current_state <= next_state;
    end if;
  end process;
  
  process (current_state)
  begin
    if (current_state = decode_error) then
      error <= '1';
    else
      error <= '0';
    end if;
  end process;
  
  process (execute,z_execute,current_state,is_valid)
  begin 
    case current_state is
      when idle => 
        if execute = '1' then
          next_state <= fetch;
        else 
          next_state <= idle;
        end if;
      when fetch =>
        if z_execute(1) = '1' then
          next_state <= decode;
        else 
          next_state <= fetch;
        end if;
      when decode =>
        if z_execute(3) = '1' then
          if is_valid = '1' then
            next_state <= run;
          else 
            next_state <= decode_error;
          end if;
        else 
          next_state <= decode;
        end if;
      when decode_error =>
        next_state <= fetch;
      when run =>
        if execute = '1' then
          next_state <= fetch;
        else 
          next_state <= run;
        end if;
      when others  =>
        next_state <= idle;
    end case;
  end process;
  
  is_zero:generic_nzero
    generic map (
      bits => 5
      )
    port map (
      sel             => instruction(4 downto 0),
      output          => n_zero
    );
  
end beh;