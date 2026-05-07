LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

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
    -- division de la fréquence de clockin par 2^N+1
    -- implémentation d'un compteur synchrone à 24 bits
    SIGNAL counter : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');

BEGIN

    -- Processus : incrémentation synchrone du compteur
    PROCESS (CLKin)
    BEGIN
        IF rising_edge(CLKin) THEN
            IF RST = '0' THEN -- Reset actif à l'état bas
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;
        END IF;
    END PROCESS;

    -- Le bit N du compteur fournit CLKout = CLKin / 2^(N+1)
    CLKout <= counter(TO_INTEGER(UNSIGNED(N)));

END behavioral;