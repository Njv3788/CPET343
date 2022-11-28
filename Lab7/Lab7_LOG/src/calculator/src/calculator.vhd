-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_5 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity calculator is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute         : in  std_logic;
    memory_save     : in  std_logic;
    memory_recall   : in  std_logic;
    op_code         : in  std_logic_vector(1 downto 0);
    input           : in  std_logic_vector(7 downto 0);
    output          : out std_logic_vector(7 downto 0);
    state_out       : out std_logic_vector(4 downto 0)
  );
end calculator ;

architecture beh of calculator  is

  component State_machine is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      execute         : in  std_logic;
      memory_save     : in  std_logic;
      memory_recall   : in  std_logic;
      write_enable    : out  std_logic;
      memory_in_sel   : out  std_logic;
      address_sel     : out  std_logic;
      state           : out std_logic_vector(4 downto 0)
    );  
  end component;
  
  component memory is 
    generic (addr_width : integer := 2;
             data_width : integer := 8);
    port (
      clk               : in  std_logic;
      we                : in  std_logic;
      addr              : in  std_logic_vector(addr_width - 1 downto 0);
      din               : in  std_logic_vector(data_width - 1 downto 0);
      dout              : out std_logic_vector(data_width - 1 downto 0)
    );
  end component;
  
  component alu is
    port (
      clk           : in  std_logic;
      reset         : in  std_logic;
      a             : in  std_logic_vector(7 downto 0); 
      b             : in  std_logic_vector(7 downto 0);
      op            : in  std_logic_vector(1 downto 0); -- 00: add, 01: sub, 10: mult, 11: div
      result        : out std_logic_vector(7 downto 0)
    );  
  end component; 

  signal write_enable       : std_logic;
  signal memory_in_sel      : std_logic;
  signal address_sel        : std_logic;
  signal memory_out         : std_logic_vector(7 downto 0);
  signal memory_in          : std_logic_vector(7 downto 0);
  signal alu_out            : std_logic_vector(7 downto 0);
  signal state              : std_logic_vector(4 downto 0);
  signal address            : std_logic_vector(1 downto 0);
  
  constant zeros               :std_logic_vector(7 downto 0) := (others => '0');
  constant read_w              :std_logic_vector(4 downto 0) := "00001";
  constant burn_cycle          :std_logic_vector(4 downto 0) := "00010";
  constant write_w             :std_logic_vector(4 downto 0) := "00100";
  constant read_s              :std_logic_vector(4 downto 0) := "01000";
  constant write_s             :std_logic_vector(4 downto 0) := "10000";
  
begin
  state_out <= state;
  
  process(address_sel)
  begin
    case address_sel is 
      when '1'     => address <= "01"; 
      when others  => address <= "00";
    end case;
  end process;
  
  process(memory_in_sel,alu_out,memory_out )
  begin
    case memory_in_sel is 
      when '1'    => memory_in <= memory_out;
      when others => memory_in <= alu_out;
    end case;
  end process;
  
  state_changer: State_machine  
    port map(        
      clk            => clk,
      reset          => reset,
      execute        => execute,
      memory_save    => memory_save,
      memory_recall  => memory_recall,
      write_enable   => write_enable,
      memory_in_sel  => memory_in_sel,
      address_sel    => address_sel,
      state          => state
    );
    
  ram_gen: memory
    port map(
      clk            => clk, 
      we             => write_enable,
      addr           => address,
      din            => memory_in ,
      dout           => memory_out 
    );
    
  math: alu
    port map(
      clk            => clk, 
      reset          => reset,
      a              => memory_out,
      b              => input,
      op             => op_code,
      result         => alu_out 
    );
  
  output <= memory_out;

end beh;