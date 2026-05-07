LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

-- DESCRIPTION DES ENTREES/SORTIES DE L'ENTITY
ENTITY bistable IS
    PORT (
        CLK : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        X : IN STD_LOGIC;
        Y : OUT STD_LOGIC
    );
END bistable;

-- DESCRIPTION COMPORTEMENTALE DE L'ENTITY
ARCHITECTURE behavioral OF bistable IS
    TYPE state_type IS (a, b, c, d);
    SIGNAL current_state : state_type;
    SIGNAL future_state : state_type;

BEGIN

    PROCESS (CLK, RST)
    BEGIN
        IF RST = '0' THEN
            current_state <= a;
        ELSE
            IF rising_edge(CLK) THEN
                current_state <= future_state;
            END IF;
        END IF;

    END PROCESS;

    PROCESS (current_state, X)
    BEGIN
        CASE current_state IS
            WHEN a =>
                Y <= '0';
                IF X = '0' THEN
                    future_state <= a;
                ELSE
                    future_state <= b;
                END IF;
            WHEN b =>
                Y <= '1';
                IF X = '0' THEN
                    future_state <= c;
                ELSE
                    future_state <= b;
                END IF;
            WHEN c =>
                Y <= '1';
                IF X = '0' THEN
                    future_state <= c;
                ELSE
                    future_state <= d;
                END IF;
            WHEN d =>
                Y <= '0';
                IF X = '0' THEN
                    future_state <= a;
                ELSE
                    future_state <= d;
                END IF;
            WHEN OTHERS =>
                Y <= 'X';
                future_state <= a;

        END CASE;

    END PROCESS;
END behavioral;