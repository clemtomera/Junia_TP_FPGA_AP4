LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY full_adder IS
    PORT (
        a : IN STD_LOGIC;
        b : IN STD_LOGIC;
        c_in : IN STD_LOGIC;
        s : OUT STD_LOGIC;
        c_out : OUT STD_LOGIC
    );
END full_adder;

-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF full_adder IS
    signal s1     : std_logic;  -- somme du 1er half adder
    signal c_ab   : std_logic;
    signal c_ab_cin : std_logic;
BEGIN
    -- C_out c'eest les 2 C
    -- s c'est C_out et s de ad_Cin
    -- on doit faire 2 half adder mais avec des entrées différentes 
    -- donc : 
    -- 1er half adder : a, b => s1, c_ab
    -- 2ème half adder : s1, c_in => s, c_ab_cin
    half_adder_ab : ENTITY work.half_adder PORT MAP (
        a => a,
        b => b,
        s => s1,      
        c => c_ab
    );

    half_adder_cin : ENTITY work.half_adder PORT MAP (
        a => s1,     
        b => c_in,
        s => s,
        c => c_ab_cin
    );

    c_out <= c_ab OR c_ab_cin;
END behavioral;