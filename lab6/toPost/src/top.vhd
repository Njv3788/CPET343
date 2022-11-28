-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_5 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute         : in  std_logic;
    memory_save     : in  std_logic;
    memory_recall   : in  std_logic;
    op_code         : in  std_logic_vector(1 downto 0);
    input           : in  std_logic_vector(7 downto 0);
    one_out         : out std_logic_vector(6 downto 0);
    ten_out         : out std_logic_vector(6 downto 0);
    hun_out         : out std_logic_vector(6 downto 0);
    state_out       : out std_logic_vector(4 downto 0)
  );
end top;

architecture beh of top is

  component rising_edge_synchronizer is 
    port (
      clk               : in std_logic;
      reset             : in std_logic;
      input             : in std_logic;
      edge              : out std_logic
    );
  end component;
  
  component synchronizer is
    generic (
      bits    : integer := 4
    );
    port (
      clk               : in  std_logic;
      reset             : in  std_logic;
      async_in          : in  std_logic_vector (bits-1 downto 0);
      sync_out          : out std_logic_vector (bits-1 downto 0)
    );
  end component;

  component calculator is
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
  end component ;
  
  component display is
    generic (
      bits    : integer := 10
    );
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic; 
      input           : in  std_logic_vector(bits-1 downto 0);
      one_out         : out std_logic_vector(6 downto 0);
      ten_out         : out std_logic_vector(6 downto 0);
      hun_out         : out std_logic_vector(6 downto 0)
    );
  end component;
  
  signal execute_sync       : std_logic;
  signal memory_save_sync   : std_logic;
  signal memory_recall_sync : std_logic;
  signal reset_n            : std_logic;
  signal input_sync         : std_logic_vector(7 downto 0);
  signal op_sync            : std_logic_vector(1 downto 0);
  signal output             : std_logic_vector(7 downto 0);

begin
  
  reset_n <= not reset;
  
  sync_ex: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => execute,
      edge              => execute_sync
    );
    
  sync_ms: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => memory_save,
      edge              => memory_save_sync
    );
    
  sync_mr: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => memory_recall,
      edge              => memory_recall_sync
    );

  sync_input: synchronizer 
    generic map(
      bits => 8
    )
    port map(
      clk               => clk,
      reset             => reset_n,
      async_in          => input,
      sync_out          => input_sync
    );
    
  sync_op: synchronizer 
    generic map(
      bits => 2
    )
    port map(
      clk               => clk,
      reset             => reset_n,
      async_in          => op_code,
      sync_out          => op_sync
    );
  
  bin2hex_dis: display 
    generic map(
      bits => 8
    )
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => output,
      one_out           => one_out,
      ten_out           => ten_out,
      hun_out           => hun_out
    );
    
  math: calculator  
    port map(        
      clk            => clk,
      reset          => reset_n,
      execute        => execute_sync,
      memory_save    => memory_save_sync ,
      memory_recall  => memory_recall_sync,
      op_code        => op_sync,
      input          => input_sync,
      output         => output,
      state_out      => state_out 
    );

end beh;