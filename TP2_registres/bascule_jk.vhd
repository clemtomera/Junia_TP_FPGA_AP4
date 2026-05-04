LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY JKflipflop IS
	PORT (
		-- Inputs
		J : IN STD_LOGIC; -- J input
		K : IN STD_LOGIC; -- K input
		CLK : IN STD_LOGIC; -- Clock (rising-edge triggered)
		-- Outputs
		Q : OUT STD_LOGIC; -- Flip flop output
		Qn : OUT STD_LOGIC -- Flip flop complemented output
	);
END JKflipflop;
ARCHITECTURE behavioral OF JKflipflop IS
	SIGNAL Q_internal : STD_LOGIC := '0';
BEGIN
	PROCESS (CLK)
	BEGIN
		IF (CLK'event AND CLK = '1') THEN
			IF (J = '0' AND K = '0') THEN
				Q <= Q_internal; -- Pas de changement
				Qn <= NOT(Q_internal);
			ELSIF (J = '0' AND K = '1') THEN
				Q <= '0'; -- 0
				Qn <= '1';
			ELSIF (J = '1' AND K = '0') THEN
				Q <= '1'; -- 1
				Qn <= '0';
			ELSE -- J = '1' AND K = '1'
				Q <= NOT(Q_internal); -- Inverser
				Qn <= Q_internal;
			END IF;
		END IF;
	END PROCESS;
END behavioral;


-- Bascule JK Table caractéristique -- 

-- | J | K | Q(t) || Q(t+1) | Qn(t+1)
-- | 0 | 0 |   0  ||    0   | 1 
-- | 0 | 0 |   1  ||    1   | 0 
-- | 0 | 1 |   0  ||    0   | 1 
-- | 0 | 1 |   1  ||    0   | 1 
-- | 1 | 0 |   0  ||    1   | 0 
-- | 1 | 0 |   1  ||    1   | 0 
-- | 1 | 1 |   0  ||    1   | 0 
-- | 1 | 1 |   1  ||    0   | 1  