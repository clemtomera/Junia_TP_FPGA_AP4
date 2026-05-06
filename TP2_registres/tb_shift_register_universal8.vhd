library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- test bench réalisé avec Claude dans la majorité 

entity tb_shift_register_universal8 is
end tb_shift_register_universal8;

architecture Behavioral of tb_shift_register_universal8 is


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

    signal CLK  : STD_LOGIC := '0';
    signal SETn : STD_LOGIC := '1';
    signal RSTn : STD_LOGIC := '1';
    signal SEL  : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal SSR  : STD_LOGIC := '0';
    signal SSL  : STD_LOGIC := '0';
    signal Pi   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    signal SOR  : STD_LOGIC;
    signal SOL  : STD_LOGIC;
    signal Qo   : STD_LOGIC_VECTOR(7 downto 0);

    constant CLK_PERIOD : time := 20 ns;  
begin

    DUT : shift_register_universal8
        port map (
            CLK  => CLK,
            SETn => SETn,
            RSTn => RSTn,
            SEL  => SEL,
            SSR  => SSR,
            SSL  => SSL,
            Pi   => Pi,
            SOR  => SOR,
            SOL  => SOL,
            Qo   => Qo
        );


    CLK <= not CLK after CLK_PERIOD / 2;

    stim_proc : process
    begin

  
        report "=== PHASE 1: Asynchronous Reset ===";
        RSTn <= '0';
        SETn <= '1';
        SEL  <= "000";
        wait for 15 ns;  
        RSTn <= '1';
        wait for CLK_PERIOD;

      
        report "=== PHASE 2: Asynchronous Preset ===";
        SETn <= '0';
        wait for 15 ns;
        SETn <= '1';
        wait for CLK_PERIOD;

        report "=== PHASE 3: Hold (SEL=000) ===";
        SEL <= "000";
        wait for 3 * CLK_PERIOD;

        report "=== PHASE 3b: Hold (SEL=100) ===";
        SEL <= "100";
        wait for 3 * CLK_PERIOD;
    
        report "=== PHASE 4: Parallel Load 0xA5 (SEL=011) ===";
        Pi  <= "10100101";   
        SEL <= "011";
        wait for CLK_PERIOD;
   

        report "=== PHASE 4b: Parallel Load 0x3C (SEL=111) ===";
        Pi  <= "00111100";  
        SEL <= "111";
        wait for CLK_PERIOD;
        
        report "=== PHASE 5: Shift Right (SEL=001, SSR=0) ===";
        SEL <= "001";
        SSR <= '0';
        wait for 3 * CLK_PERIOD;


        report "=== PHASE 5b: Shift Right (SEL=001, SSR=1) ===";
        SSR <= '1';
        wait for 3 * CLK_PERIOD;

        report "=== PHASE 6: Parallel Reload 0xA5 then Shift Left ===";
        Pi  <= "10100101";
        SEL <= "011";
        wait for CLK_PERIOD;

        report "=== PHASE 6b: Shift Left (SEL=010, SSL=0) ===";
        SEL <= "010";
        SSL <= '0';
        wait for 3 * CLK_PERIOD;
        
        report "=== PHASE 6c: Shift Left (SEL=010, SSL=1) ===";
        SSL <= '1';
        wait for 3 * CLK_PERIOD;

        
        report "=== PHASE 7: Parallel Load 0x81 then Rotate Right ===";
        Pi  <= "10000001";
        SEL <= "011";
        wait for CLK_PERIOD;

        report "=== PHASE 7b: Rotate Right (SEL=101) ===";
        SEL <= "101";
        wait for 8 * CLK_PERIOD;

        report "=== PHASE 8: Parallel Load 0x81 then Rotate Left ===";
        Pi  <= "10000001";
        SEL <= "011";
        wait for CLK_PERIOD;

        report "=== PHASE 8b: Rotate Left (SEL=110) ===";
        SEL <= "110";
        wait for 8 * CLK_PERIOD;
        
        report "=== PHASE 9: Async Reset during Rotate Left ===";
        SEL  <= "110";    -- Rotate left still active
        wait for CLK_PERIOD / 2;   -- In the middle of a clock period
        RSTn <= '0';
        wait for 10 ns;
        RSTn <= '1';
        wait for CLK_PERIOD;

        
        report "=== SIMULATION COMPLETE ===";
        wait;

    end process;

end Behavioral;