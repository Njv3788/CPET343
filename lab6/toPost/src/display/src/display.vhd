-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_5 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity display is
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
end display;

architecture beh of display is
  
  component seven_seg is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      bcd             : in  std_logic_vector(3 downto 0);
      seven_seg_out   : out std_logic_vector(6 downto 0)
    );  
  end component;
  
  component double_dabble is
    generic (
      bits    : integer := 10
    );
    port (
      input           : in  std_logic_vector(bits-1 downto 0);
      ones            : out std_logic_vector(3 downto 0);
      tens            : out std_logic_vector(3 downto 0);
      hundreds        : out std_logic_vector(3 downto 0)
    );  
  end component; 
  
  signal ones               : std_logic_vector(3 downto 0);
  signal tens               : std_logic_vector(3 downto 0);
  signal hundreds           : std_logic_vector(3 downto 0);
  
begin
  
  
  display_one: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => ones,
      seven_seg_out  => one_out
    );
  
  display_ten: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => tens,
      seven_seg_out  => ten_out
    );
    
  display_hun: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => hundreds,
      seven_seg_out  => hun_out
    );
  
  presto_chango: double_dabble
    generic map(
      bits => bits   
    )
    port map(
      input           =>input,
      ones            =>ones,
      tens            =>tens,
      hundreds        =>hundreds
    );  

end beh;