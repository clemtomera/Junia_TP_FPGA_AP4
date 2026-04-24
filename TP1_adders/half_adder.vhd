library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
	port (
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		c : out std_logic

	);
end half_adder;

-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
architecture behavioral of half_adder is
	
begin
    -- Ecrire ici les instructions cocurrentes décrivant le comportement de l'entity
	-- ex. X <= not(A);
	-- ex. S <= not(X);
	c <= a and b; 
	s <= a xor b; 
end behavioral;
