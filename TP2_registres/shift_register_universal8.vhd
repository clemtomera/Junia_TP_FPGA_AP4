LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY shift_register_universal8 IS
    PORT (
        SSR : IN STD_LOGIC; -- Serial Shift Right input
        SSL : IN STD_LOGIC; -- Serial Shift Left input
        Pi : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Parallel input
        SEL : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Select input
        CLK : IN STD_LOGIC; -- Clock input
        SETn : IN STD_LOGIC; -- Asynchronous set (active low)
        RSTn : IN STD_LOGIC; -- Asynchronous reset (active low)
        --- Sorties
        SOR : OUT STD_LOGIC; -- Serial Output Right
        SOL : OUT STD_LOGIC; -- Serial Output Left
        Qo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Parallel Output
    );
END ENTITY;
ARCHITECTURE behavioral OF shift_register_universal8 IS
    SIGNAL reg : STD_LOGIC_VECTOR(7 DOWNTO 0);-- Registre de stockage
BEGIN
    -- Ecrire ici les instructions cocurrentes décrivant le comportement de l'entity
    -- ex. X <= not(A);
    -- ex. S <= not(X);
    PROCESS (CLK, SETn, RSTn)
    BEGIN
        -- ENTRÉES ASYNCHRONES -- va overide sur tout le reste 
        IF (RSTn = '0') THEN
            reg <= (OTHERS => '0');
        ELSIF (SETn = '0') THEN
            reg <= (OTHERS => '1');

            -- FONCTIONNEMENT DU REGISTRE
        ELSIF (rising_edge(CLK)) THEN
            CASE SEL IS
                WHEN "000" | "100" =>
                    reg <= reg;
                WHEN "011" | "111" => -- parallel load  
                    reg <= Pi;
                WHEN "001" => -- shift right 
                    reg <= SSR & reg(7 DOWNTO 1);
                WHEN "010" => -- shift left
                    reg <= reg(6 DOWNTO 0) & SSL;
                WHEN "101" => -- rotate right
                    reg <= reg(0) & reg(7 DOWNTO 1);
                WHEN "110" => -- rotate left
                    reg <= reg(6 DOWNTO 0) & reg(7);
                WHEN OTHERS => -- defualt 
                    reg <= reg;

            END CASE;

        END IF;
    END PROCESS;
    Qo <= reg;
    SOR <= reg(0);
    SOL <= reg(7);
END behavioral;