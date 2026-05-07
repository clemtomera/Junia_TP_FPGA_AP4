LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY toplevel_chenillard IS
    PORT (
        CLOCK_50_B6A : IN STD_LOGIC;
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END toplevel_chenillard;

ARCHITECTURE structural OF toplevel_chenillard IS
    SIGNAL clk_slow : STD_LOGIC;
    SIGNAL rst_chen : STD_LOGIC; -- reset adapté pour le chenillard
    SIGNAL rst_clk : STD_LOGIC; -- reset adapté pour le clock_divider

BEGIN
    -- KEY(0) vaut '0' au repos, '1' quand appuyé
    -- clock_divider : reset actif bas  → on branche KEY(0) directement
    -- chenillard    : reset actif haut → on inverse KEY(0)
    rst_clk <= KEY(0);
    rst_chen <= KEY(0);

    U_CLK_DIV : work.clock_divider
    PORT MAP(
        CLKin => CLOCK_50_B6A,
        RST => rst_clk, -- actif bas : '0' quand KEY(0) appuyé
        N => SW(4 DOWNTO 0),
        CLKout => clk_slow
    );

    U_CHENILLARD : work.chenillard
    PORT MAP(
        CLK => clk_slow,
        RST => rst_chen, -- actif haut : '1' quand KEY(0) appuyé
        CHEN => LEDR
    );

END structural;