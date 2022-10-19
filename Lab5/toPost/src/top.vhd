-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Lab_5 top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
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
    generic (
      bits    : integer := 4
    );
    port (
      clk               : in  std_logic;
      reset             : in  std_logic;
      async_in          : in  std_logic_vector (bits-1 downto 0);
      sync_out          : out std_logic_vector (bits-1 downto 0)
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
  
  component State_machine is
    port (
      clk             : in std_logic; 
      reset           : in std_logic;
      button          : in std_logic;
      state           : out std_logic_vector(3 downto 0)
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
  
  signal btn_sync     : std_logic;
  signal add_SUB      : std_logic;
  signal bcd          : std_logic_vector(8 downto 0);
  signal input_sync   : std_logic_vector(7 downto 0);
  signal a            : std_logic_vector(7 downto 0);
  signal b            : std_logic_vector(7 downto 0);
  signal state        : std_logic_vector(3 downto 0);
  signal ones         : std_logic_vector(3 downto 0);
  signal tens         : std_logic_vector(3 downto 0);
  signal hundreds     : std_logic_vector(3 downto 0);
  signal result       : std_logic_vector(8 downto 0);
  
  constant zero                : std_logic_vector(7 downto 0):= (others => '0');
  
  constant input_a             :std_logic_vector(3 downto 0) := "0001";
  constant input_b             :std_logic_vector(3 downto 0) := "0010";
  constant display_add         :std_logic_vector(3 downto 0) := "0100";
  constant display_sub         :std_logic_vector(3 downto 0) := "1000";
begin

  state_out <= state;
  
  process(reset,clk)
  begin
    if(reset = '1') then
      a <=  zero;
      b <=  zero;
    elsif rising_edge(clk) then  
       if(state =  input_a)then
        a <= input_sync;
       elsif(state =  input_b)then 
        b <= input_sync;
      end if ;
    end if;
  end process; 
  
  process(reset,clk)
  begin
    if(reset = '1') then
      add_SUB  <= '0';
    elsif rising_edge(clk) then 
      if(state =  display_add)then
        add_SUB <= '0';
      elsif(state =  display_sub)then 
        add_SUB <= '1';
      end if;
    end if;
  end process;
  
  process(reset,clk)
  begin
    if(reset = '1') then
      result <=  '0'& zero;
    elsif rising_edge(clk) then
      if(state =  input_a)then
        result <= '0' & a;
      elsif(state =  input_b)then 
        result <= '0' & b;
      elsif(state =  display_add)then 
        result <= bcd;
      elsif(state =  display_sub)then 
        result <= bcd;
      end if ;
    end if;
  end process;
  
  
  plus_one: generic_add_sub   
    generic map(
      bits => 8   
    )
    port map(        
      a              => a,
      b              => b,
      cin            => '0',
      add_SUB        => add_SUB,
      sum            => bcd(7 downto 0),
      cout           => bcd(8)
    );

  sync_add: rising_edge_synchronizer 
    port map(
      clk               => clk,
      reset             => reset,
      input             => btn,
      edge              => btn_sync
    );

  sync_a: synchronizer 
    generic map(
      bits => 8
    )
    port map(
      clk               => clk,
      reset             => reset,
      async_in          => input,
      sync_out          => input_sync
    );

  state_changer: State_machine  
    port map(        
      clk            => clk,
      reset          => reset,
      button         => btn_sync,
      state          => state
    );
    
  presto_chango: double_dabble
    generic map(
      bits => 9   
    )
    port map(
      input           =>result,
      ones            =>ones,
      tens            =>tens,
      hundreds        =>hundreds
    );  
  
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
    
end beh;