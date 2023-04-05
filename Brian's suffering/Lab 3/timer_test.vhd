library ieee;
use ieee.std_logic_1164.all;

entity timer_test is
end entity timer_test;

architecture test of timer_test is
  
  signal set_clk, start, isEqual: std_logic;
  signal conv_clk: std_logic;
  signal setStop: std_logic_vector(9 downto 0);
  signal minOut: std_logic_vector(6 downto 0);
  signal secOut: std_logic_vector(13 downto 0);
  --signal u_Enable: std_logic;
  --signal u_reset: std_logic := '0';
  --signal sec_out1: std_logic_vector(3 downto 0);
       
  component timer is
     port(t_Clk, Start: in std_logic;
      Date_In: in std_logic_vector(9 downto 0);
      Minute: out std_logic_vector(6 downto 0);
      Seconds: out std_logic_vector(13 downto 0);
      time_out: out std_logic);
  end component timer;
  
  component BCD is
    port(Clk, Direction, Init, Enable: in std_logic;
        Q_Out: out std_logic_vector(3 downto 0));
  end component BCD;
  
  --component timer_convert is
    --port(in_clk: in std_logic;
      --  out_clk: out std_logic);
  --end component timer_convert;
  
  begin
    
  timer1: timer 
    port map(t_Clk => set_clk, Start => start, Date_In => setStop, Minute => minOut, Seconds => secOut, time_out => isEqual);
  
  --Second1: BCD 
    --port map (Clk => set_clk, Direction => '1', Init => u_reset, Enable => u_Enable, Q_out => sec_out1);
     
  --conv_timer: timer_convert
    --port map(in_Clk => set_clk, out_clk => conv_clk);
        
  init: process
    begin
      start <= '1';
      setStop <= "0100110111";
      --u_Enable <= '1';
      --u_reset <= '1', '0' after 5ns;
      wait;
    end process init;
    
  --Setting up 1hz timer--
    
  clk_gen: process
    begin 
      set_clk <= '1';
      wait for 500000000ns;
      set_clk <= '0';
      wait for 500000000ns;
  end process clk_gen;
end architecture test;