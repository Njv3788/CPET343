LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY half_adder IS
     PORT(a      :IN  STD_LOGIC;
	      b      :IN  STD_LOGIC;
		  cin    :IN  STD_LOGIC:
		  
		  s      :OUT STD_LOGIC;
		  cout   :OUT STD_LOGIC);
END half adder;

ARCHITECTURE behavior of half_adder is 
    SIGNAL inputs     :STD_LOGIC_VECTOR(2 DOWNTO 0);
	BEGIN
	    inputs <= a & b & c;
        
		PROCESS (inputs) 
             BEGIN
	             CASE inputs IS 	
		             WHEN "001" | "010" | "100" | "111" => cout <= 1;
					 WHEN OTHERS => cout <= 0;
				 END CASE:
		END PROCESS
		
		PROCESS (inputs)
             BEGIN
			     CASE inputs IS 
				     WHEN "011" | "101" | "111" => s <= 1;
					 WHEN OTHERS => s <=0
			     END CASE 
		END PROCESS
end behavior;

