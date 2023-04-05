--Testbench for BCD counter--
library IEEE;
use IEEE.std_logic_1164.all;

entity test_BCD_counter is
end entity test_BCD_counter;

architecture test of test_BCD_counter is
  signal t_Clk, t_Enable, t_Direction, t_init: std_logic;
  signal t_Q_out: std_logic_vector(3 downto 0);
  
  component BCD is
    port(Clk, Direction, Init, Enable: in std_logic;
          Q_out: out std_logic_vector(3 downto 0));
  end component BCD;
  
  begin 
    DUT: BCD
      port map (Clk => t_Clk, Enable => t_Enable, Direction => t_Direction, Init => t_init, Q_out => t_Q_out);
    
    init: process 
    begin
      --Somehow when enable is set to 1 at same time as init, it messes up, as it ain't resetted properly. 
      t_Enable <= '1', '0' after 600ns, '1' after 650ns, '0' after 700ns, '1' after 720ns ;
      t_init <= '1', '0' after 10ns , '1' after 450ns, '0' after 460ns, '1' after 727ns, '0' after 740ns;         t_Direction <= '1', '0' after 200ns, '1' after 400ns, '0' after 600ns, '1' after 800ns;
      wait;
    end process init;
    
    --Clock generator with frequency of 10ns--
    clk_gen: process
    begin
      t_Clk <= '1';
      wait for 5ns;
      t_Clk <= '0';
      wait for 5ns;
    end process clk_gen;
end architecture test;

--Every 200 does one full repeat. Therefore about 400ns to do 1 full repeat one way and 1 repeat the other way
--