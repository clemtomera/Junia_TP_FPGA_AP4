LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.all;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY clock_divider IS
    PORT (
        CLKin : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        N : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        CLKout : OUT STD_LOGIC
    );
END clock_divider;



-- implémentation du compteur synchrone à 24 bits 
-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF clock_divider IS

   
BEGIN
    
END behavioral;