-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity program_counter is
  generic (
    bits    : integer := 5
  );
  port (
    clk             : in  std_logic; 
    reset           : in  std_logic;
    enable          : in  std_logic_vector(1 downto 0);
    jmp2addy        : in  std_logic_vector(bits-1 downto 0);
    address         : out std_logic_vector(bits-1 downto 0)
  );  
end program_counter;

architecture beh of program_counter  is

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
  end component generic_adder_beh;

  constant zeros      : std_logic_vector(bits-1 downto 0) := (others => '0');
  signal address_sig  : std_logic_vector(bits-1 downto 0);
  signal next_address : std_logic_vector(bits-1 downto 0);
  signal address_pls1 : std_logic_vector(bits-1 downto 0);
  signal one          : std_logic_vector(bits-1 downto 0);
  signal cout         : std_logic;

begin
  address <= address_sig;
  one(bits-1 downto 1) <= (others => '0') ;
  one(0) <= '1';
  
  process(reset,clk)
  begin
    if reset = '1' then
      address_sig <= zeros;
    elsif clk'event and clk = '1' then
      address_sig <= next_address;
    end if;
  end process;
  
  process(enable,address_sig,address_pls1,jmp2addy)
  begin
    case enable is
      when "01"=> next_address <= address_pls1;
      when "10"=> next_address <= jmp2addy;
      when "11"=> next_address <= zeros;
      when others => next_address <=address_sig;
    end case;
  end process;
  
  add_1: generic_adder_beh  
    generic map (
      bits => bits
    )
    port map(
      a       => one,
      b       => address_sig,
      cin     => '0',
      sum     => address_pls1,
      cout    => cout
    );
  
  
end beh;