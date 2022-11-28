-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_7 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

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
  
  signal reset_n              : std_logic;
  signal input_sync           : std_logic_vector(7 downto 0);
  signal op_sync              : std_logic_vector(1 downto 0);
  signal output               : std_logic_vector(7 downto 0);
  signal address_sig          : std_logic_vector(4 downto 0);
  signal instruction          : std_logic_vector(12 downto 0);
  signal res_instruction      : std_logic_vector(12 downto 0);
  signal decode_1_instruction : std_logic_vector(12 downto 0);
  signal decode_2_instruction : std_logic_vector(12 downto 0);
  signal decode_3_instruction : std_logic_vector(12 downto 0);
  signal valid_instruction    : std_logic_vector(12 downto 0);
  
  alias  ex                    :std_logic is valid_instruction(12);
  alias  ms                    :std_logic is valid_instruction(11);
  alias  mr                    :std_logic is valid_instruction(10);
  alias  operation             :std_logic_vector(1 downto 0) is valid_instruction(9 downto 8);
  alias  operand               :std_logic_vector(7 downto 0) is valid_instruction(7 downto 0);
  
  signal  top_state            :std_logic_vector(4 downto 0);
  signal  excute_sync          :std_logic; 
  signal  cute                 :std_logic_vector(1 downto 0);
  
  signal  ex_sync              :std_logic;
  signal  ms_sync              :std_logic;
  signal  mr_sync              :std_logic;
  signal  enable               :std_logic;
  signal  error                :std_logic;
begin
  
  reset_n  <= not reset;
  cute     <= '0' & (excute_sync or error);
  enable   <= '1';
  
  
  decode_1:generic_laterial_shift
    generic map (
      bits => 13
    )
    port map (
      clk             => clk,
      reset           => reset_n,
      enable          => enable,
      preset          => (others => '0'),
      shift_in        => res_instruction,
      shift_out       => decode_1_instruction
    );
  
  decode_2:generic_laterial_shift
    generic map (
      bits => 13
    )
    port map (
      clk             => clk,
      reset           => reset_n,
      enable          => enable,
      preset          => (others => '0'),
      shift_in        => decode_1_instruction,
      shift_out       => decode_2_instruction
    );
  decode_3:generic_laterial_shift
    generic map (
      bits => 13
    )
    port map (
      clk             => clk,
      reset           => reset_n,
      enable          => enable,
      preset          => (others => '0'),
      shift_in        => decode_2_instruction,
      shift_out       => decode_3_instruction
    );
    
  valid:generic_laterial_shift
    generic map (
      bits => 13
    )
    port map (
      clk             => clk,
      reset           => reset_n,
      enable          => top_state(4),
      preset          => (others => '0'),
      shift_in        => decode_3_instruction,
      shift_out       => valid_instruction
    );
  
  res_gen:generic_2x1_mux
    generic map (
      bits => 13
    )
    port map (
      sel             => top_state(1),
      a               => instruction,
      b               => (others => '0'),
      output          => res_instruction
    );
    
  find_instructions : program_counter
    port map (
      clk      => clk,
      reset    => reset_n,
      enable   => cute,
      jmp2addy => (others=> '0'),
      address  => address_sig
     );
  
  instructions_inst : instructions 
    port map (
      address  => address_sig,
      clock    => clk,
      q        => instruction
    );
  
  change_top: machine
    port map(
      clk               => clk,
      reset             => reset_n,
      execute           => excute_sync,
      instruction       => instruction,
      again             => error,
      state             => top_state
    );
    
  sync_ex: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => ex,
      edge              => ex_sync
    );
    
  sync_ms: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => ms,
      edge              => ms_sync
    );
    
  sync_mr: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => mr,
      edge              => mr_sync
    );
    
  sync_cute: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset_n,
      input             => execute,
      edge              => excute_sync
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