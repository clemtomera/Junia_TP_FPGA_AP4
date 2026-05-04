LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY flipflop_JK IS
	PORT (
		-- Inputs
		J : IN STD_LOGIC; -- J input
		K : IN STD_LOGIC; -- K input
		CLK : IN STD_LOGIC; -- Clock (rising-edge triggered)
		-- Outputs
		Q : OUT STD_LOGIC; -- Flip flop output
		Qn : OUT STD_LOGIC -- Flip flop complemented output
	);
END flipflop_JK;
ARCHITECTURE behavioral OF flipflop_JK IS
	SIGNAL Q_internal : STD_LOGIC := '0';
BEGIN
	PROCESS (CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			IF (J = '0' AND K = '0') THEN
				Q_internal <= Q_internal; -- Pas de changement
			ELSIF (J = '0' AND K = '1') THEN
				Q_internal <= '0'; -- 0
			ELSIF (J = '1' AND K = '0') THEN
				Q_internal <= '1'; -- 1
			ELSE -- J = '1' AND K = '1'
				Q_internal <= NOT(Q_internal); -- Inverser
			END IF;
		END IF;
	END PROCESS;

	-- SORTIES
	Q  <= Q_internal;
	Qn <= NOT Q_internal;

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