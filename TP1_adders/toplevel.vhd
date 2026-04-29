library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY toplevel IS
    PORT (
        HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END ENTITY;
-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF toplevel IS
    SIGNAL S : STD_LOGIC_VECTOR(3 DOWNTO 0); -- résultat de l'addition
    SIGNAL Cout : STD_LOGIC; -- retenue sortie (non utilisée ici)
BEGIN

    -- Additionneur 4 bits
    Fa4B : ENTITY work.full_adder_4bits PORT MAP (
        A => SW(3 DOWNTO 0), -- opérande A sur SW0-3
        B => SW(7 DOWNTO 4), -- opérande B sur SW4-7
        Cin => SW(9), -- retenue entrée sur SW9
        S => S,
        Cout => Cout
        );

    -- Affichage de A (SW3-0) sur HEX3
    SEG_A : ENTITY work.transcodeur_7seg PORT MAP (
        BIN => SW(3 DOWNTO 0),
        SEG => HEX3
        );

    -- Affichage de B (SW7-4) sur HEX2
    SEG_B : ENTITY work.transcodeur_7seg PORT MAP (
        BIN => SW(7 DOWNTO 4),
        SEG => HEX2
        );

    -- Affichage du résultat S sur HEX0
    SEG_S : ENTITY work.transcodeur_7seg PORT MAP (
        BIN => S,
        SEG => HEX0
        );

END behavioral;