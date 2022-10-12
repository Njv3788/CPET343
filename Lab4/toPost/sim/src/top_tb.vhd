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
    clk             : in std_logic; 
    reset           : in std_logic;
    add             : in  std_logic;
    sub             : in  std_logic;
    a               : in std_logic_vector(2 downto 0);
    b               : in std_logic_vector(2 downto 0);
    a_out           : out std_logic_vector(6 downto 0);
    b_out           : out std_logic_vector(6 downto 0);
    result_out      : out std_logic_vector(6 downto 0)
  );  
end component; 

signal output       : std_logic;
constant period     : time := 20ns;                                              
signal clk          : std_logic := '0';
signal reset        : std_logic := '1';
signal add          : std_logic := '0';
signal sub          : std_logic := '0';
signal a_tb            : std_logic_vector(2 downto 0) := "000";
signal b_tb            : std_logic_vector(2 downto 0) := "000";
signal a_out           : std_logic_vector(6 downto 0);
signal b_out           : std_logic_vector(6 downto 0);
begin

sequential_tb : process 
    begin
      report "****************** sequential testbench start ****************";
      wait for 60 ns;   -- let all the initial conditions trickle through
      for k in 0 to 1 loop
        
        case k is 
          when 0 =>add <= '1';
          when others => add <= '0';
        end case;
        
         case k is 
          when 0 =>sub <= '0';
          when others => sub <= '1';
        end case;
        
        wait for 1 ns;
        
        
        for i in 0 to 7 loop
          a_tb <= std_logic_vector(unsigned(a_tb) + 1 );  
            for j in 0 to 7 loop
              b_tb <= std_logic_vector(unsigned(b_tb) + 1 );
              wait for 40 ns;
            end loop;
        end loop;
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
    add            => add,
    sub            => sub,
    a              => a_tb,
    b              => b_tb,
    a_out          => a_out,
    b_out          => b_out,
    result_out     => open
  );
end arch;
