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