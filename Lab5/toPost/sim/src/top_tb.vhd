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
    btn             : in  std_logic;
    input           : in  std_logic_vector(7 downto 0);
    state_out       : out std_logic_vector(3 downto 0);
    one_out         : out std_logic_vector(6 downto 0);
    ten_out         : out std_logic_vector(6 downto 0);
    hun_out         : out std_logic_vector(6 downto 0)
  );  
end component; 


constant period     : time := 20ns;

signal output       : std_logic;
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal btn          : std_logic := '1';
signal input_tb     : std_logic_vector(7 downto 0) := (others => '0'); 

begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 80 ns;   -- let all the initial conditions trickle through
      for i in 0 to 30 loop
        wait for 20 ns;
        if (i = 0) then 
          input_tb <= "00000101";
        elsif (i = 2) then
          input_tb <= "00000010";
        elsif (i = 8) then 
          input_tb <= "00000010";
        elsif (i = 10) then
          input_tb <= "00000101";
        elsif (i = 16) then
          input_tb <= "11001000";
        elsif (i = 18) then 
          input_tb <= "01100100";
        elsif (i = 24) then
          input_tb <= "01100100";
        elsif (i = 26) then 
          input_tb <= "11001000";
        end if;
        wait for 20 ns;
        btn <= not(btn); 
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
    reset <= '0';
    wait;
end process; 

uut: top  
  port map(        
    clk            => clk,
    reset          => reset,
    btn            => btn,
    input          => input_tb,
    one_out        => open
  );
end arch;