-------------------------------------------------------------------------------
-- Dr. Kaputa
-- file io advanced tb demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use std.textio.all;

entity file_io_advanced_tb is
end file_io_advanced_tb;

architecture beh of file_io_advanced_tb is
  constant period     : time := 20ns;                                              
  signal clk          : std_logic := '0';
  signal reset        : std_logic := '1';

begin

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

read_file: process is
  variable input_line       : line;
  variable next_time        : time;
  variable btn              : bit;
  variable btn_std_logic    : std_logic;
  variable switch           : bit_vector(7 downto 0); 
  variable switch_std_logic : std_logic_vector(7 downto 0);
  file input_file           : text;
begin
  file_open(input_file,"input.txt",READ_MODE);
  readline(input_file,input_line);    -- strip off the header
  while not endfile(input_file) loop
    readline(input_file,input_line);
    -- read three fields from input file
    read(input_line,next_time);
    read(input_line,btn);
    read(input_line,switch);

    switch_std_logic := to_stdlogicvector(switch);
    btn_std_logic := to_stdulogic(btn);
    wait for next_time - now;
  end loop;
  file_close(input_file);
  wait;
end process read_file;
end architecture beh;