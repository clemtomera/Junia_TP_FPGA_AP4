LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY flipflop_JKrs IS
	PORT (
		J    : IN STD_LOGIC;
		K    : IN STD_LOGIC;
		CLK  : IN STD_LOGIC;
		SETn : IN STD_LOGIC; -- Set asynchrone actif bas
		RSTn : IN STD_LOGIC; -- Reset asynchrone actif bas
		--- Sorties
		Q    : OUT STD_LOGIC;
		Qn   : OUT STD_LOGIC
	);
END flipflop_JKrs;

ARCHITECTURE behavioral OF flipflop_JKrs IS
	SIGNAL Q_internal : STD_LOGIC := '0';
BEGIN

	PROCESS (CLK, SETn, RSTn)
	BEGIN
		-- ENTRÉES ASYNCHRONES
		IF (RSTn = '0') THEN
			Q_internal <= '0';
		ELSIF (SETn = '0') THEN
			Q_internal <= '1';

		-- FONCTIONNEMENT JK
		ELSIF (rising_edge(CLK)) THEN
			CASE (J & K) IS
				WHEN "00" => 
					Q_internal <= Q_internal;
				WHEN "01" => 
					Q_internal <= '0';
				WHEN "10" => 
					Q_internal <= '1';
				WHEN "11" => 
					Q_internal <= NOT Q_internal;
				WHEN OTHERS =>
					NULL;
			END CASE;
		END IF;
	END PROCESS;

	-- SORTIES
	Q  <= Q_internal;
	Qn <= NOT Q_internal;

END behavioral;