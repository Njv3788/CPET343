-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_7 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute         : in  std_logic;
    one_out         : out std_logic_vector(6 downto 0);
    ten_out         : out std_logic_vector(6 downto 0);
    hun_out         : out std_logic_vector(6 downto 0);
    state_out       : out std_logic_vector(4 downto 0)
  );
end top;

architecture beh of top is
  
  component program_counter is
    generic (
      bits    : integer := 5
    );
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      enable          : in  std_logic_vector(1 downto 0);
      jmp2addy        : in  std_logic_vector(bits-1 downto 0);
      address         : out std_logic_vector(bits-1 downto 0)
    );  
  end component; 

  component instructions
    port(
      address         : in  std_logic_vector(4 downto 0);
      clock           : in  std_logic  := '1';
      q               : out std_logic_vector(12 downto 0)
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
  
  component rising_edge_synchronizer is 
    port (
      clk               : in std_logic;
      reset             : in std_logic;
      input             : in std_logic;
      edge              : out std_logic
    );
  end component;
  
  signal reset_n            : std_logic;
  signal input_sync         : std_logic_vector(7 downto 0);
  signal op_sync            : std_logic_vector(1 downto 0);
  signal output             : std_logic_vector(7 downto 0);
  signal address_sig        : std_logic_vector(4 downto 0);
  signal instruction        : std_logic_vector(12 downto 0);
  
  alias  ex                    :std_logic is instruction(12);
  alias  ms                    :std_logic is instruction(11);
  alias  mr                    :std_logic is instruction(10);
  alias  operation             :std_logic_vector(1 downto 0) is instruction(9 downto 8);
  alias  operand               :std_logic_vector(7 downto 0) is instruction(7 downto 0);
  
  
  signal  z_execute            :std_logic_vector(1 downto 0);
  signal  cute_sync            :std_logic; 
  signal  cute                 :std_logic_vector(1 downto 0);
  
  signal  ex_sync              :std_logic;
  signal  ms_sync              :std_logic;
  signal  mr_sync              :std_logic;
  
  signal  res                 :std_logic;
  signal  ex_res              :std_logic;
  signal  ms_res              :std_logic;
  signal  mr_res              :std_logic;

begin
  
  reset_n <= not reset;
  res     <= not z_execute(1);
  ex_res  <= res and ex;
  ms_res  <= res and ms;
  mr_res  <= res and mr;
  cute    <= '0' & cute_sync;
  
  process (reset,clk)
  begin
    if (reset = '0') then
      z_execute <= (others => '0');
    elsif(clk'event and clk = '1')  then
      z_execute(0) <= cute_sync;
      z_execute(1) <= z_execute(0);
    end if;
  end process;
  
  find_instructions : program_counter
    port map (
      clk     => clk,
      reset   => reset_n,
      enable  => cute,
      jmp2addy => (others=> '0'),
      address => address_sig
     );
     
  instructions_inst : instructions 
    port map (
      address  => address_sig,
      clock    => clk,
      q        => instruction
    );
  
  sync_ex: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => ex_res,
      edge              => ex_sync
    );
    
  sync_ms: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => ms_res,
      edge              => ms_sync
    );
    
  sync_mr: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => mr_res,
      edge              => mr_sync
    );
    
  sync_cute: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => execute,
      edge              => cute_sync
    );
    
  math: calculator  
    port map(        
      clk            => clk,
      reset          => reset_n,
      execute        => ex_sync,
      memory_save    => ms_sync,
      memory_recall  => mr_sync,
      op_code        => operation,
      input          => operand,
      output         => output,
      state_out      => state_out 
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
    
end beh;