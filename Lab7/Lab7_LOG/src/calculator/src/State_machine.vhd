-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity State_machine  is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute         : in  std_logic;
    memory_save     : in  std_logic;
    memory_recall   : in  std_logic;
    write_enable    : out std_logic;
    memory_in_sel   : out std_logic;
    address_sel     : out std_logic;
    state           : out std_logic_vector(4 downto 0)
  );  
end; 

architecture beh of State_machine is
  signal current_state         :std_logic_vector(4 downto 0);
  signal next_state            :std_logic_vector(4 downto 0);
  
  alias  r_work                :std_logic is current_state(0);
  alias  brn_cyc               :std_logic is current_state(1);
  alias  w_work                :std_logic is current_state(2);
  alias  r_save                :std_logic is current_state(3);
  alias  w_save                :std_logic is current_state(4);
  
  signal r_w_work              :std_logic;
  signal z_r_w_work            :std_logic_vector(1 downto 0);
  signal memory_sel_sig        :std_logic;
  signal address_sel_sig       :std_logic;
  signal n_brn_work            :std_logic;
  
  constant read_w              :std_logic_vector(4 downto 0) := "00001";
  constant burn_cycle          :std_logic_vector(4 downto 0) := "00010";
  constant write_w             :std_logic_vector(4 downto 0) := "00100";
  constant read_s              :std_logic_vector(4 downto 0) := "01000";
  constant write_s             :std_logic_vector(4 downto 0) := "10000";
  
begin
  state            <= current_state;
  n_brn_work       <= not(brn_cyc or w_work);
  r_w_work         <= (w_save  or r_save);
  address_sel_sig  <= (z_r_w_work(0) or r_w_work );
  memory_sel_sig   <= (z_r_w_work(1) or address_sel_sig );
  
  process (reset,clk)
  begin
    if (reset = '1') then
      current_state <= read_w;
    elsif(clk'event and clk = '1')  then
      current_state <= next_state;
    end if;
  end process;
  
  process (execute,memory_save,memory_recall,current_state)
  begin 
    case current_state is
      when read_w => 
        if (execute = '1') then
          next_state <= burn_cycle ;
        elsif (memory_save = '1') then
          next_state <= write_s ;
        elsif (memory_recall = '1') then
          next_state <= read_s ;
        else
          next_state <= read_w;
        end if;
      when burn_cycle =>
        next_state <= write_w;
      when write_w =>
        next_state <= read_w;
      when write_s => 
        next_state <= read_w;
      when read_s  =>
        next_state <= burn_cycle;
      when others  =>
        next_state <= read_w;
    end case;
  end process;
  
  process(current_state)
  begin
    case current_state is 
      when write_w => write_enable <= '1';
      when write_s => write_enable <= '1';
      when others  => write_enable <= '0';
    end case;
  end process;
  
  process (reset,clk)
  begin
    if (reset = '1') then
      z_r_w_work  <= "00";
    elsif(clk'event and clk = '1')  then
      z_r_w_work(0)  <=  r_w_work;
      z_r_w_work(1)  <= z_r_w_work(0);
    end if;
  end process;
  
  process(n_brn_work,r_work,address_sel_sig)
  begin
    case n_brn_work is 
      when '1'    => address_sel  <= not r_work;
      when others => address_sel  <= address_sel_sig;
    end case;
  end process;
  
  process(n_brn_work,r_work,memory_sel_sig)
  begin
    case n_brn_work is 
      when '1'    => memory_in_sel  <= not r_work;
      when others => memory_in_sel  <= memory_sel_sig;
    end case;
  end process;
  
  
end beh;