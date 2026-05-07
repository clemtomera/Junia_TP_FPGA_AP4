LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY toplevel_bistable IS
    PORT (
        CLOCK_50_B6A : IN  STD_LOGIC;
        KEY      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        LEDG     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END toplevel_bistable;

ARCHITECTURE structural OF toplevel_bistable IS


    SIGNAL led_state : STD_LOGIC;  -- sortie du bistable : 0=OFF, 1=ON

BEGIN

    U_BISTABLE : work.bistable
        PORT MAP (
            CLK => CLOCK_50_B6A,    
            RST => KEY(1),       
            X   => NOT KEY(0),   
            Y   => led_state
        );

    LEDG <= (OTHERS => led_state);

END structural;