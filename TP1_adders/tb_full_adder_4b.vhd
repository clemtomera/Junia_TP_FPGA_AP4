LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_full_adder_4b IS
END ENTITY tb_full_adder_4b;  

ARCHITECTURE tb OF tb_full_adder_4b IS
    -- Déclaration des signaux de test
    -- ex. signal A, S: std_logic;

    SIGNAL a, b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Cin : STD_LOGIC;
    SIGNAL Cout : STD_LOGIC;

BEGIN
    -- Instanciation de l'entité testée, récupérée dans la librairie work
    -- On appelle cette instance UUT (Unit Under Test)
    UUT : ENTITY work.full_adder_4bits PORT MAP (
        A => A,
        B => B,
        Cin => Cin,
        S => S,
        Cout => Cout
        );

    -- Description des stimuli
    -- A placer dans des *process*, car ce sont des instructions séquentielles
    -- (Plusieurs process concurrents peuvent être décrits)
    stimuli1 : PROCESS
    BEGIN
        -- ex. A <= '0';
        -- ex. wait for 10ns; -- Délai avant le prochain stimulus
        -- ex. A <= '1';
        -- ex. wait for 10ns; -- Délai avant le prochain stimulus

        A <= "0000"; B <= "0000"; Cin <= '0'; WAIT FOR 20 ns;
        --1 + 1 + 0 = 2
        A <= "0001"; B <= "0001"; Cin <= '0'; WAIT FOR 20 ns;
        --7 + 8 + 0 = 15
        A <= "0111"; B <= "1000"; Cin <= '0'; WAIT FOR 20 ns;
        --15 + 1 + 0 = 16 (Retenue=1, S=0000)
        A <= "1111"; B <= "0001"; Cin <= '0'; WAIT FOR 20 ns;

        WAIT; -- Wait indefinitely

    END PROCESS;
END tb;