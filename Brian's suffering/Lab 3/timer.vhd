library IEEE;
use IEEE.std_logic_1164.all;

entity timer is 
  port(t_Clk, Start: in std_logic;
      Date_In: in std_logic_vector(9 downto 0);
      Minute: out std_logic_vector(6 downto 0);
      Seconds: out std_logic_vector(13 downto 0);
      time_out: out std_logic := '0'); --??????
end entity timer;

architecture behaviour of timer is
  
  signal enable1, enable2, converted_clock, u_reset, u_Enable: std_logic := '0';
  signal sec_out1, sec_out2, min_out: std_logic_vector(3 downto 0) := "0000" ;
  signal sec1_conv, min_conv: std_logic_vector(6 downto 0);
  signal sec2_conv: std_logic_vector(13 downto 7);
  
  component BCD is
    port(Clk, Direction, Init, Enable: in std_logic;
        Q_Out: out std_logic_vector(3 downto 0));
  end component BCD;
  
  component BCD_to_7Seg is
     port (BCD_digit : in std_logic_vector(3 downto 0);
           SevenSeg_out : out std_logic_vector(6 downto 0));
  end component BCD_to_7Seg;
  
--  component timer_convert is
  --   port(in_clk: in std_logic;
    --    out_clk: out std_logic);
 -- end component timer_convert;
  
  --Data_In goes in as 10 bits. 2 left most becomes max minute, the reset becomes max secs
  
  begin
   -- time_switch: timer_convert
     -- port map (in_clk => t_clk, out_clk => converted_clock);
    Second1: BCD 
      port map (Clk => t_Clk, Direction => '1', Init => u_reset, Enable => u_Enable , Q_out => sec_out1); 
    --Second2: BCD
      --port map (Clk => t_Clk, Direction => '1', Init => u_reset, Enable => enable1, Q_out => sec_out2);
    --Minute1: BCD
      --port map (Clk => t_Clk, Direction => '1', Init => u_reset, Enable => enable2, Q_out => min_out);
    --sec1_segment: BCD_to_7Seg
      --port map (BCD_digit => sec_out1, SevenSeg_out => sec1_conv);
    --sec2_segment: BCD_to_7Seg
      --port map (BCD_digit => sec_out2, SevenSeg_out => sec2_conv);
    --min_segment : BCD_to_7Seg
      --port map (BCD_digit => min_out, SevenSeg_out => min_conv);
        
  u_Enable <= '1';
  process(t_Clk)
    begin
      if (sec_out1 = "1001") and (u_Enable = '1') then
        enable1 <= '1';
      elsif (sec_out2 = "0101") and (sec_out1 = "1001") and (u_Enable = '1') then
        enable2 <= '1';
      elsif (sec_out1 = Date_In(3 downto 0)) and (sec_out2 = Date_In(7 downto 4)) and (min_out = Date_In(9 downto 8)) then
        u_Enable <= '0';
        enable1 <= '0';
        enable2 <= '0';
        time_out <= '1';
      else
        enable1 <= '0';
        enable2 <= '0';
      end if;
  end process;
  Seconds <= sec2_conv & sec1_conv; --?????
  Minute <= min_conv;
  
end architecture;