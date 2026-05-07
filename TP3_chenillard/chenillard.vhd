LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY chenillard IS
    PORT (
        CLK : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        CHEN : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END chenillard;

-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF chenillard IS
    TYPE state_type IS (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);

    SIGNAL current_state : state_type;
    SIGNAL future_state : state_type;
BEGIN

    PROCESS (CLK, RST)
    BEGIN
        IF RST = '0' THEN
            current_state <= s1;
        ELSIF CLK'EVENT AND CLK = '1' THEN
            current_state <= future_state;
        END IF;
    END PROCESS;

    PROCESS (current_state)
    BEGIN
        CASE current_state IS
            WHEN s1 =>
                CHEN <= "0000001111";
                future_state <= s2;
            WHEN s2 =>
                CHEN <= "0000011110";
                future_state <= s3;
            WHEN s3 =>
                CHEN <= "0000111100";
                future_state <= s4;
            WHEN s4 =>
                CHEN <= "0001111000";
                future_state <= s5;
            WHEN s5 =>
                CHEN <= "0011110000";
                future_state <= s6;
            WHEN s6 =>
                CHEN <= "0111100000";
                future_state <= s7;
            WHEN s7 =>
                CHEN <= "1111000000";
                future_state <= s8;
            WHEN s8 =>
                CHEN <= "1110000001";
                future_state <= s9;
            WHEN s9 =>
                CHEN <= "1100000011";
                future_state <= s10;
            WHEN s10 =>
                CHEN <= "1000000111";
                future_state <= s1;
            WHEN OTHERS =>
                CHEN <= "0101010101";
                future_state <= s1;
        END CASE;
    END PROCESS;
END behavioral;