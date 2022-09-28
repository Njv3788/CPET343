-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Counter top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    seven_seg_out   : out std_logic_vector(6 downto 0)
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

  component generic_adder_beh is
    generic (
      bits    : integer := 4
    );
    port (
      a       : in  std_logic_vector(bits-1 downto 0);
      b       : in  std_logic_vector(bits-1 downto 0);
      cin     : in  std_logic;
      sum     : out std_logic_vector(bits-1 downto 0);
      cout    : out std_logic
    );
  end component;

  component generic_counter is
    generic (
      max_count       : integer := 3
    );
    port (
      clk             : in  std_logic; 
      reset           : in  std_logic;
      output          : out std_logic
    );  
  end component;
  
  signal bcd          : std_logic_vector(3 downto 0);
  signal bcd_sig      : std_logic_vector(3 downto 0);
  signal cout         : std_logic;
  signal enable       : std_logic;       -- enable register
begin

  process(reset,clk)
  begin
    if(reset = '1') then                 -- reset 0
      bcd_sig  <= "0000";
    elsif(clk'event and clk = '1')  then -- on rising edge
      if(enable = '1') then              -- when enable
        if(bcd = "1010")then             -- if output of adder is 10
          bcd_sig <= "0000";             -- set to 0
        else
          bcd_sig <= bcd;                -- else bcd_sig gets bcd
        end if;
      end if;
    end if;
  end process;


  plus_one: generic_adder_beh           -- adder 
    generic map(
      bits => 4                         -- four bits
    )
    port map(        
      a              => "0001",         -- add 1
      b              =>  bcd_sig,
      cin            => '0',            -- set to 1
      sum            => bcd,            
      cout           => cout            -- do nothing
    );

  delay: generic_counter  
    generic map(
      max_count => 3                     -- 3  for sim and 50000000 for hw
    )
    port map(          
      clk            => clk,             
      reset          => reset,
      output         => enable           -- pulse to enable register
    );
  
  display: seven_seg  
    port map(        
      clk            => clk,
      reset          => reset,
      bcd            => bcd_sig,         -- count
      seven_seg_out  => seven_seg_out    -- display 
    );

end beh;