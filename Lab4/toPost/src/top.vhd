-------------------------------------------------------------------------------
-- Dr. Kaputa
-- blink top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    add             : in  std_logic;
    a               : in  std_logic_vector(2 downto 0);
    b               : in  std_logic_vector(2 downto 0);
    seven_seg_out   : out std_logic_vector(6 downto 0)
  );
end top;

architecture beh of top is

  component seven_seg is
    port (
      clk             : in std_logic; 
      reset           : in std_logic;
      bcd             : in std_logic_vector(3 downto 0);
      seven_seg_out   : out std_logic_vector(6 downto 0)
    );  
  end component;

  component generic_add_sub is
    generic (
      bits    : integer := 4
    );
    port (
      a       : in  std_logic_vector(bits-1 downto 0);
      b       : in  std_logic_vector(bits-1 downto 0);
      cin     : in  std_logic;
      add_Sub : in  std_logic;
      sum     : out std_logic_vector(bits-1 downto 0);
      cout    : out std_logic
    );
  end component;

  signal bcd      : std_logic_vector(3 downto 0);
  signal cout         : std_logic;
begin


  plus_one: generic_add_sub   
    generic map(
      bits => 3   
    )
    port map(        
      a              => a,
      b              => b,
      cin            => '0',
      add_Sub        => add,
      sum            => bcd(2 downto 0),
      cout           => bcd(3)
    );

  display: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => bcd,
      seven_seg_out  => seven_seg_out
    );

end beh;