LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY full_adder_4bits IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- entrée 4b
        b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cin : IN STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Cout : OUT STD_LOGIC
    );
END full_adder_4bits;

-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF full_adder_4bits IS
    -- Retenues entre les étages
    SIGNAL c0, c1, c2 : STD_LOGIC;
BEGIN
    -- on appelle les full adders du tp précédent dans chaque entrée
    -- la retenue passe en cascade d'étage en étage 
    -- elle atterit sur une sortie dédéie de retenue pour pouvoir chainer des branchements
    FA0 : ENTITY work.full_adder PORT MAP (
        a => A(0),
        b => B(0),
        c_in => Cin,
        s => S(0),
        c_out => c0
        );

    FA1 : ENTITY work.full_adder PORT MAP (
        a => A(1),
        b => B(1),
        c_in => c0,
        s => S(1),
        c_out => c1
        );

    FA2 : ENTITY work.full_adder PORT MAP (
        a => A(2),
        b => B(2),
        c_in => c1,
        s => S(2),
        c_out => c2
        );

    FA3 : ENTITY work.full_adder PORT MAP (
        a => A(3),
        b => B(3),
        c_in => c2,
        s => S(3),
        c_out => Cout
        );
END behavioral;