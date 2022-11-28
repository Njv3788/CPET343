-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.control_parts.all;

entity controller  is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    execute_btn     : in  std_logic;
    instruction     : out  std_logic_vector (7 downto 0)
  );  
end; 

architecture beh of controller is
    -- instruction memory
  component rom_instructions
    port(
      address    : in std_logic_vector (4 downto 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 downto 0)
    );
  end component;
  
  signal execute              : std_logic_vector(1 downto 0);
  signal address_sig          : std_logic_vector(4 downto 0);
  signal instruc              : std_logic_vector(7 downto 0);
  signal decode_1_instruction : std_logic_vector(7 downto 0);
  signal decode_2_instruction : std_logic_vector(7 downto 0);
  signal valid_instruction    : std_logic_vector(7 downto 0);
  signal state                : std_logic_vector(4 downto 0);
  signal valid_en             : std_logic;
  
begin
  valid_en <= state(4) or state(0);
  
  find_instructions : program_counter
    port map (
      clk      => clk,
      reset    => reset,
      enable   => execute,
      jmp2addy => (others=> '0'),
      address  => address_sig
    );
  
  instructions_inst : rom_instructions 
    port map (
      address  => address_sig,
      clock    => clk,
      q        => instruc
    );
  
  decode_1:generic_laterial_shift
    port map (
      clk             => clk,
      reset           => reset,
      enable          => '1',
      preset          => (others => '0'),
      shift_in        => instruc,
      shift_out       => decode_1_instruction
    );

  decode_2:generic_laterial_shift
    port map (
      clk             => clk,
      reset           => reset,
      enable          => '1',
      preset          => (others => '0'),
      shift_in        => decode_1_instruction,
      shift_out       => decode_2_instruction
    );
  
  valid:generic_laterial_shift
    port map (
      clk             => clk,
      reset           => reset,
      enable          => valid_en,
      preset          => (others => '1'),
      shift_in        => decode_2_instruction,
      shift_out       => valid_instruction
    );
    
  change_top: machine
    port map(
      clk             => clk,
      reset           => reset,
      execute         => execute_btn,
      instruction     => instruc,
      step            => execute,
      state           => state
    );

  instruction <= valid_instruction;
end beh;