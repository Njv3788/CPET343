-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture arch of top_tb is

  component top is
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      execute         : in  std_logic;
      one_out         : out std_logic_vector(6 downto 0);
      ten_out         : out std_logic_vector(6 downto 0);
      hun_out         : out std_logic_vector(6 downto 0);
      state_out       : out std_logic_vector(4 downto 0)
    );  
  end component; 


  constant period     : time := 20ns;

  signal output       : std_logic;
  signal clk          : std_logic := '0';
  signal reset        : std_logic := '0';
  signal execute      : std_logic := '0';
  signal op_code      : std_logic_vector(1 downto 0):= "00";
  signal state_tb     : std_logic_vector(4 downto 0);
  signal input        : std_logic_vector(7 downto 0):= "00000000";

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 4*period;   -- let all the initial conditions trickle throug
      
      for i in 0 to 31 loop
        execute <= not(execute); 
        wait for period;
        execute <= not(execute);
        wait for 20*period;
      end loop;
      
      report "****************** sequential testbench stop ****************";
      wait;
  end process; 
  
-- clock process
clock: process
  begin
    clk <= not clk;
    wait for period/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * period;
    reset <= '1';
    wait;
end process; 

uut: top  
  port map(        
    clk            => clk,
    reset          => reset,
    execute        => execute,
    state_out      => state_tb 
  );
end arch;