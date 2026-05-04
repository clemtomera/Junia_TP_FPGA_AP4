LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY JKflipflop IS
    PORT (
        -- Inputs
        J : IN STD_LOGIC; -- Data input
        K : IN STD_LOGIC; -- Data input
        CLK : IN STD_LOGIC; -- Clock (rising-edge triggered)
        -- Outputs
        Q : OUT STD_LOGIC; -- Flip flop output
        Qn : OUT STD_LOGIC -- Flip flop complemented output
    );
END JKflipflop;
ARCHITECTURE behavioral OF JKflipflop IS
BEGIN
    PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            Q <= J AND NOT(K);
            Qn <= K AND NOT(J);
        END IF;
    END PROCESS;
END behavioral;