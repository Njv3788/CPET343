-- Dr. Kaputa
-- Lab 8: DJ Roomba 3000 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.control_parts.all;
use work.pro_parts.all;

entity dj_roomba_3000 is 
  port(
    clk                 : in std_logic;
    reset               : in std_logic;
    execute_btn         : in std_logic;
    sync                : in std_logic;
    led                 : out std_logic_vector(7 downto 0);
    audio_out           : out std_logic_vector(15 downto 0)
  );
end dj_roomba_3000;

architecture beh of dj_roomba_3000 is
  -- data memory
  component rom_data
    port(
      address  : in  std_logic_vector (13 downto 0);
      clock    : in  std_logic  := '1';
      q        : out std_logic_vector (15 downto 0)
    );
  end component;
  
  signal data_address  : std_logic_vector(13 downto 0);
  signal instruction   : std_logic_vector(7 downto 0);
begin
  -- data instantiation
  u_rom_data_inst : rom_data
    port map (
      address    => data_address,
      clock      => clk,
      q          => audio_out
    );
  
  -- loop audio file
  process(clk,reset)
  begin 
    if (reset = '1') then 
      data_address <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (sync = '1') then    
        data_address <= std_logic_vector(unsigned(data_address) + 1 );
      end if;
    end if;
  end process;

  head :controller
    port map(
      clk             => clk,
      reset           => reset,
      execute_btn     => execute_btn,
      instruction     => instruction
    );  
  
  corpus :processor
    port map(
      clk             => clk,
      reset           => reset,
      sync            => sync,
      instruction     => instruction
    );  
  
  led <= instruction;
end beh;