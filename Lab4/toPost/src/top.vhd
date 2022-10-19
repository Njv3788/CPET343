-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab 4 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    add             : in  std_logic;
    sub             : in  std_logic;
    a               : in  std_logic_vector(2 downto 0);
    b               : in  std_logic_vector(2 downto 0);
    a_out           : out std_logic_vector(6 downto 0);
    b_out           : out std_logic_vector(6 downto 0);
    result_out      : out std_logic_vector(6 downto 0)
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

  component synchronizer is 
    port (
      clk               : in  std_logic;
      reset             : in  std_logic;
      async_in          : in  std_logic_vector (2 downto 0);
      sync_out          : out std_logic_vector (2 downto 0)
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
      add_SUB : in  std_logic;
      sum     : out std_logic_vector(bits-1 downto 0);
      cout    : out std_logic
    );
  end component;
  
  component rising_edge_synchronizer is 
  port (
    clk               : in std_logic;
    reset             : in std_logic;
    input             : in std_logic;
    edge              : out std_logic
  );
  end component;

  signal bcd          : std_logic_vector(3 downto 0);
  signal cout         : std_logic;
  signal add_sync     : std_logic;
  signal sub_sync     : std_logic;
  signal add_SUB      : std_logic;
  signal a_sync        : std_logic_vector(2 downto 0);
  signal b_sync        : std_logic_vector(2 downto 0);
  signal a_guard       : std_logic_vector(3 downto 0);
  signal b_guard       : std_logic_vector(3 downto 0);
begin

  a_guard <= '0' & a_sync;  -- extend to 4 bits for BCD
  b_guard <= '0' & b_sync;  -- extend to 4 bits for BCD
  
  process(clk ,reset)       -- change for a to subtract
  begin
    if(reset ='1') then
      add_Sub <= '0';
    elsif rising_edge(clk) then 
      if(add_sync ='1') then
        add_SUB <= '0';
      elsif (sub_sync = '1') then
        add_SUB <= '1';
      end if;
    end if;
  end process;

  plus_one: generic_add_sub   
    generic map(
      bits => 3   
    )
    port map(        
      a              => a_sync,
      b              => b_sync,
      cin            => '0',
      add_SUB        => add_SUB,
      sum            => bcd(2 downto 0),
      cout           => bcd(3)
    );

  display_result: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => bcd,
      seven_seg_out  => result_out
    );
  
  display_a: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => a_guard,
      seven_seg_out  => a_out
    );
  
  display_b: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => b_guard,
      seven_seg_out  => b_out
    );
    
  sync_add: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset,
      input             => add,
      edge              => add_sync
    );
  
  sync_sub: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset,
      input             => sub,
      edge              => sub_sync
    );

  sync_a: synchronizer 
    port map(
      clk               => clk,
      reset             => reset,
      async_in          => a,
      sync_out          => a_sync
    );
  
  sync_b: synchronizer 
    port map(
      clk               => clk,
      reset             => reset,
      async_in          => b,
      sync_out          => b_sync
    );
end beh;