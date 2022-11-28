-------------------------------------------------------------------------------
-- Dr. Kaputa
-- components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package control_parts is
  
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
  
  component rom_instructions
    port(
      address    : in std_logic_vector (4 DOWNTO 0);
      clock      : in std_logic  := '1';
      q          : out std_logic_vector (7 DOWNTO 0)
    );
  end component;
  
  component machine is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      execute         : in  std_logic;
      instruction     : in  std_logic_vector (7 downto 0);
      step            : out std_logic_vector (1 downto 0);
      state           : out std_logic_vector (4 downto 0)
    );    
  end component; 
  
  component generic_laterial_shift is
    generic (
      bits : integer := 8
    );
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      enable          : in  std_logic;
      preset          : in  std_logic_vector(bits-1 downto 0);
      shift_in        : in  std_logic_vector(bits-1 downto 0);
      shift_out       : out std_logic_vector(bits-1 downto 0)
    );
  end component;

  component generic_2x1_mux is
    generic (
      bits : integer := 8
    );
    port (
      sel             : in  std_logic;
      a               : in  std_logic_vector(bits-1 downto 0);
      b               : in  std_logic_vector(bits-1 downto 0);
      output          : out std_logic_vector(bits-1 downto 0)
    );
  end component;
  
  component generic_nzero is
    generic (
      bits : integer := 8
    );
    port (
      sel             : in  std_logic_vector(bits-1 downto 0);
      output          : out std_logic
    );
  end component;
  
  component controller  is
    port (
      clk             : in std_logic; 
      reset           : in std_logic;
      execute_btn     : in std_logic;
      instruction     : out std_logic_vector (7 downto 0)
    );  
  end component; 
  
end control_parts;