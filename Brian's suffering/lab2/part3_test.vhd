--Testbench for BCD counter--
library IEEE;
use IEEE.std_logic_1164.all;

entity test_counter_99 is
end entity test_counter_99;

architecture test of test_counter_99 is
  signal t_Clk, t_Enable, t_init: std_logic;
  signal t_Q_out: std_logic_vector(7 downto 0);
  
  component up_counter is
    port(u_Clk, u_Enable, u_Reset: in std_logic;
        Counter_Out: out std_logic_vector(7 downto 0));
  end component up_counter;
  
  begin 
    DUT: up_counter
      port map (u_Clk => t_Clk, u_Enable => t_Enable, u_Reset => t_init, Counter_Out => t_Q_out);
    
    init: process 
    begin
      t_Enable <= '1', '0' after 270ns, '1' after 400ns, '0' after 790 ns, '1' after 870 ns;
      t_init <= '0', '1' after 586 ns, '0' after 600 ns,  '1' after 840 ns , '0' after 860 ns; --Reset--
      
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