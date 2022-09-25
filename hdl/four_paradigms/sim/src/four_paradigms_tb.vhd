-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity four_paradigms_tb is
end four_paradigms_tb;

architecture arch of four_paradigms_tb is

component four_paradigms is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    a               : in  std_logic;
    b_comb          : out std_logic;
    b_sync          : out std_logic;
    b_conc          : out std_logic;
    b_sequ          : out std_logic
  );  
end component;  

constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal a            : std_logic := '0';
signal b_comb       : std_logic;
signal b_sync       : std_logic;
signal b_conc       : std_logic;
signal b_sequ       : std_logic;
    
begin

a <= not a after 33 ns;
  
-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 4 * period;
    reset <= '0';
    wait;
end process; 

uut1: four_paradigms  
  port map(
    clk       => clk,
    reset     => reset,
    a         => a,     
    b_comb    => b_comb,
    b_sync    => b_sync,
    b_conc    => b_conc,
    b_sequ    => b_sequ
  );
end arch;