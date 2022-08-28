LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY half_adder IS
     PORT(a      :IN  STD_LOGIC;
	      b      :IN  STD_LOGIC;
		  cin    :IN  STD_LOGIC:
		  
		  s      :OUT STD_LOGIC;
		  cout   :OUT STD_LOGIC);
END half adder;

ARCHITECTURE structural of half_adder is 
	BEGIN
	s      <= ((a xor b) xor cin);
    cout   <= ((a and b) or (cin and ( a xor b)));     
end structural;