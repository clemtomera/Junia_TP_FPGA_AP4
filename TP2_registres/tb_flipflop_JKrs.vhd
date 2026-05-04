LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_flipflop_JKrs IS
END ENTITY;

ARCHITECTURE tb OF tb_flipflop_JKrs IS

    -- Signaux de test
    SIGNAL J    : STD_LOGIC := '0';
    SIGNAL K    : STD_LOGIC := '0';
    SIGNAL CLK  : STD_LOGIC := '0';
    SIGNAL SETn : STD_LOGIC := '1';
    SIGNAL RSTn : STD_LOGIC := '1';
    SIGNAL Q    : STD_LOGIC;
    SIGNAL Qn   : STD_LOGIC;

BEGIN

    -- Instanciation (UUT)
    UUT : ENTITY work.flipflop_JKrs
        PORT MAP (
            J    => J,
            K    => K,
            CLK  => CLK,
            SETn => SETn,
            RSTn => RSTn,
            Q    => Q,
            Qn   => Qn
        );

    -- Générateur d'horloge (période = 10 ns)
    CLK <= NOT CLK AFTER 5 ns;

    -- Stimuli
    stimuli : PROCESS
    BEGIN

        ----------------------------------------------------------------
        -- TEST RESET ASYNCHRONE
        ----------------------------------------------------------------
        RSTn <= '0'; SETn <= '1'; WAIT FOR 10 ns;
        RSTn <= '1'; WAIT FOR 10 ns;

        ----------------------------------------------------------------
        -- TEST SET ASYNCHRONE
        ----------------------------------------------------------------
        SETn <= '0'; WAIT FOR 10 ns;
        SETn <= '1'; WAIT FOR 10 ns;

        ----------------------------------------------------------------
        -- TEST JK : HOLD (J=0, K=0)
        ----------------------------------------------------------------
        J <= '0'; K <= '0'; WAIT FOR 20 ns;

        ----------------------------------------------------------------
        -- TEST JK : RESET (J=0, K=1)
        ----------------------------------------------------------------
        J <= '0'; K <= '1'; WAIT FOR 20 ns;

        ----------------------------------------------------------------
        -- TEST JK : SET (J=1, K=0)
        ----------------------------------------------------------------
        J <= '1'; K <= '0'; WAIT FOR 20 ns;

        ----------------------------------------------------------------
        -- TEST JK : TOGGLE (J=1, K=1)
        ----------------------------------------------------------------
        J <= '1'; K <= '1'; WAIT FOR 40 ns;

        ----------------------------------------------------------------
        -- TEST PRIORITÉ RESET sur SET
        ----------------------------------------------------------------
        SETn <= '0'; RSTn <= '0'; WAIT FOR 10 ns;
        SETn <= '1'; RSTn <= '1'; WAIT FOR 20 ns;

        ----------------------------------------------------------------
        -- FIN
        ----------------------------------------------------------------
        WAIT;

    END PROCESS;

END tb;