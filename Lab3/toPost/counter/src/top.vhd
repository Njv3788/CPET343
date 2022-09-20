-------------------------------------------------------------------------------
-- Nathaniel Valla
-- counter_top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic_vector(6 downto 0)
  );
end top;

architecture beh of top is

component generic_counter is
  generic (
    max_count       : integer range 0 to 100 := 3
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    output          : out std_logic
  );  
end component;  

component generic_adder_beh is
  generic (
    bits    : integer := 4
  );
  port (
    a       : in  std_logic_vector(bits-1 downto 0);
    b       : in  std_logic_vector(bits-1 downto 0);
    cin     : in  std_logic;
    sum     : out std_logic_vector(bits-1 downto 0);
    cout    : out std_logic
  );
end component;  

component seven_sign is
  port (
    clk             : in std_logic; 
    reset           : in std_logic;
    bcd             : in std_logic_vector(3 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );  
end component;  

begin

counter: generic_counter 
  generic map (
    max_count => 50000000
  )
  port map(
    clk       => clk,
    reset     => reset,
    output    => output
  );
  
adder: generic_adder_beh
  generic map (
    bits => 4
  )
  port map(
    a        =>
    b        =>
    cin      =>
    sum      =>
    cout     =>
  );         
  
bcd: seven_sign
  port map(
    clk           =>
    reset         =>
    bcd           =>
    seven_seg_out =>
  );         
end beh;