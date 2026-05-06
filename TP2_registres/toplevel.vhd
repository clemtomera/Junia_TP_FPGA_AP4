library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity toplevel_register is
    Port (
        SW   : in  STD_LOGIC_VECTOR(9 downto 0);

        KEY  : in  STD_LOGIC_VECTOR(3 downto 0);

        LEDG : out STD_LOGIC_VECTOR(7 downto 0)
    );
end toplevel_register;

architecture Structural of toplevel_register is


    component shift_register_universal8
        Port (
            CLK  : in  STD_LOGIC;
            SETn : in  STD_LOGIC;
            RSTn : in  STD_LOGIC;
            SEL  : in  STD_LOGIC_VECTOR(2 downto 0);
            SSR  : in  STD_LOGIC;
            SSL  : in  STD_LOGIC;
            Pi   : in  STD_LOGIC_VECTOR(7 downto 0);
            SOR  : out STD_LOGIC;
            SOL  : out STD_LOGIC;
            Qo   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal clk_manual : STD_LOGIC;  

begin


    clk_manual <= not KEY(0);


    U_REG : shift_register_universal8
        port map (
            CLK  => clk_manual,

            RSTn => KEY(3),    
            SETn => KEY(2),    

            SEL  => SW(2 downto 0),

            SSR  => SW(9),    
            SSL  => SW(8),     

            Pi   => "00000000",

            SOR  => open,
            SOL  => open,

            Qo   => LEDG(7 downto 0)
        );

end Structural;