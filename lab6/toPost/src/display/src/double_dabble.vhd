-------------------------------------------------------------------------------
-- Nathaniel Valla
-- Double Dabble
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity double_dabble is
  generic (
    bits    : integer := 10
  );
  port (
    input           : in  std_logic_vector(bits-1 downto 0);
    ones            : out std_logic_vector(3 downto 0);
    tens            : out std_logic_vector(3 downto 0);
    hundreds        : out std_logic_vector(3 downto 0)
  );  
end; 

architecture beh of double_dabble is
  signal   result_padded : STD_LOGIC_VECTOR (11 downto 0);
  constant pad           : STD_LOGIC_VECTOR (11-bits downto 0) :=(others => '0');
begin

  result_padded <= pad & input;
  bcd1: process(result_padded)
    -- temporary variable
    variable temp : STD_LOGIC_VECTOR (11 downto 0);
    
    -- variable to store the output BCD number
    -- organized as follows
    -- thousands = bcd(15 downto 12)
    -- hundreds = bcd(11 downto 8)
    -- tens = bcd(7 downto 4)
    -- units = bcd(3 downto 0)
    variable bcd : UNSIGNED (15 downto 0) := (others => '0');

    -- by
    -- https://en.wikipedia.org/wiki/Double_dabble
    
    begin
      -- zero the bcd variable
      bcd := (others => '0');
      
      -- read input into temp variable
      temp(11 downto 0) := result_padded;
      
      -- cycle 12 times as we have 12 input bits
      -- this could be optimized, we dont need to check and add 3 for the 
      -- first 3 iterations as the number can never be >4
      for i in 0 to 11 loop
        if bcd(3 downto 0) > 4 then 
          bcd(3 downto 0) := bcd(3 downto 0) + 3;
        end if;
        
        if bcd(7 downto 4) > 4 then 
          bcd(7 downto 4) := bcd(7 downto 4) + 3;
        end if;
      
        if bcd(11 downto 8) > 4 then  
          bcd(11 downto 8) := bcd(11 downto 8) + 3;
        end if;

        -- thousands can't be >4 for a 12-bit input number
        -- so don't need to do anything to upper 4 bits of bcd
      
        -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
        bcd := bcd(14 downto 0) & temp(11);
      
        -- shift temp left by 1 bit
        temp := temp(10 downto 0) & '0';
      
      end loop;
   
      -- set outputs
      ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
      tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
      hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
      --thousands <= STD_LOGIC_VECTOR(bcd(15 downto 12));
    end process bcd1; 
  
end beh;
