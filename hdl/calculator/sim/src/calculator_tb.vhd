-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculator_tb is
end calculator_tb;

architecture arch of calculator_tb is

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
  end component; 


  constant period     : time := 20ns;
  constant delay      : integer := 4;

  signal clk          : std_logic := '0';
  signal reset        : std_logic := '1';
  signal execute      : std_logic := '0';
  signal memory_save  : std_logic := '0';
  signal memory_recall: std_logic := '0';
  signal op_code      : std_logic_vector(1 downto 0):= "00";
  signal state_tb     : std_logic_vector(4 downto 0);
  signal input        : std_logic_vector(7 downto 0):= "00000000";

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 4*period;   -- let all the initial conditions trickle through
      input <= "00000100";
      
      execute <= not(execute); 
      wait for period;
      execute <= not(execute);
      wait for delay*period;
      
      input   <= "00001000";
      op_code <= "10";

      
      execute <= not(execute); 
      wait for period;
      execute <= not(execute);
      wait for delay*period;
      
      memory_save <= not(memory_save);
      wait for period;
      memory_save <= not(memory_save);
      wait for delay*period;
       
      op_code <= "01";
      
      execute <= not(execute); 
      wait for period;
      execute <= not(execute);
      wait for delay*period;
      
      input   <= "00000010";
      op_code <= "11";
      
      execute <= not(execute); 
      wait for period;
      execute <= not(execute);
      wait for delay*period;
      
      memory_recall <= not(memory_recall);
      wait for period;
      memory_recall <= not(memory_recall);
      wait for (delay)*period;
      
      execute <= not(execute); 
      wait for period;
      execute <= not(execute);
      wait for delay*period;
      
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
    reset <= '0';
    wait;
end process; 

uut: calculator 
  port map(        
    clk            => clk,
    reset          => reset,
    execute        => execute,
    memory_save    => memory_save ,
    memory_recall  => memory_recall,
    op_code        => op_code,
    input          => input,
    state_out      => open 
  );
end arch;