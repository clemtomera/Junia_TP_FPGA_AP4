LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY Dflipflop IS
    PORT (
        -- Inputs
        D : IN STD_LOGIC; -- Data input
        CLK : IN STD_LOGIC; -- Clock (rising-edge triggered)
        -- Outputs
        Q : OUT STD_LOGIC; -- Flip flop output
        Qn : OUT STD_LOGIC -- Flip flop complemented output
    );
END Dflipflop;
ARCHITECTURE behavioral OF Dflipflop IS
BEGIN
    PROCESS (CLK)
    BEGIN
        IF (CLK'event AND CLK = '1') THEN
            Q <= D;
            Qn <= NOT(D);
        END IF;
    END PROCESS;
END behavioral;